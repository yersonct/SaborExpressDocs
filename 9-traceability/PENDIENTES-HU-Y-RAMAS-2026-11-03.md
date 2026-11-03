# Pendientes por repositorio y ramas de cierre — 2026-11-03

## Publicación

| Repositorio                                            | Rama activa                                                                                 | SHA publicado                                                       | PR                                                                    | Integración                                                                                                                               |
| ------------------------------------------------------ | ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------- | --------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| [Backend](https://github.com/yersonct/SaborExpressBack) | [`hu-cierre-backend`](https://github.com/yersonct/SaborExpressBack/tree/hu-cierre-backend) | `7e6950f009380927ef950402ecb46a5cf5393b9e`                        | [#86](https://github.com/yersonct/SaborExpressBack/pull/86), borrador  | Candidato con 13 commits de `yersonct` sobre `main`; sin merge. #86 todavía apunta a la base `codex/hu-cierre-04-06-integracion`. El intento de retargetearlo a `main` y actualizar su cuerpo devolvió 403. #85 sigue abierto porque GitHub no permitió actualizar PR. |
| [Web](https://github.com/yersonct/SaborExpressWeb)      | [`hu-cierre-web`](https://github.com/yersonct/SaborExpressWeb/tree/hu-cierre-web)          | `aa5cb8d04d5af03e91e250bee227ea9c7c190e13`                        | [#43](https://github.com/yersonct/SaborExpressWeb/pull/43), borrador   | Sigue sin merge.                                                                                                                           |
| [Móvil](https://github.com/yersonct/SaborExpressMovil) | [`hu-cierre-movil`](https://github.com/yersonct/SaborExpressMovil/tree/hu-cierre-movil)    | `af52bbaf184404bb9f660b9dfa63c66958768bb4`                        | [#32](https://github.com/yersonct/SaborExpressMovil/pull/32), borrador | Sigue sin merge.                                                                                                                           |
| [Docs](https://github.com/yersonct/SaborExpressDocs)    | [`hu-cierre-docs`](https://github.com/yersonct/SaborExpressDocs/tree/hu-cierre-docs)       | HEAD de [PR #9](https://github.com/yersonct/SaborExpressDocs/pull/9) | [#9](https://github.com/yersonct/SaborExpressDocs/pull/9), borrador    | `scan` y GitGuardian pasaron en `b725d8b`; el commit posterior de esta matriz requiere consultar sus checks por SHA. Rama sin merge. |

Los PR borrador permiten ejecutar CI y revisar los cambios sin integrarlos. No se pidió revisión a una cuenta distinta de `yersonct`. GitHub devolvió solo a `yersonct` como colaborador de cada repo y 404 al consultar protección en las ramas por defecto; las protecciones no están configuradas. La gráfica de contribuyentes aún conserva autores históricos: Backend `lozano2303` (3), Web `CristianJPalma` (1), Móvil `CristianJPalma` (6). El usuario confirmó que esas contribuciones son suyas con identidad errónea; no se reescribió la historia porque HU-01/HU-02 requieren rotación, respaldo privado y coordinación previos.

## Backend

Rama `hu-cierre-backend`; matriz local de roles/sedes, filtro de error HTTP y respuestas de archivos incorporados. Security 65/65, QA 62/62, Invoice PDF 11/11 y build Release (0 warnings/errores). El SHA `7e6950f` se publicó; `verify`, `scan` y GitGuardian pasaron en GitHub.

| HUs    | Pendiente restante                                                                                                                                                                                                                                                                                               |
| ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 01–02 | Acceso a proveedores para revocar/rotar credenciales; respaldo privado, coordinación operativa y decisión segura sobre historial. No modificar proveedor ni historia compartida sin esos pasos.                                                                                                                |
| 03, 07 | CI, `Secret scan` y GitGuardian pasaron para el candidato `7e6950f`; la prueba negativa local detectó un secreto artificial. HU-07 aún pide run en `main`; historial completo y rotaciones siguen el proceso seguro de HU-01/02. Web/Móvil y Docs pasaron sus checks en los SHAs candidatos publicados. |
| 05     | Probar todos los recursos/endpoints con dos sedes y datos integrados; la matriz local incluye sede, pedidos, resúmenes, pagos, historial, mutaciones por sede, notificaciones, estados de mesa y liberación administrativa.                                                                                    |
| 06, 09 | CI del candidato `7e6950f` pasó; revisión independiente pendiente. Protección de rama ausente. PR #86 sigue en borrador, sin merge.                                                                                                                                                                         |
| 10–13 | Smoke local: `/health` 200 y `/health/ready` 503 por migraciones pendientes. Smoke remoto staging `success` en SHA antecesor `ac2b39e` comprobó readiness y lecturas; falta repetir sobre `7e6950f`, probar reversión, ensayar migración en DB aislada y medir backup/restore. No se aplicó migración en esta tarea. [Evidencia staging/k6](../8-testing/evidencias/HU-STG-01-Backend-2026-10-29.md). |
| 15–17 | OpenAPI del Backend SHA `7e6950f` y comparación estática AST de 92 firmas Web + 47 Móvil (ruta+método) coinciden. Se añadieron pruebas HTTP locales para error 404 y descarga PDF. Falta contrato runtime de schemas, cargas inválidas/clientes y matriz CORS/JWT/privacidad en staging.                 |
| 18–23 | Flujos completos de 7 roles × 2 sedes, Wompi/facturas, cocina, caja, domicilios, catálogo y recuperación de red requieren staging/sandbox.                                                                                                                                                                    |

## Web

Rama `hu-cierre-web`; en el SHA `aa5cb8d`, lint, TypeScript, 7/7 pruebas, i18n y build local pasan. Playwright local: 11 pantallas, 1/1 prueba; LCP máximo 400 ms, CLS máximo 0.0327 y cero controles visibles sin etiqueta. Usa API sintética. CI remoto: `Web quality`, `Secret scan`, GitGuardian y Vercel Preview Comments terminaron `success`.

| HUs    | Pendiente restante                                                                                                                                                                                            |
| ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 08     | En `aa5cb8d`, `Web quality`, `Secret scan`, GitGuardian y Vercel Preview Comments pasaron. Staging y revisión siguen pendientes.                                                                       |
| 09–11 | Revisión independiente, configurar protección, clon limpio completo y smoke/reversión en staging.                                                                                                          |
| 15–16 | Las 92 firmas Web y 47 Móvil de ruta+método coinciden con OpenAPI del Backend `7e6950f`. Faltan schemas, payloads, respuestas, errores y archivos reales verificados contra Backend/Móvil en ejecución. |
| 18–23 | Flujos integrados por rol, sede, pago, red y recuperación contra backend/staging.                                                                                                                            |
| 25     | Auditoría Web local registrada. De tres mediciones k6 API staging en `ac2b39e`, una pasó thresholds y checks; dos cruzaron el threshold `Server-Timing` ausente y tuvieron checks fallidos. Falta repetir con el candidato actual y completar criterios Web/Móvil y medición física. |
| 30     | Añadir SHA final de los cuatro repos, checks CI y evaluación al paquete institucional.                                                                                                                      |

## Móvil

Rama `hu-cierre-movil`; en el SHA `af52bba`, lint, TypeScript, 8/8 pruebas e i18n pasan. Export Android limpio desde el SHA fuente `09e60c9d749ef1e4b1f2a0c18313792374580cc3`; evidencia en `docs/cierre/evidencia-local-hu-2026-11-03.md`. CI remoto, secret scan y GitGuardian terminaron `success`; el job publicó el artefacto del build.

| HUs    | Pendiente restante                                                                                                                                                                             |
| ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 08     | `Mobile quality`, `Secret scan` y GitGuardian pasaron en `af52bba`; se publicó el artefacto del build. Dispositivo/staging siguen pendientes.                                           |
| 09–11 | Revisión independiente, protección, clon reproducible, EAS/release, smoke y reversión en staging.                                                                                           |
| 15–16 | Las 47 firmas Móvil de ruta+método coinciden con OpenAPI del Backend `7e6950f`; faltan schemas, payloads, respuestas, errores y archivos reales verificados en ejecución con Backend/Web. |
| 18–23 | Flujos reales por rol para pedidos/cocina/caja/pagos/domicilios/catálogo, desconexión y sincronización.                                                                                     |
| 24     | APK de producción y hardware físico (BLE, impresora, QR, sesión y reconexión): no hay keystore/EAS productivo, `adb` ni dispositivo en el entorno.                                       |
| 25     | Medición reproducible de accesibilidad/rendimiento en los dispositivos definidos.                                                                                                             |
| 30     | SHA final, evidencia CI y evidencia de dispositivo para evaluación.                                                                                                                           |

`app.json` tenía un diff local previo. Quedó sin stage ni commit y requiere revisión de su responsable. No forma parte del PR #32.

## Docs

Rama `hu-cierre-docs`; DER/diccionario/SQL derivados de migraciones, OpenAPI reexportado desde Backend SHA `7e6950f`, comparación AST de métodos/rutas de clientes, guía técnica y matriz HU actualizados. La evidencia generada representa el código/migraciones y no confirma un esquema desplegado.

| HUs    | Pendiente restante                                                                                                                                                                                                                                      |
| ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 14     | Conciliar migraciones, DER y diccionario con esquema de base desplegada.                                                                                                                                                                                |
| 26–27 | Completar RF institucional y manual de usuario; mantener KPIs ligados a fuente y método. No inventar IDs ni resultados.                                                                                                                                |
| 28     | Añadir issues y responsables confirmados; revisión independiente pendiente. Los commits nuevos son de `yersonct`; para cambiar las gráficas históricas hace falta cumplir primero la rotación/respaldo/coordinación requeridos por HU-01/HU-02. |
| 29     | Obtener el anexo institucional que enumera los 28 hallazgos. El resumen actual no permite desglosarlos.                                                                                                                                                 |
| 30     | Los cuatro SHAs y PR están publicados. Backend `7e6950f` y Docs `6b5497d` tienen checks remotos success; cualquier SHA posterior requiere su run. Siguen pendientes evaluación institucional, staging, hardware y anexo.                          |

## No declarar como cerrado

Las pruebas locales no sustituyen CI, revisión independiente, base aislada, staging, dispositivo o aprobación. El [informe por HU](CIERRE-HU-2026-11-03.md) registra los 30 estados, comandos, evidencia y límites observados. Ninguna rama fue mergeada.
