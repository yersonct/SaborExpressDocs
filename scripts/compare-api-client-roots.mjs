import fs from "node:fs";
import path from "node:path";

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

function apiRootsInSource(directory) {
  const roots = new Set();
  for (const file of sourceFiles(directory)) {
    const content = fs.readFileSync(file, "utf8");
    for (const match of content.matchAll(/\/api\/([a-z0-9_-]+)/gi)) {
      roots.add(match[1].toLowerCase());
    }
  }
  return roots;
}

const openApi = JSON.parse(fs.readFileSync(openApiPath, "utf8"));
const serverRoots = new Set(
  Object.keys(openApi.paths ?? {})
    .map((route) => route.match(/^\/api\/([^/]+)/i)?.[1]?.toLowerCase())
    .filter(Boolean),
);
let missingCount = 0;

for (const clientSourceDir of clientSourceDirs) {
  const clientRoots = apiRootsInSource(clientSourceDir);
  const missing = [...clientRoots].filter((root) => !serverRoots.has(root)).sort();
  missingCount += missing.length;
  console.log(
    `${clientSourceDir}: ${clientRoots.size - missing.length}/${clientRoots.size} API roots found in OpenAPI`,
  );
  console.log(`Roots: ${[...clientRoots].sort().join(", ")}`);
  if (missing.length) console.log(`Missing: ${missing.join(", ")}`);
}

console.log(`Backend OpenAPI roots: ${serverRoots.size}`);
process.exitCode = missingCount === 0 ? 0 : 1;
