# Diccionario de datos y modelo relacional

**Proyecto:** SaborExpress  |  **Fecha de corte:** 14 de octubre de 2026  |  **Versión:** 2.0  |  **Tipo:** Documento técnico y académico

**Estado de la evidencia:** inspección documental y estática del código. Las pruebas de ejecución y los datos institucionales no aportados no se presumen realizados.

## 1. Procedencia y limitación

Los campos listados a continuación se transcriben de modelos C# inspeccionados en `Modules/<Dominio>/Models` y del `AppDbContext`. **Son propiedades de entidades**, no una exportación certificada del DDL físico (nombres de columnas, índices, nulabilidad y reglas SQL deben validarse en migraciones y motor objetivo). PK/FK se infiere de los nombres y navegaciones y corresponde a relaciones programadas que necesitan comprobarse físicamente.

## 2. Modelos de datos inspeccionados

### Entidad User

| Propiedad/Tipo visible | Interpretación de dominio |
| --- | --- |
| Id:int PK | Id — propiedad del modelo C# |
| Email:string? | Email — propiedad del modelo C# |
| PasswordHash:string | PasswordHash — propiedad del modelo C# |
| Status:bool | Status — propiedad del modelo C# |
| MustChangePassword:bool | MustChangePassword — propiedad del modelo C# |
| LastLogin:DateTime? | LastLogin — propiedad del modelo C# |
| CreatedAt:DateTime | CreatedAt — propiedad del modelo C# |
| FailedLoginAttempts:int | FailedLoginAttempts — propiedad del modelo C# |
| LockoutEnd:DateTime? | LockoutEnd — propiedad del modelo C# |
| EmailConfirmed:bool | EmailConfirmed — propiedad del modelo C# |

### Entidad Employee

| Propiedad/Tipo visible | Interpretación de dominio |
| --- | --- |
| Id:int PK | Id — propiedad del modelo C# |
| UserId:int FK | UserId — propiedad del modelo C# |
| Name:string | Name — propiedad del modelo C# |
| LastName:string? | LastName — propiedad del modelo C# |
| Document:string | Document — propiedad del modelo C# |
| Phone:string? | Phone — propiedad del modelo C# |
| BranchId:int? FK | BranchId — propiedad del modelo C# |
| Status:string | Status — propiedad del modelo C# |
| Vehicle:string? | Vehicle — propiedad del modelo C# |
| Plate:string? | Plate — propiedad del modelo C# |
| IsAvailable:bool | IsAvailable — propiedad del modelo C# |
| BasePay:decimal | BasePay — propiedad del modelo C# |

### Entidad Branch

| Propiedad/Tipo visible | Interpretación de dominio |
| --- | --- |
| Id:int PK | Id — propiedad del modelo C# |
| Name:string | Name — propiedad del modelo C# |
| Address:string? | Address — propiedad del modelo C# |
| Phone:string? | Phone — propiedad del modelo C# |
| Status:bool | Status — propiedad del modelo C# |
| Latitude:decimal | Latitude — propiedad del modelo C# |
| Longitude:decimal | Longitude — propiedad del modelo C# |
| PublicKitchenCode:string? | PublicKitchenCode — propiedad del modelo C# |
| CreatedAt:DateTime | CreatedAt — propiedad del modelo C# |

### Entidad Product

| Propiedad/Tipo visible | Interpretación de dominio |
| --- | --- |
| Id:int PK | Id — propiedad del modelo C# |
| CategoryId:int FK | CategoryId — propiedad del modelo C# |
| BranchId:int? FK | BranchId — propiedad del modelo C# |
| Name:string | Name — propiedad del modelo C# |
| Description:string | Description — propiedad del modelo C# |
| Price:decimal | Price — propiedad del modelo C# |
| Photo:string? | Photo — propiedad del modelo C# |
| PreparationTimeInMinutes:int | PreparationTimeInMinutes — propiedad del modelo C# |
| Status:bool | Status — propiedad del modelo C# |
| CreatedAt:DateTime | CreatedAt — propiedad del modelo C# |

### Entidad Order

| Propiedad/Tipo visible | Interpretación de dominio |
| --- | --- |
| Id:int PK | Id — propiedad del modelo C# |
| CustomerId:int? FK | CustomerId — propiedad del modelo C# |
| EmployeeId:int? FK | EmployeeId — propiedad del modelo C# |
| TableId:int? FK | TableId — propiedad del modelo C# |
| BranchId:int FK | BranchId — propiedad del modelo C# |
| AddressId:int? FK | AddressId — propiedad del modelo C# |
| OrderType:enum | OrderType — propiedad del modelo C# |
| Channel:enum | Channel — propiedad del modelo C# |
| Status:enum | Status — propiedad del modelo C# |
| SubTotal:decimal | SubTotal — propiedad del modelo C# |
| Tax:decimal | Tax — propiedad del modelo C# |
| Total:decimal | Total — propiedad del modelo C# |
| Notes:string? | Notes — propiedad del modelo C# |
| GuestName:string? | GuestName — propiedad del modelo C# |
| CreatedAt:DateTime | CreatedAt — propiedad del modelo C# |
| UpdatedAt:DateTime? | UpdatedAt — propiedad del modelo C# |

### Entidad OrderDetail

| Propiedad/Tipo visible | Interpretación de dominio |
| --- | --- |
| Id:int PK | Id — propiedad del modelo C# |
| OrderId:int FK | OrderId — propiedad del modelo C# |
| ProductId:int FK | ProductId — propiedad del modelo C# |
| LastModifiedByEmployeeId:int? FK | LastModifiedByEmployeeId — propiedad del modelo C# |
| Quantity:int | Quantity — propiedad del modelo C# |
| UnitPrice:decimal | UnitPrice — propiedad del modelo C# |
| SubTotal:decimal | SubTotal — propiedad del modelo C# |
| Notes:string? | Notes — propiedad del modelo C# |
| IsToGo:bool | IsToGo — propiedad del modelo C# |
| BatchNumber:int | BatchNumber — propiedad del modelo C# |
| Status:enum | Status — propiedad del modelo C# |

### Entidad Payment

| Propiedad/Tipo visible | Interpretación de dominio |
| --- | --- |
| Id:int PK | Id — propiedad del modelo C# |
| OrderId:int FK | OrderId — propiedad del modelo C# |
| CashierId:int? FK | CashierId — propiedad del modelo C# |
| Method:enum | Method — propiedad del modelo C# |
| Amount:decimal | Amount — propiedad del modelo C# |
| Status:enum | Status — propiedad del modelo C# |
| PaidAt:DateTime | PaidAt — propiedad del modelo C# |
| WompiReference:string? | WompiReference — propiedad del modelo C# |
| WompiTransactionId:string? | WompiTransactionId — propiedad del modelo C# |

### Entidad Delivery

| Propiedad/Tipo visible | Interpretación de dominio |
| --- | --- |
| Id:int PK | Id — propiedad del modelo C# |
| OrderId:int FK | OrderId — propiedad del modelo C# |
| AddressId:int FK | AddressId — propiedad del modelo C# |
| DeliveryPersonId:int FK | DeliveryPersonId — propiedad del modelo C# |
| Status:enum | Status — propiedad del modelo C# |
| AssignedAt:DateTime | AssignedAt — propiedad del modelo C# |
| DeliveredAt:DateTime? | DeliveredAt — propiedad del modelo C# |
| CustomerRating:int? | CustomerRating — propiedad del modelo C# |
| CustomerRatingComment:string? | CustomerRatingComment — propiedad del modelo C# |
| RatedAt:DateTime? | RatedAt — propiedad del modelo C# |


## 3. Entidades adicionales registradas en DbContext

PasswordResetCodes, Roles, Permissions, RolePermissions, UserRoles, Customers, Categories, OrderStatusHistories, OrderDetailHistories, Tables, Reviews, Addresses, UserPreferences, BranchSetting, BranchOperationalSettings, UserSettings, EmailConfirmationCodes, RefreshTokens, EmployeeSchedules, DailyMenuItems, Invoices, EmployeeActivationCodes y Notifications. Sus tablas y columnas deben cotejarse con modelos y configuraciones respectivas; no se inventan columnas.

## 4. Relaciones de negocio

![Relaciones conceptuales de las entidades inspeccionadas](MODELO-ENTIDADES.png)

1. `User 1—0..1 Employee`; `Employee` referencia `UserId`. 2. `Branch 1—N Order`, `Branch 1—N Employee` (opcional para employee) y `Branch 1—N Product` (opcional para producto global). 3. `Order 1—N OrderDetail` y `Order 1—N Payment`. 4. `OrderDetail N—1 Product`. 5. `Delivery N—1 Order`, `Address` y `Employee` como repartidor. 6. `Product N—1 Category`.

## 5. Reglas de integridad que se deben comprobar

Montos DECIMAL adecuados para moneda; no aceptar negativos; `CustomerRating` en 1..5; `Quantity` mayor que cero; `Total` consistente con subtotales/impuestos; unicidad de referencia Wompi; índice sobre pedido y estados cuando aplique; privacidad de contraseñas/token; políticas de borrado y registros históricos. El modelo C# por sí mismo no demuestra todos estos CHECK/UNIQUE/INDEX físicos.

## 6. Obtención correcta del esquema SQL

Seleccionar el proveedor real en ambiente aislado. Desde la carpeta backend, con `dotnet-ef` compatible y herramientas restauradas, usar `dotnet ef migrations script --idempotent --output esquema-generado.sql` o extraer el DDL del motor. Verificar que migraciones sean apropiadas para ese proveedor. El archivo `5-database/database-schema.sql` contiene instrucciones de catálogo y NO es un DDL de producción inventado.

## 7. Protección de información

No subir respaldos reales, contraseñas, claves API, tokens, números de documentos ni datos de clientes al repositorio de documentación. Toda captura de base de datos debe ser sintética o anonimizada y autorizada.

## Fuentes primarias de implementación

- API: https://github.com/yersonct/SaborExpressBack/tree/main
- Web: https://github.com/yersonct/SaborExpressWeb/tree/main
- Móvil: https://github.com/yersonct/SaborExpressMovil/tree/main
- Referencia de presentación: https://github.com/jsgh1/SRD-v1/tree/dev/docs/docs-SRD

**Control documental:** documento elaborado a partir del estado observado en octubre de 2026. Antes de entregar, verificar el commit exacto, responsable, revisión del instructor y cualquier cambio posterior del código.
