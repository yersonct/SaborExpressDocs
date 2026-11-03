# Comparación estática de rutas de clientes y OpenAPI — 2026-11-03

## Fuentes y método

- OpenAPI exportado desde Backend, rama `hu-cierre-backend`, SHA fuente `7d8c184efff713a79e51253bbd2f9c2e6d9d4046`: [`openapi/backend-openapi-2026-11-03.json`](openapi/backend-openapi-2026-11-03.json).
- Web: fuente `.ts`, `.tsx`, `.js`, `.jsx` y `.mjs` bajo `src`.
- Móvil: mismos tipos de archivo bajo `src`.
- Script: [`compare-api-client-roots.mjs`](../scripts/compare-api-client-roots.mjs).

El script extrae segmentos literales `/api/<raíz>` de fuentes y comentarios, normaliza mayúsculas/minúsculas y compara cada raíz con la primera parte del path OpenAPI. La comparación comprobó 15/15 raíces únicas de Web y 20/20 de Móvil; no encontró raíz sin correspondencia. El OpenAPI contiene 269 paths, 346 operaciones, 84 esquemas y 28 raíces de Backend.

Para repetir desde la carpeta de este repositorio en el mismo workspace:

```powershell
node scripts/compare-api-client-roots.mjs openapi\backend-openapi-2026-11-03.json ..\SaborExpressWeb\src ..\SaborExpressMovil\src
```

El resultado es una comprobación estática de nombres de recursos. No valida verbo HTTP, parámetros, modelos, códigos/cuerpos de error, carga de archivos, autorización, despliegue ni comportamiento de servidor. Los comentarios del código también se inspeccionan, por lo que esta salida no equivale a un análisis AST de llamadas activas.

## Raíces detectadas

| Cliente | Raíces detectadas | Correspondencia |
|---|---|---:|
| Web | `auth`, `branch-settings`, `branches`, `categories`, `deliveries`, `employees`, `notifications`, `order-details`, `orders`, `payments`, `products`, `reviews`, `tables`, `telemetry`, `v1` | 15/15 |
| Móvil | `addresses`, `auth`, `branch-settings`, `branches`, `cashclosures`, `customers`, `deliveries`, `employee-schedules`, `employees`, `invoices`, `notifications`, `order-details`, `orders`, `payments`, `products`, `public`, `reviews`, `tables`, `user-preferences`, `user-settings` | 20/20 |

## Pendiente contractual

Para aceptar compatibilidad hay que generar/validar tests de operación, payloads, multipart, errores de validación/autorización, descargas y recuperación de red contra una instancia de API candidata. La prueba integrada debe ejecutarse junto a Backend y Móvil en staging o ambiente aislado autorizado.
