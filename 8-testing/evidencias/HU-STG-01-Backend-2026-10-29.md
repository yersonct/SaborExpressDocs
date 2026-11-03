# Evidencia parcial de staging y carga API — HU-STG-01

**Estado:** evidencia histórica parcial para el SHA `ac2b39e`; no demuestra el candidato actual ni cierra por sí sola HU-25. Los artefactos originales de k6 se generaron en la estación de trabajo y no se copiaron a este repositorio. Esta ficha conserva un resumen derivado de esos JSON y enlaza el smoke remoto verificable.

## Smoke de staging

- Entorno: servicio Render `staging`.
- SHA desplegado/probado: `ac2b39e1a971c05998cb8dd0dd5a5e2f3295ba22`.
- Ejecución: [workflow staging-release-smoke, 2026-10-29](https://github.com/yersonct/SaborExpressBack/actions/runs/40950065311/job/123715501114), resultado `success`.
- El workflow validó que el mismo deployment siguiera activo antes y después del smoke. El smoke comprobó `GET /health`, `GET /health/ready` (base conectada y migraciones aplicadas), inicio de sesión sintético y lecturas de configuración de sede, pedido, pagos, domicilio y factura.
- El flujo no inició pagos ni creó pedidos. No es evidencia de una reversión, ni de que el SHA actual `7e6950f` se haya desplegado en staging.
- `ac2b39e` es antecesor del candidato Backend `7e6950f`; los cambios posteriores aún requieren despliegue/smoke propios.

## Perfil y resúmenes k6 existentes

Los tres resúmenes disponibles corresponden al mismo SHA `ac2b39e`, región registrada Neiva, Colombia, lectura pública de `/health`, sedes, categorías y productos, k6 `v2.3.0`, 15 VUs, calentamiento 120 s, ramp-up 120 s, carga sostenida 600 s, descenso 30 s y pausa de 1 s.

| Inicio UTC | Solicitudes | p95 servidor (ms) | Error API | HTTP fallidos | Checks fallidos | Resultado de thresholds |
|---|---:|---:|---:|---:|---:|---|
| 2026-10-29 19:33:35 | 25.176 | 60,711 | 0,004072 % | 0,015888 % | 4 | Falla `rate==0`: una muestra sin `Server-Timing` (0,000040717). `p(95)<300` y `rate<0.01` no se cruzaron. |
| 2026-10-29 21:08:49 | 27.044 | 58,5325 | 0 % | 0 % | 0 | Todos los thresholds quedaron sin cruzar; checks 0/27.044 fallidos. |
| 2026-10-29 21:27:37 | 27.244 | 60,2 | 0,003804 % | 0,003671 % | 1 | Falla `rate==0`: una muestra sin `Server-Timing` (0,000038040). `p(95)<300` y `rate<0.01` no se cruzaron. |

En la corrida de las 21:08, los p95 de servidor por endpoint fueron: health 0,21 ms; sedes públicas 96,541 ms; categorías 17,321 ms; productos 19,252 ms. El p95 de cliente API fue 191,695 ms e incluye red.

En el resumen JSON de k6 `v2.3.0`, `false` indica que el threshold no se cruzó y `true` que sí se cruzó. La documentación de k6 define el estado como umbral cruzado o no cruzado ([referencia](https://grafana.com/docs/k6/latest/results-output/end-of-test/custom-summary/#metric-schema)); una reproducción sintética local también mostró el threshold aprobado con valor `false`. Por tanto, la corrida de las 21:08 pasó sus thresholds configurados y sus checks para ese SHA histórico. Las corridas de las 19:33 y 21:27 no pasan el gate: se cruzó `server_timing_missing_rate rate==0` y registraron 4 y 1 checks fallidos, respectivamente.

La corrida aprobada no valida el candidato actual ni sustituye la evidencia Web, Móvil o de un dispositivo físico. Para cerrar HU-25 se debe asociar una ejecución reproducible al SHA final y completar los criterios aplicables a Web y Móvil.

Las carpetas locales originales fueron `EVIDENCIAS-K6-HU-STG-01/20261029T193335Z`, `20261029T210848Z` y `20261029T212737Z`. No había `web-summary.json`, informe completo ni medición en dispositivo móvil en esas carpetas. Esta ficha no sustituye la medición del candidato actual, el recorrido Web ni el ensayo físico Móvil.
