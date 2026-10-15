# Catálogo de API y contratos de integración

**Proyecto:** SaborExpress  |  **Fecha de corte:** 14 de octubre de 2026  |  **Versión:** 2.0  |  **Tipo:** Documento técnico y académico

**Estado de la evidencia:** inspección documental y estática del código. Las pruebas de ejecución y los datos institucionales no aportados no se presumen realizados.

## 1. Alcance y convenciones

Inventario verificado leyendo controladores seleccionados de la rama `main` de SaborExpressBack (corte: octubre de 2026). El resto de controladores existe, pero este catálogo no declara rutas no inspeccionadas. Prefijo `/api`, payload JSON salvo productos con `FromForm`; esquema JWT Bearer en Swagger.

**Swagger:** según `SwaggerConfiguration.cs`, interfaz en `/` y JSON en `/swagger/v1/swagger.json` si el backend está levantado; cambiar según reverse proxy. **SignalR:** `/hubs/notifications` en `Program.cs`. La respuesta y esquema completos se deben exportar del OpenAPI ejecutado.

## 2. Endpoints corroborados

### Auth

| Verbo | Ruta | Operación identificada |
| --- | --- | --- |
| POST | /api/Auth/login | Autenticación |
| POST | /api/Auth/logout | Cerrar sesión |
| POST | /api/Auth/refresh-token | Renovar JWT |
| POST | /api/Auth/forgot-password | Solicitar recuperación |
| POST | /api/Auth/verify-reset-code | Verificar código |
| POST | /api/Auth/reset-password | Cambiar contraseña |
| POST | /api/Auth/confirm-email | Confirmar email |
| POST | /api/Auth/resend-confirmation-code | Reenviar confirmación |
| POST | /api/Auth/resend-activation-code | Reenviar activación |
| POST | /api/Auth/activate-account | Activar cuenta |

### Orders

| Verbo | Ruta | Operación identificada |
| --- | --- | --- |
| POST | /api/Orders | Crear pedido |
| GET | /api/Orders | Consultar pedidos |
| GET | /api/Orders/{id} | Detalle |
| GET | /api/Orders/table/{tableId} | Por mesa |
| GET | /api/Orders/customer/{customerId} | Por cliente |
| GET | /api/Orders/branch/{branchId} | Por sede |
| PUT | /api/Orders/{id} | Actualizar |
| PATCH | /api/Orders/{id}/status | Actualizar estado |
| PATCH | /api/Orders/{id}/cancel-mine | Cancelar cliente |
| PATCH | /api/Orders/{id}/cancel | Cancelar operación |

### Products

| Verbo | Ruta | Operación identificada |
| --- | --- | --- |
| GET | /api/Products | Listar (público) |
| GET | /api/Products/category/{categoryId} | Por categoría (público) |
| GET | /api/Products/{id} | Detalle |
| POST | /api/Products | Crear |
| PUT | /api/Products/{id} | Actualizar |
| DELETE | /api/Products/{id} | Eliminar |
| PATCH | /api/Products/{id}/status | Estado |

### Payments

| Verbo | Ruta | Operación identificada |
| --- | --- | --- |
| POST | /api/Payments | Registrar pago |
| GET | /api/Payments | Listar con filtros |
| GET | /api/Payments/{id} | Detalle |
| GET | /api/Payments/order/{orderId} | Por pedido |
| GET | /api/Payments/my-shift | Cierre de turno |
| PATCH | /api/Payments/{id}/refund | Reembolso |
| POST | /api/Payments/wompi/init | Wompi iniciar cliente |
| POST | /api/Payments/wompi/cashier-init | Wompi QR cajero |
| POST | /api/Payments/{id}/wompi-sync | Sincronizar transacción |
| POST | /api/Payments/wompi/webhook | Webhook recibido |

### Deliveries

| Verbo | Ruta | Operación identificada |
| --- | --- | --- |
| POST | /api/Deliveries | Registrar entrega |
| GET | /api/Deliveries/order/{orderId} | Por pedido |
| GET | /api/Deliveries/employee/{deliveryPersonId} | Por repartidor |
| GET | /api/Deliveries/branch/{branchId} | Por sede |
| GET | /api/Deliveries/branch/{branchId}/delivery-persons | Repartidores disponibles |
| PATCH | /api/Deliveries/{id}/status | Estado de entrega |
| POST | /api/Deliveries/{id}/rating | Calificar |

### Branches

| Verbo | Ruta | Operación identificada |
| --- | --- | --- |
| GET | /api/Branches | Listar |
| GET | /api/Branches/mine | Mi sede |
| GET | /api/Branches/{id} | Detalle |
| POST | /api/Branches | Crear |
| PUT | /api/Branches/{id} | Actualizar |
| DELETE | /api/Branches/{id} | Eliminar |
| GET | /api/Branches/public | Listado público según autorización de clase |
| GET | /api/Branches/nearest | Proximidad; revisar autorización de clase |


## 3. Controles de autorización observados

`OrdersController`: clase marcada con `[Authorize]` y política `[Authorize(Policy="ActiveShift")]`; la cancelación del propio pedido requiere rol Cliente. `ProductsController`: GET del catálogo y por categoría permiten anónimo, mientras que escritura está restringida a Gerente/Administrador. `PaymentsController`: autenticación a nivel de clase; webhook con `[AllowAnonymous]`. `DeliveriesController`: incluye validaciones explícitas de sede/repartidor en algunas operaciones. `BranchesController`: está marcado `[Authorize]` a nivel de clase; sus métodos llamados `public` y `nearest` **no** llevan `[AllowAnonymous]` en el código inspeccionado. Debe revisarse porque un nombre de ruta no implica acceso público.

## 4. Ejemplos ilustrativos, NO contratos DTO exactos

**Token:** `Authorization: Bearer <token_que_devuelva_login>`. **Consulta de catálogo:** `GET /api/Products?branchId=1`. **Pedido:** la carga exacta depende de `CreateOrderDto.cs`; no se incluye un JSON inventado. **Webhook:** probar exclusivamente con eventos firmados del sandbox Wompi y de acuerdo con su documentación oficial.

## 5. Semántica de errores recomendada

200 lectura, 201 creación, 204 sin contenido, 400 solicitud inválida, 401 no autenticado, 403 sin permiso, 404 no encontrado, 409 conflicto, 422 reglas de negocio, 500 error inesperado. Se trata de guía según RFC 9110; las respuestas reales deben contrastarse con el filtro de excepciones del backend.

## 6. Compatibilidad/versionado

La implementación presenta rutas `api/` sin prefijo de versión visible en los controladores inspeccionados. Antes del despliegue público, fijar contrato OpenAPI por commit, políticas de cambios incompatibles y colección Postman con variables de ambiente.

## 7. Guía de verificación

1. Ejecutar backend con BD de pruebas y configuración segura. 2. Solicitar `GET /swagger/v1/swagger.json`. 3. Importar especificación a Postman. 4. Verificar roles y sede en cada recurso. 5. Documentar ejemplos reales anonimizados. 6. Comparar rutas publicadas con este catálogo y corregir diferencias.

## Fuentes primarias de implementación

- API: https://github.com/yersonct/SaborExpressBack/tree/main
- Web: https://github.com/yersonct/SaborExpressWeb/tree/main
- Móvil: https://github.com/yersonct/SaborExpressMovil/tree/main
- Referencia de presentación: https://github.com/jsgh1/SRD-v1/tree/dev/docs/docs-SRD

**Control documental:** documento elaborado a partir del estado observado en octubre de 2026. Antes de entregar, verificar el commit exacto, responsable, revisión del instructor y cualquier cambio posterior del código.
