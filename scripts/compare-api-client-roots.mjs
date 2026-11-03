import fs from "node:fs";
import path from "node:path";
import { createRequire } from "node:module";

const [openApiPath, ...clientSourceDirs] = process.argv.slice(2);

if (!openApiPath || clientSourceDirs.length === 0) {
  console.error(
    "Usage: node scripts/compare-api-client-roots.mjs <openapi.json> <client-src-dir> [client-src-dir ...]",
  );
  process.exit(2);
}

function sourceFiles(directory) {
  return fs.readdirSync(directory, { withFileTypes: true }).flatMap((entry) => {
    const entryPath = path.join(directory, entry.name);
    if (entry.isDirectory()) return sourceFiles(entryPath);
    return /\.(?:ts|tsx|js|jsx|mjs)$/.test(entry.name) ? [entryPath] : [];
  });
}

function loadTypeScript(directory) {
  let current = path.resolve(directory);
  while (true) {
    const packageJson = path.join(current, "package.json");
    if (fs.existsSync(packageJson)) {
      try {
        return createRequire(packageJson)("typescript");
      } catch {
        // Continue upward in case TypeScript is installed at the workspace root.
      }
    }
    const parent = path.dirname(current);
    if (parent === current) break;
    current = parent;
  }
  throw new Error(
    `TypeScript is required to inspect client calls. Install it in or above ${directory}.`,
  );
}

function normalizePath(route) {
  return route
    .split("?")[0]
    .replace(/\{[^/]+\}/g, "{}")
    .replace(/\/{2,}/g, "/")
    .replace(/\/$/, "")
    .toLowerCase();
}

function apiRoutesInText(value) {
  return [...value.matchAll(/\/api\/[a-z0-9_./{}-]*/gi)].map((match) =>
    match[0].replace(/\/$/, ""),
  );
}

function analyzeClient(directory, openApi) {
  const ts = loadTypeScript(directory);
  const files = sourceFiles(directory).map((filePath) => {
    const text = fs.readFileSync(filePath, "utf8");
    return {
      path: path.resolve(filePath),
      text,
      source: ts.createSourceFile(
        filePath,
        text,
        ts.ScriptTarget.Latest,
        true,
        /\.tsx?$/.test(filePath) ? ts.ScriptKind.TSX : ts.ScriptKind.JSX,
      ),
    };
  });
  const filesByPath = new Map(files.map((file) => [file.path, file]));
  const declarations = new Map();

  for (const file of files) {
    const visit = (node) => {
      if (ts.isVariableDeclaration(node) && ts.isIdentifier(node.name)) {
        declarations.set(`${file.path}::${node.name.text}`, node);
      }
      visitEachChild(node, visit);
    };
    const visitEachChild = (node, visitor) => ts.forEachChild(node, visitor);
    visit(file.source);
  }

  function resolveModule(fromFile, moduleText) {
    if (!moduleText.startsWith(".")) return null;
    const base = path.resolve(path.dirname(fromFile), moduleText);
    const candidates = [
      base,
      ...[".ts", ".tsx", ".js", ".jsx"].map((extension) => `${base}${extension}`),
      ...["ts", "tsx", "js", "jsx"].map((extension) =>
        path.join(base, `index.${extension}`),
      ),
    ];
    return candidates.find((candidate) => filesByPath.has(candidate)) ?? null;
  }

  function importedDeclaration(file, localName) {
    for (const statement of file.source.statements) {
      if (!ts.isImportDeclaration(statement) || !statement.importClause) continue;
      const bindings = statement.importClause.namedBindings;
      if (!bindings || !ts.isNamedImports(bindings)) continue;
      const specifier = bindings.elements.find((item) => item.name.text === localName);
      if (!specifier || !ts.isStringLiteral(statement.moduleSpecifier)) continue;
      const importedName = specifier.propertyName?.text ?? specifier.name.text;
      const modulePath = resolveModule(file.path, statement.moduleSpecifier.text);
      if (!modulePath) continue;
      const declaration = declarations.get(`${modulePath}::${importedName}`);
      if (declaration) return { file: filesByPath.get(modulePath), declaration };
    }
    return null;
  }

  function evalExpression(file, expression, parameters = new Map(), depth = 0) {
    if (!expression || depth > 12) return null;
    if (ts.isParenthesizedExpression(expression) || ts.isAsExpression(expression)) {
      return evalExpression(file, expression.expression, parameters, depth + 1);
    }
    if (ts.isStringLiteral(expression) || ts.isNoSubstitutionTemplateLiteral(expression)) {
      return expression.text;
    }
    if (ts.isIdentifier(expression)) {
      if (parameters.has(expression.text)) return parameters.get(expression.text);
      const declaration = declarations.get(`${file.path}::${expression.text}`);
      if (declaration?.initializer) {
        return evalExpression(file, declaration.initializer, parameters, depth + 1);
      }
      const imported = importedDeclaration(file, expression.text);
      if (imported?.declaration.initializer) {
        return evalExpression(
          imported.file,
          imported.declaration.initializer,
          parameters,
          depth + 1,
        );
      }
      return `{${expression.text}}`;
    }
    if (ts.isTemplateExpression(expression)) {
      let value = expression.head.text;
      for (const span of expression.templateSpans) {
        const substitution = evalExpression(file, span.expression, parameters, depth + 1);
        value += substitution ?? `{${span.expression.getText(file.source)}}`;
        value += span.literal.text;
      }
      return value;
    }
    if (ts.isBinaryExpression(expression) && expression.operatorToken.kind === ts.SyntaxKind.PlusToken) {
      const left = evalExpression(file, expression.left, parameters, depth + 1);
      const right = evalExpression(file, expression.right, parameters, depth + 1);
      return left === null || right === null ? null : `${left}${right}`;
    }
    if (ts.isPropertyAccessExpression(expression)) {
      const objectValue = evalExpression(file, expression.expression, parameters, depth + 1);
      if (objectValue !== null && !objectValue.includes("\u0000")) {
        try {
          const object = JSON.parse(objectValue);
          if (Object.hasOwn(object, expression.name.text)) return object[expression.name.text];
        } catch {
          // It is not a serialized object expression; resolve source declarations below.
        }
      }
      const root = expression.expression;
      if (ts.isIdentifier(root)) {
        let objectDeclaration = declarations.get(`${file.path}::${root.text}`);
        let declarationFile = file;
        if (!objectDeclaration) {
          const imported = importedDeclaration(file, root.text);
          objectDeclaration = imported?.declaration;
          declarationFile = imported?.file ?? file;
        }
        const initializer = objectDeclaration?.initializer;
        if (initializer && ts.isObjectLiteralExpression(initializer)) {
          const property = initializer.properties.find(
            (item) => ts.isPropertyAssignment(item) && item.name.getText(declarationFile.source).replace(/["']/g, "") === expression.name.text,
          );
          if (property && ts.isPropertyAssignment(property)) {
            return evalExpression(declarationFile, property.initializer, parameters, depth + 1);
          }
        }
      }
      return null;
    }
    if (ts.isCallExpression(expression)) {
      let declaration = null;
      let declarationFile = file;
      if (ts.isPropertyAccessExpression(expression.expression)) {
        const property = expression.expression;
        if (ts.isIdentifier(property.expression)) {
          let objectDeclaration = declarations.get(`${file.path}::${property.expression.text}`);
          if (!objectDeclaration) {
            const imported = importedDeclaration(file, property.expression.text);
            objectDeclaration = imported?.declaration;
            declarationFile = imported?.file ?? file;
          }
          if (objectDeclaration?.initializer && ts.isObjectLiteralExpression(objectDeclaration.initializer)) {
            const item = objectDeclaration.initializer.properties.find(
              (candidate) => ts.isPropertyAssignment(candidate) && candidate.name.getText(declarationFile.source).replace(/["']/g, "") === property.name.text,
            );
            if (item && ts.isPropertyAssignment(item)) declaration = item.initializer;
          }
        }
      } else if (ts.isIdentifier(expression.expression)) {
        declaration = declarations.get(`${file.path}::${expression.expression.text}`);
        if (!declaration) {
          const imported = importedDeclaration(file, expression.expression.text);
          declaration = imported?.declaration;
          declarationFile = imported?.file ?? file;
        }
      }
      if (declaration && ts.isVariableDeclaration(declaration)) declaration = declaration.initializer;
      if (declaration && (ts.isArrowFunction(declaration) || ts.isFunctionExpression(declaration))) {
        const nextParameters = new Map(parameters);
        declaration.parameters.forEach((parameter, index) => {
          if (ts.isIdentifier(parameter.name)) {
            nextParameters.set(
              parameter.name.text,
              evalExpression(file, expression.arguments[index], parameters, depth + 1) ?? `{${parameter.name.text}}`,
            );
          }
        });
        if (ts.isBlock(declaration.body)) {
          const returnStatement = declaration.body.statements.find(ts.isReturnStatement);
          return evalExpression(declarationFile, returnStatement?.expression, nextParameters, depth + 1);
        }
        return evalExpression(declarationFile, declaration.body, nextParameters, depth + 1);
      }
      return null;
    }
    if (ts.isObjectLiteralExpression(expression)) {
      const properties = {};
      for (const property of expression.properties) {
        if (!ts.isPropertyAssignment(property)) continue;
        const key = property.name.getText(file.source).replace(/["']/g, "");
        const value = evalExpression(file, property.initializer, parameters, depth + 1);
        if (value !== null) properties[key] = value;
      }
      return JSON.stringify(properties);
    }
    return null;
  }

  function methodAndUrl(file, call) {
    const callee = call.expression;
    if (ts.isPropertyAccessExpression(callee)) {
      const method = callee.name.text.toLowerCase();
      if (["get", "post", "put", "patch", "delete", "head", "options"].includes(method)) {
        const url = evalExpression(file, call.arguments[0]);
        if (url !== null) return { method, url };
      }
    }
    if (!ts.isIdentifier(callee) || !["fetch", "fetchauthed", "fetchwithnetworkhandling"].includes(callee.text.toLowerCase())) return null;
    const url = evalExpression(file, call.arguments[0]);
    if (url === null) return null;
    let method = "get";
    const options = call.arguments[1];
    if (options && ts.isObjectLiteralExpression(options)) {
      const methodProperty = options.properties.find(
        (property) => ts.isPropertyAssignment(property) && property.name.getText(file.source).replace(/["']/g, "") === "method",
      );
      if (methodProperty && ts.isPropertyAssignment(methodProperty)) {
        const value = evalExpression(file, methodProperty.initializer);
        if (value) method = value.toLowerCase();
      }
    }
    return { method, url };
  }

  const serverOperations = new Set();
  const serverRoots = new Set();
  for (const [route, pathItem] of Object.entries(openApi.paths ?? {})) {
    const root = route.match(/^\/api\/([^/]+)/i)?.[1]?.toLowerCase();
    if (root) serverRoots.add(root);
    for (const method of Object.keys(pathItem)) {
      if (["get", "post", "put", "patch", "delete", "head", "options"].includes(method.toLowerCase())) {
        serverOperations.add(`${method.toLowerCase()} ${normalizePath(route)}`);
      }
    }
  }

  const observed = new Set();
  const unresolved = new Set();
  const roots = new Set();
  for (const file of files) {
    const visit = (node) => {
      if (ts.isCallExpression(node)) {
        const request = methodAndUrl(file, node);
        if (request) {
          const routes = apiRoutesInText(request.url);
          let route = routes.at(-1);
          if (!route && /^\/[A-Za-z]/.test(request.url)) route = `/api${request.url}`;
          if (route) {
            const root = route.match(/^\/api\/([^/]+)/i)?.[1]?.toLowerCase();
            if (root) roots.add(root);
            observed.add(`${request.method.toLowerCase()} ${normalizePath(route)}`);
          }
        }
      }
      ts.forEachChild(node, visit);
    };
    visit(file.source);
  }

  const missing = [...observed].filter((operation) => !serverOperations.has(operation)).sort();
  return { roots, serverRoots, observed, missing, unresolved };
}

const openApi = JSON.parse(fs.readFileSync(openApiPath, "utf8"));
let hasMissing = false;
for (const clientSourceDir of clientSourceDirs) {
  const result = analyzeClient(clientSourceDir, openApi);
  const missingRoots = [...result.roots].filter((root) => !result.serverRoots.has(root)).sort();
  hasMissing ||= missingRoots.length > 0 || result.missing.length > 0;
  console.log(`${clientSourceDir}: ${result.roots.size - missingRoots.length}/${result.roots.size} API roots found in OpenAPI`);
  console.log(`Resolved client operations: ${result.observed.size}`);
  console.log(`Operations found in OpenAPI: ${result.observed.size - result.missing.length}/${result.observed.size}`);
  if (missingRoots.length) console.log(`Missing roots: ${missingRoots.join(", ")}`);
  if (result.missing.length) console.log(`Missing operations: ${result.missing.join("; ")}`);
  if (result.unresolved.size) console.log(`Unresolved candidate routes: ${[...result.unresolved].sort().join("; ")}`);
}
console.log(`Backend OpenAPI roots: ${new Set(Object.keys(openApi.paths ?? {}).map((route) => route.match(/^\/api\/([^/]+)/i)?.[1]?.toLowerCase()).filter(Boolean)).size}`);
process.exitCode = hasMissing ? 1 : 0;
