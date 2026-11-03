# Pendientes por repositorio y ramas de cierre — 2026-11-03

## Publicación

| Repositorio | Rama activa | SHA publicado | PR | Integración |
|---|---|---|---|---|
| [Backend](https://github.com/yersonct/SaborExpressBack) | [`hu-cierre-backend`](https://github.com/yersonct/SaborExpressBack/tree/hu-cierre-backend) | `7d515ff1be30e4561b2135450f55a296e6945054` | [#86](https://github.com/yersonct/SaborExpressBack/pull/86), borrador | Sigue sin merge. PR incremental sobre la rama de integración existente; PR #85 queda intacto. |
| [Web](https://github.com/yersonct/SaborExpressWeb) | [`hu-cierre-web`](https://github.com/yersonct/SaborExpressWeb/tree/hu-cierre-web) | `7d1cd20dae022454c70483f78c621a2285c9eaff` | [#43](https://github.com/yersonct/SaborExpressWeb/pull/43), borrador | Sigue sin merge. |
| [Móvil](https://github.com/yersonct/SaborExpressMovil) | [`hu-cierre-movil`](https://github.com/yersonct/SaborExpressMovil/tree/hu-cierre-movil) | `cbb461dd774b2f239f1d28f4c54a8bc9b91d37a8` | [#32](https://github.com/yersonct/SaborExpressMovil/pull/32), borrador | Sigue sin merge. |
| [Docs](https://github.com/yersonct/SaborExpressDocs) | [`hu-cierre-docs`](https://github.com/yersonct/SaborExpressDocs/tree/hu-cierre-docs) | HEAD de [PR #9](https://github.com/yersonct/SaborExpressDocs/pull/9) | [#9](https://github.com/yersonct/SaborExpressDocs/pull/9), borrador | Scan y GitGuardian pasaron en `1a14b87`; los commits posteriores requieren observar sus nuevos runs. Rama sin merge. |

Los PR borrador permiten ejecutar CI y revisar los cambios sin integrarlos. No se pidió revisión a una cuenta distinta de `yersonct`. GitHub devolvió solo a `yersonct` como colaborador de cada repo y 404 al consultar protección en las ramas por defecto; las protecciones no están configuradas. La gráfica de contribuyentes aún conserva autores históricos: Backend `lozano2303` (3), Web `CristianJPalma` (1), Móvil `CristianJPalma` (6). El usuario confirmó que esas contribuciones son suyas con identidad errónea; no se reescribió la historia porque HU-01/HU-02 requieren rotación, respaldo privado y coordinación previos.

## Backend

Rama `hu-cierre-backend`; matriz local de 7 roles por sede/recurso incorporada. Security 60/60, QA 62/62, Invoice PDF 11/11 y build Release (0 warnings/errores). OpenAPI actualizado en Docs. El SHA `7d515ff` se publicó; sus checks remotos aún no se han observado.

| HUs | Pendiente restante |
|---|---|
| 01–02 | Acceso a proveedores para revocar/rotar credenciales; respaldo privado, coordinación operativa y decisión segura sobre historial. No modificar proveedor ni historia compartida sin esos pasos. |
| 03, 07 | CI y `Secret scan` pasaron para el SHA anterior `7d8c184`; comprobar los runs de `b48e014`, `7116551` y `7d515ff`. Falta evidencia de HU-07 en `main`. Web/Móvil pasaron scan en sus SHAs publicados y Docs en su SHA previo. La prueba negativa local con secreto artificial detectó un hallazgo. Cualquier hallazgo histórico sigue el proceso seguro. |
| 05 | Probar todos los recursos/endpoints con dos sedes y datos integrados; la matriz local incluye sede, pedidos, resúmenes, pagos, historial, mutaciones por sede, notificaciones, estados de mesa y liberación administrativa. |
| 06, 09 | CI del SHA anterior `7d8c184` pasó; resultados para SHA posteriores y revisión independiente pendientes. Protección de rama ausente. PR #86 sigue en borrador, sin merge. |
| 10–13 | Smoke limpio `/health`/readiness sin resultado verificable; staging, reversión, migración aplicada en DB aislada y backup/restore medidos pendientes. El daemon Docker no estaba disponible. |
| 15–17 | OpenAPI del Backend SHA `7d515ff` y comparación estática AST de 92 firmas Web + 47 Móvil (ruta+método) coinciden. Falta contrato runtime de schemas, payloads, errores/archivos y matriz CORS/JWT/privacidad en staging. |
| 18–23 | Flujos completos de 7 roles × 2 sedes, Wompi/facturas, cocina, caja, domicilios, catálogo y recuperación de red requieren staging/sandbox. |

## Web

Rama `hu-cierre-web`; lint, TypeScript, 5/5 pruebas, i18n y build pasan. Auditoría Playwright local: 11 pantallas, 1/1 prueba; LCP máximo 400 ms, CLS máximo 0.0327 y cero controles visibles sin etiqueta. Usa build local y API sintética.

| HUs | Pendiente restante |
|---|---|
| 08 | `Web quality` y `Secret scan` del PR #43 pasaron; staging y revisión siguen pendientes. |
| 09–11 | Revisión independiente, configurar protección, clon limpio completo y smoke/reversión en staging. |
| 15–16 | Las 92 firmas Web y 47 Móvil de ruta+método coinciden con OpenAPI del Backend `7d515ff`. Faltan schemas, payloads, respuestas, errores y archivos reales verificados contra Backend/Móvil en ejecución. |
| 18–23 | Flujos integrados por rol, sede, pago, red y recuperación contra backend/staging. |
| 25 | Auditoría Web local registrada; faltan laboratorio reproducible en ambiente objetivo, criterio institucional y auditoría WCAG completa. |
| 30 | Añadir SHA final de los cuatro repos, checks CI y evaluación al paquete institucional. |

## Móvil

Rama `hu-cierre-movil`; lint, TypeScript, 8/8 pruebas e i18n pasan. Export Android limpio desde el SHA fuente `09e60c9d749ef1e4b1f2a0c18313792374580cc3`; evidencia en `docs/cierre/evidencia-local-hu-2026-11-03.md`.

| HUs | Pendiente restante |
|---|---|
| 08 | CI, `Secret scan` y export Android del PR #32 pasaron; dispositivo/staging siguen pendientes. |
| 09–11 | Revisión independiente, protección, clon reproducible, EAS/release, smoke y reversión en staging. |
| 15–16 | Las 47 firmas Móvil de ruta+método coinciden con OpenAPI del Backend `7d515ff`; faltan schemas, payloads, respuestas, errores y archivos reales verificados en ejecución con Backend/Web. |
| 18–23 | Flujos reales por rol para pedidos/cocina/caja/pagos/domicilios/catálogo, desconexión y sincronización. |
| 24 | APK de producción y hardware físico (BLE, impresora, QR, sesión y reconexión): no hay keystore/EAS productivo, `adb` ni dispositivo en el entorno. |
| 25 | Medición reproducible de accesibilidad/rendimiento en los dispositivos definidos. |
| 30 | SHA final, evidencia CI y evidencia de dispositivo para evaluación. |

`app.json` tenía un diff local previo. Quedó sin stage ni commit y requiere revisión de su responsable. No forma parte del PR #32.

## Docs

Rama `hu-cierre-docs`; DER/diccionario/SQL derivados de migraciones, OpenAPI reexportado desde Backend SHA `7d515ff`, comparación AST de métodos/rutas de clientes, guía técnica y matriz HU actualizados. La evidencia generada representa el código/migraciones y no confirma un esquema desplegado.

| HUs | Pendiente restante |
|---|---|
| 14 | Conciliar migraciones, DER y diccionario con esquema de base desplegada. |
| 26–27 | Completar RF institucional y manual de usuario; mantener KPIs ligados a fuente y método. No inventar IDs ni resultados. |
| 28 | Añadir issues y responsables confirmados; revisión independiente pendiente. Los commits nuevos son de `yersonct`; para cambiar las gráficas históricas hace falta cumplir primero la rotación/respaldo/coordinación requeridos por HU-01/HU-02. |
| 29 | Obtener el anexo institucional que enumera los 28 hallazgos. El resumen actual no permite desglosarlos. |
| 30 | Los cuatro SHAs y PR están publicados. Los checks conocidos pasaron en SHAs anteriores; faltan runs de Backend/Docs posteriores, evaluación institucional, staging, hardware y anexo. |

## No declarar como cerrado

Las pruebas locales no sustituyen CI, revisión independiente, base aislada, staging, dispositivo o aprobación. El [informe por HU](CIERRE-HU-2026-11-03.md) registra los 30 estados, comandos, evidencia y límites observados. Ninguna rama fue mergeada.
