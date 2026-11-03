# Matriz de trazabilidad RF → HU → repositorio → prueba → evidencia

**Proyecto:** SaborExpress · **Corte:** 3 de noviembre de 2026 · **Responsable del cambio:** yersonct

## Regla de aceptación

Esta matriz separa la existencia del código, la ejecución de suites y la aceptación de cada requisito. Los casos `CP-*` son los casos definidos en la especificación; no se consideran ejecutados por aparecer aquí. Las suites descritas abajo sí se ejecutaron, pero sus resultados agregados no prueban por sí solos cada criterio de cada RF. Por esa razón, ningún RF se declara `PASS` o aceptado en este corte. La asociación RF→HU es una propuesta funcional para organizar la evidencia y debe conciliarse con el anexo institucional de los 28 hallazgos, que no está disponible.

## Líneas base y PR

Los códigos B/W/M/D usados en la matriz remiten a estas líneas base publicadas. Las ramas y PR siguen abiertas; no se hizo merge.

| Clave | Repositorio / rama | SHA candidato publicado | PR | Checks observados |
|---|---|---|---|---|
| B | [Backend · `hu-cierre-backend`](https://github.com/yersonct/SaborExpressBack/tree/hu-cierre-backend) | `7e6950f009380927ef950402ecb46a5cf5393b9e` | [#86](https://github.com/yersonct/SaborExpressBack/pull/86), draft | `verify`, `scan`, GitGuardian: success en este SHA. |
| W | [Web · `hu-cierre-web`](https://github.com/yersonct/SaborExpressWeb/tree/hu-cierre-web) | `aa5cb8d04d5af03e91e250bee227ea9c7c190e13` | [#43](https://github.com/yersonct/SaborExpressWeb/pull/43), draft | Web quality, secret scan, GitGuardian y Preview Comments: success en este SHA. |
| M | [Móvil · `hu-cierre-movil`](https://github.com/yersonct/SaborExpressMovil/tree/hu-cierre-movil) | `af52bbaf184404bb9f660b9dfa63c66958768bb4` | [#32](https://github.com/yersonct/SaborExpressMovil/pull/32), draft | Mobile quality, secret scan y GitGuardian: success en este SHA. El build remoto no es APK de producción. `app.json` quedó fuera del commit. |
| D | [Docs · `hu-cierre-docs`](https://github.com/yersonct/SaborExpressDocs/tree/hu-cierre-docs) | HEAD de [PR #9](https://github.com/yersonct/SaborExpressDocs/pull/9); candidato anterior a esta matriz: `e5b8d265a6358e421566795d85d52d0fb4c83ed9` | [#9](https://github.com/yersonct/SaborExpressDocs/pull/9), draft | `Secret scan` del candidato anterior: success. El SHA que contiene esta actualización se verifica luego del push. |

El SHA del commit que contiene esta matriz se consulta en el HEAD de PR #9 luego del push. Como el documento forma parte de ese mismo commit, su contenido no puede incluir su propio SHA resultante sin cambiarlo; la referencia inmutable es el PR y su historial de commits.

## RF y estado de verificación

`HU relacionadas` es una agrupación por área funcional, no una afirmación de aceptación ni una relación aprobada por el anexo. `CP-*` identifica el caso de la especificación. En `Verificación` se indica el alcance ejecutado y la brecha que impide cerrar el RF.

| RF | Fuente y repositorio | HU relacionadas (propuesta) | CP definido | Verificación al corte / evidencia | Estado |
|---|---|---|---|---|---|
| RF-01 Inicio de sesión | `AuthController`, API B; clientes W/M | 15–18 | CP-01, CP-02, CP-03 | Suites locales Backend y Web/Móvil pasaron en sus SHA de línea base; no hay resultado de aceptación CP-01/02/03 ligado a una sesión real. Ver E-BACK, E-WEB, E-MOB. | Parcial |
| RF-02 Recuperación de contraseña | `AuthController`, API B; cliente W/M | 15–17 | CP-02, CP-28 | No se encontró evidencia por requisito de envío, expiración, uso único y restablecimiento. La suite agregada no cierra el flujo de correo real. Ver E-BACK. | Parcial |
| RF-03 Roles y permisos | Controllers/servicios Roles, Permissions y UserRoles, B; interfaz W | 04–05 | CP-05, CP-29 | QA y Security Backend pasaron; sí existe prueba local de escrituras globales reservadas a GERENTE. Falta matriz completa de endpoints, roles y dos sedes. Ver E-BACK. | Parcial |
| RF-04 Crear/actualizar sedes | `BranchesController`, B; interfaz W | 05, 18–23 | CP-05 | Hay cobertura en suites agregadas, pero no evidencia de aceptación por operación ni comparación entre dos sedes. Ver E-BACK. | Parcial |
| RF-05 Consultar sede asignada | `GET /api/Branches/mine`, B; selector W/M | 05, 18–23 | CP-05 | La matriz Security cubre acceso por sede en escenarios locales; falta la prueba integrada de usuario A contra datos de B. Ver E-BACK. | Parcial |
| RF-06 Gestionar empleados | `EmployeesController`, B; equipo W | 05, 18–23 | CP-05 | Suites Backend pasaron; falta una matriz completa de roles/sedes y un recorrido integrado en staging. Ver E-BACK. | Parcial |
| RF-07 Horarios y turnos | `EmployeeSchedulesController`, B; vistas W/M | 18–23 | CP-22, CP-30 | El caso está definido; no hay reporte de ejecución aislada por rol/sede. Ver E-BACK y E-WEB/E-MOB como suites generales. | Parcial |
| RF-08 Gestionar categorías/productos | `ProductsController` y `CategoriesController`, B; catálogo W/M | 22–23 | CP-06, CP-07 | Suites pasaron; no hay recorrido integrado de edición y lectura desde Web/Móvil en dos sedes. Ver E-BACK, E-WEB, E-MOB. | Parcial |
| RF-09 Consultar productos por sede/categoría | `GET /api/Products`, B; catálogo W/M | 22–23 | CP-06 | Export OpenAPI y comparación de rutas no prueban el contenido por sede; falta ejecución de aceptación con datos de dos sedes. Ver E-OAS. | Parcial |
| RF-10 Crear pedidos | `POST /api/Orders`, B; flujos cliente/mesero W/M | 18, 23 | CP-08, CP-09, CP-10 | Hay pruebas locales del dominio y clientes con API sintética; no se ejecutó la transacción integrada con Backend/staging. Ver E-BACK, E-WEB, E-MOB. | Parcial |
| RF-11 Filtrar pedidos | Rutas `GET /api/Orders`, B; vistas de pedidos W/M | 18–23 | CP-05, CP-08, CP-12 | Rutas coinciden en análisis estático; falta validar filtros, autorización y respuesta contra el servicio real. Ver E-OAS. | Parcial |
| RF-12 Actualizar estado de pedido | `PATCH /api/Orders/{id}/status`, B; cocina/mesero W/M | 19, 23 | CP-13 | Suites agregadas y flujo local disponibles; no hay recorrido integrado de preparación con dos sedes ni recuperación de red. Ver E-BACK, E-WEB, E-MOB. | Parcial |
| RF-13 Cancelar pedido propio | `PATCH /api/Orders/{id}/cancel-mine`, B; cliente W/M | 18, 23 | CP-11, CP-12 | La suite local no se asocia aquí a todos los estados, pago y propiedad exigidos por el CP. Falta la matriz ejecutada en servicio integrado. Ver E-BACK. | Parcial |
| RF-14 Registrar/consultar pagos por turno | `PaymentsController`, B; caja W/M | 20, 23 | CP-19 | Pruebas locales de pagos/facturas existen; falta flujo de caja real con conciliación y turno en sandbox/staging. Ver E-BACK. | Parcial |
| RF-15 Iniciar pago Wompi | `POST /api/Payments/wompi/init`, B; checkout W/M | 20 | CP-14, CP-17 | Pruebas locales no equivalen a pago externo; no hay evidencia de sandbox/credenciales renovadas ni conciliación. Ver E-BACK. | Parcial |
| RF-16 Webhook autenticado | `POST /api/Payments/wompi/webhook`, B | 20 | CP-14, CP-15, CP-16 | No se adjunta ejecución contractual de firma válida/inválida contra sandbox en este corte. Ver E-BACK. | Parcial |
| RF-17 Cobro QR desde caja | `POST /api/Payments/wompi/cashier-init`, B; caja M/W | 20 | CP-18 | Falta QR de sandbox, ciclo de conciliación y respuesta de error del proveedor, ejecutados con el cliente. Ver E-BACK y E-MOB/E-WEB. | Parcial |
| RF-18 Asignar repartidor | `POST /api/Deliveries`, B; despacho W/M | 21, 23 | CP-20 | Cobertura local parcial; falta recorrido integrado de asignación por rol y sede. Ver E-BACK, E-WEB, E-MOB. | Parcial |
| RF-19 Cambiar estado de entrega | `PATCH /api/Deliveries/{id}/status`, B; repartidor M/W | 21, 23 | CP-20 | Falta verificar permisos, estados permitidos y reconexión en entorno integrado. Ver E-BACK, E-MOB. | Parcial |
| RF-20 Calificar entrega | `POST /api/Deliveries/{id}/rating`, B; cliente M/W | 21 | CP-21 | No se adjunta corrida de aceptación que pruebe propiedad de la entrega, duplicado y respuesta de error. Ver E-BACK, E-MOB. | Parcial |
| RF-21 Consultar notificaciones | `NotificationsController`, B; centro de notificaciones W/M | 19, 23 | CP-22, CP-31 | Pruebas locales/código no cubren entrega real, lectura, reconexión y visibilidad entre usuarios. Ver E-BACK, E-WEB, E-MOB. | Parcial |
| RF-22 Tablero de cocina | `PublicKitchenController`, B; tablero W/M | 19, 23 | CP-22 | Falta recorrido integrado del tablero con actualización y recuperación de conexión en la sede. Ver E-BACK, E-MOB. | Parcial |
| RF-23 Sede cercana | `GET /api/Branches/nearest`, B; ubicación W/M | 18, 22 | CP-05, CP-32 | La firma de ruta se compara estáticamente; no se reporta prueba con ubicación/resultado y errores reales. Ver E-OAS. | Parcial |
| RF-24 Mesas, pedidos y menú diario | Controllers de Tables/Orders/DailyMenu, B; vistas W/M | 18, 22–23 | CP-08, CP-33 | Suites locales cubren partes; falta recorrido por rol y sede a través de API y clientes. Ver E-BACK, E-WEB, E-MOB. | Parcial |
| RF-25 Reportes operativos | `/reports`, W; API B | 05, 25, 27 | CP-27, CP-34 | Auditoría local de 11 pantallas Web aprobó accesibilidad básica y tiempos del navegador con API sintética. No acredita exactitud de indicadores ni datos de producción. Ver E-A11Y. | Parcial |

## Registro de ejecuciones y límites

| Evidencia | Ejecución observada | SHA / fecha | Alcance y límite |
|---|---|---|---|
| E-BACK | Backend Security 65/65, QA 62/62 e Invoice PDF 11/11 | B · 2026-11-03 | Pruebas locales de unidades/regresión; no son aceptación individual de los 25 RF ni prueba de staging. Rutas de pruebas: [`Security.Tests`](https://github.com/yersonct/SaborExpressBack/tree/hu-cierre-backend/tests/SaborExpressBack.Security.Tests), [`QA.Tests`](https://github.com/yersonct/SaborExpressBack/tree/hu-cierre-backend/tests/SaborExpressBack.QA.Tests), [`InvoicePdf.Tests`](https://github.com/yersonct/SaborExpressBack/tree/hu-cierre-backend/tests/SaborExpressBack.InvoicePdf.Tests). |
| E-OAS | OpenAPI de B comparada con clientes: Web 92/92 y Móvil 47/47 firmas ruta+método | B/W/M · 2026-11-03 | Comparación estática de rutas; no valida schemas, payloads, errores, permisos ni cargas. [Informe](../6-api/COMPARACION-OPENAPI-CLIENTES-2026-11-03.md). |
| E-WEB | Web: 7/7 pruebas locales; workflow remoto de calidad pasó en W | W · 2026-11-03 | Suite y build; E2E existentes usan API sintética. No prueba integración de producción/staging. |
| E-MOB | Móvil: 8/8 pruebas locales; workflow remoto de calidad pasó en M | M · 2026-11-03 | Suite local y artefacto del workflow; no equivale a APK de producción instalado en equipo físico. `app.json` local permanece sin incluir. |
| E-A11Y | Playwright en 11 pantallas, 1/1 prueba | SHA `7d1cd20dae022454c70483f78c621a2285c9eaff` · 2026-11-03 | API sintética y Chromium local. [Criterios, resultados y límites](../8-testing/evidencias/HU25-Web-2026-11-03.md). Este SHA es el usado para esa medición, no el SHA final W. |
| E-STG | Smoke remoto y k6: una corrida aprobó thresholds; dos fallaron el threshold de `Server-Timing` ausente | SHA histórico `ac2b39e1a971c05998cb8dd0dd5a5e2f3295ba22` · 2026-10-29 | No es el candidato B; no cierra despliegue/reversión actual. [Detalle](../8-testing/evidencias/HU-STG-01-Backend-2026-10-29.md). |

## Trabajo restante para aceptar RF

1. Ejecutar cada CP de aceptación o enlazarlo a un test automatizado con aserciones inequívocas, SHA, resultado, fecha y artefacto.
2. Completar los recorridos API/cliente con staging y datos de dos sedes; registrar casos de error, autorización, archivos y reconexión.
3. Validar las asociaciones RF→HU contra el anexo institucional de los 28 hallazgos cuando esté disponible. Esta matriz no sustituye dicho anexo.
4. Obtener revisión independiente y registrar el PR revisado. Los PR citados siguen en borrador y sin merge.

La síntesis por HU está en [CIERRE-HU-2026-11-03.md](CIERRE-HU-2026-11-03.md). No usar esta matriz para afirmar cumplimiento del 100 %.
