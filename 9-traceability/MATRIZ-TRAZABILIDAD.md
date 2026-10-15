# Matriz de trazabilidad de requisitos, fuente y verificación

**Proyecto:** SaborExpress  |  **Fecha de corte:** 14 de octubre de 2026  |  **Versión:** 2.0  |  **Tipo:** Documento técnico y académico

**Estado de la evidencia:** inspección documental y estática del código. Las pruebas de ejecución y los datos institucionales no aportados no se presumen realizados.

## Método

Cada requisito RF se vincula a evidencia de código (origen) y a casos de pruebas diseñados. Estado de ejecución: **pendiente**. La falta de caso específico se indica como necesidad de cobertura adicional; no se presume aprobación.

| Req | Fuente de código | Casos sugeridos | Estado |
| --- | --- | --- | --- |
| RF-01 | POST /api/Auth/login | CP-01, CP-02 | Pruebas pendientes |
| RF-02 | AuthController | CP-03 | Pruebas pendientes |
| RF-03 | Controllers/Roles,Permissions,UserRoles | CP-05 | Pruebas pendientes |
| RF-04 | BranchesController | CP-05 | Pruebas pendientes |
| RF-05 | GET /api/Branches/mine | CP-05 | Pruebas pendientes |
| RF-06 | EmployeesController | CP-05 | Pruebas pendientes |
| RF-07 | EmployeeSchedulesController | CP-22 | Pruebas pendientes |
| RF-08 | ProductsController/CategoriesController | CP-06, CP-07 | Pruebas pendientes |
| RF-09 | GET /api/Products | CP-06 | Pruebas pendientes |
| RF-10 | POST /api/Orders | CP-08, CP-09, CP-10 | Pruebas pendientes |
| RF-11 | GET /api/Orders/... | CP-08 | Pruebas pendientes |
| RF-12 | PATCH /api/Orders/{id}/status | CP-13 | Pruebas pendientes |
| RF-13 | PATCH /api/Orders/{id}/cancel-mine | CP-11, CP-12 | Pruebas pendientes |
| RF-14 | PaymentsController | CP-19 | Pruebas pendientes |
| RF-15 | POST /api/Payments/wompi/init | CP-14, CP-17 | Pruebas pendientes |
| RF-16 | POST /api/Payments/wompi/webhook | CP-15, CP-16 | Pruebas pendientes |
| RF-17 | POST /api/Payments/wompi/cashier-init | CP-18 | Pruebas pendientes |
| RF-18 | POST /api/Deliveries | CP-20 | Pruebas pendientes |
| RF-19 | PATCH /api/Deliveries/{id}/status | CP-20 | Pruebas pendientes |
| RF-20 | POST /api/Deliveries/{id}/rating | CP-21 | Pruebas pendientes |
| RF-21 | NotificationsController | CP-22 | Pruebas pendientes |
| RF-22 | PublicKitchenController y componente KitchenBoardPublic | CP-22 | Pruebas pendientes |
| RF-23 | GET /api/Branches/nearest | CP-05 | Pruebas pendientes |
| RF-24 | Tables,Orders,DailyMenu Controllers | CP-08 | Pruebas pendientes |
| RF-25 | src/app/reports/page.tsx | CP-27 | Pruebas pendientes |

## Criterio de actualización

Cuando una prueba pase, adjuntar evidencia en carpeta `8-testing/evidencias` con nombre sin datos privados; registrar SHA de back/web/móvil y fecha. Agregar columna de cobertura real al activar pipeline CI.

## Fuentes primarias de implementación

- API: https://github.com/yersonct/SaborExpressBack/tree/main
- Web: https://github.com/yersonct/SaborExpressWeb/tree/main
- Móvil: https://github.com/yersonct/SaborExpressMovil/tree/main
- Referencia de presentación: https://github.com/jsgh1/SRD-v1/tree/dev/docs/docs-SRD

**Control documental:** documento elaborado a partir del estado observado en octubre de 2026. Antes de entregar, verificar el commit exacto, responsable, revisión del instructor y cualquier cambio posterior del código.
