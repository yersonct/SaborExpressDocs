# Comparación estática de rutas y métodos de clientes con OpenAPI — 2026-11-03

## Fuentes

- OpenAPI generado desde Backend `hu-cierre-backend`, SHA `7e6950f009380927ef950402ecb46a5cf5393b9e` (cambios de contrato sin nuevas rutas): [`openapi/backend-openapi-2026-11-03.json`](openapi/backend-openapi-2026-11-03.json).
- Web, rama `hu-cierre-web`, SHA `7d1cd20dae022454c70483f78c621a2285c9eaff`, archivos `.ts`, `.tsx`, `.js`, `.jsx` y `.mjs` bajo `src`.
- Móvil, rama `hu-cierre-movil`, SHA `cbb461dd774b2f239f1d28f4c54a8bc9b91d37a8`, mismos tipos de archivo bajo `src`.
- Comparador con parser AST de TypeScript: [`compare-api-client-roots.mjs`](../scripts/compare-api-client-roots.mjs).

## Resultado reproducible

Desde la carpeta raíz de Docs:

```powershell
node scripts/compare-api-client-roots.mjs 6-api/openapi/backend-openapi-2026-11-03.json ../SaborExpressWeb/src ../SaborExpressMovil/src
```

Salida para estos SHAs:

```text
../SaborExpressWeb/src: 19/19 API roots found in OpenAPI
Resolved client operations: 92
Operations found in OpenAPI: 92/92
../SaborExpressMovil/src: 16/16 API roots found in OpenAPI
Resolved client operations: 47
Operations found in OpenAPI: 47/47
Backend OpenAPI roots: 28
```

El comparador analiza llamadas HTTP en el AST de los clientes, resuelve rutas literales, plantillas y constantes/fábricas de endpoints que puede seguir, y compara verbo y ruta con OpenAPI. Compara rutas sin distinguir mayúsculas y minúsculas y normaliza los nombres de parámetros (`{id}` y `{orderId}`); por eso prueba que existe la misma forma de ruta y verbo, no que los parámetros o payloads sean compatibles. Los conteos son firmas distintas, no solicitudes ejecutadas.

## Límite de la evidencia

La coincidencia estática no valida query/path parameter schemas, modelos ni cuerpos de solicitud/respuesta, códigos y cuerpos de error, multipart, autorización, archivos descargados, conexión, comportamiento del servidor o integración entre repositorios. No reemplaza pruebas contractuales contra una API candidata ni recorridos en staging. Las rutas calculadas dinámicamente que el analizador no puede resolver tampoco quedan certificadas. HU-15 avanza con esta comparación; HU-15/16 siguen parciales hasta ejecutar el contrato real de errores y archivos con Backend, Web y Móvil.
