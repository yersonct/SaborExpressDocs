# Diccionario de datos derivado de migraciones EF Core

Generado: 2026-11-03 Â· Proveedor: PostgreSQL Â· Tablas de aplicaciÃ³n: 34 Â· Columnas: 286 Â· Relaciones FK: 53.

La fuente es el script idempotente generado desde el conjunto de migraciones del repositorio Backend. Describe el esquema que esas migraciones construirÃ­an; no prueba el esquema actualmente desplegado ni sustituye la conciliaciÃ³n con una base accesible.

| Tabla | Columna | Tipo PostgreSQL | Acepta NULL | Clave | Referencia |
|---|---|---|---|---|---|
| `branches` | `Id` | `integer` | SÃ­ | PK |  |
| `branches` | `name` | `character varying(120)` | No |  |  |
| `branches` | `address` | `character varying(255)` | SÃ­ |  |  |
| `branches` | `phone` | `character varying(30)` | SÃ­ |  |  |
| `branches` | `status` | `boolean` | No |  |  |
| `branches` | `created_at` | `timestamp with time zone` | No |  |  |
| `categories` | `id` | `integer` | SÃ­ | PK |  |
| `categories` | `name` | `character varying(100)` | No |  |  |
| `categories` | `description` | `character varying(500)` | No |  |  |
| `categories` | `status` | `boolean` | No |  |  |
| `categories` | `created_at` | `timestamp with time zone` | No |  |  |
| `permissions` | `id` | `integer` | SÃ­ | PK |  |
| `permissions` | `name` | `character varying(100)` | No |  |  |
| `permissions` | `module` | `character varying(50)` | No |  |  |
| `permissions` | `description` | `character varying(255)` | SÃ­ |  |  |
| `permissions` | `status` | `boolean` | No |  |  |
| `permissions` | `created_at` | `timestamp with time zone` | No |  |  |
| `roles` | `id` | `integer` | SÃ­ | PK |  |
| `roles` | `name` | `character varying(50)` | No |  |  |
| `roles` | `description` | `character varying(255)` | SÃ­ |  |  |
| `roles` | `requires_cv` | `boolean` | No |  |  |
| `roles` | `status` | `boolean` | No |  |  |
| `roles` | `created_at` | `timestamp with time zone` | No |  |  |
| `users` | `id` | `integer` | SÃ­ | PK |  |
| `users` | `email` | `character varying(120)` | No |  |  |
| `users` | `password_hash` | `character varying(255)` | No |  |  |
| `users` | `token` | `text` | SÃ­ |  |  |
| `users` | `status` | `boolean` | No |  |  |
| `users` | `MustChangePassword` | `boolean` | No |  |  |
| `users` | `last_login` | `timestamp with time zone` | SÃ­ |  |  |
| `users` | `created_at` | `timestamp with time zone` | No |  |  |
| `users` | `FailedLoginAttempts` | `integer` | No |  |  |
| `users` | `LockoutEnd` | `timestamp with time zone` | SÃ­ |  |  |
| `users` | `EmailConfirmed` | `boolean` | No |  |  |
| `branch_settings` | `id` | `integer` | SÃ­ | PK |  |
| `branch_settings` | `branch_id` | `integer` | SÃ­ | FK | `branches.Id` |
| `branch_settings` | `key` | `character varying(100)` | No |  |  |
| `branch_settings` | `value` | `text` | No |  |  |
| `branch_settings` | `data_type` | `character varying(20)` | No |  |  |
| `branch_settings` | `description` | `text` | SÃ­ |  |  |
| `branch_settings` | `updated_at` | `timestamp with time zone` | No |  |  |
| `tables` | `id` | `integer` | SÃ­ | PK |  |
| `tables` | `branch_id` | `integer` | No | FK | `branches.Id` |
| `tables` | `number` | `integer` | No |  |  |
| `tables` | `status` | `character varying(30)` | No |  |  |
| `tables` | `created_at` | `timestamp with time zone` | No |  |  |
| `products` | `id` | `integer` | SÃ­ | PK |  |
| `products` | `category_id` | `integer` | No | FK | `categories.id` |
| `products` | `name` | `character varying(120)` | No |  |  |
| `products` | `description` | `text` | No |  |  |
| `products` | `price` | `numeric(10,2)` | No |  |  |
| `products` | `photo` | `character varying(255)` | SÃ­ |  |  |
| `products` | `preparation_time_in_minutes` | `integer` | No |  |  |
| `products` | `status` | `boolean` | No |  |  |
| `products` | `created_at` | `timestamp with time zone` | No |  |  |
| `products` | `CategoryId1` | `integer` | SÃ­ | FK | `categories.id` |
| `role_permissions` | `role_id` | `integer` | No | PK | `roles.id` |
| `role_permissions` | `permission_id` | `integer` | No | PK | `permissions.id` |
| `role_permissions` | `assigned_at` | `timestamp with time zone` | No |  |  |
| `customers` | `id` | `integer` | SÃ­ | PK |  |
| `customers` | `user_id` | `integer` | No | FK | `users.id` |
| `customers` | `name` | `character varying(120)` | No |  |  |
| `customers` | `last_name` | `character varying(120)` | SÃ­ |  |  |
| `customers` | `phone` | `character varying(30)` | SÃ­ |  |  |
| `customers` | `address` | `character varying(255)` | SÃ­ |  |  |
| `customers` | `created_at` | `timestamp with time zone` | No |  |  |
| `EmailConfirmationCodes` | `Id` | `integer` | SÃ­ | PK |  |
| `EmailConfirmationCodes` | `UserId` | `integer` | No | FK | `users.id` |
| `EmailConfirmationCodes` | `Code` | `text` | No |  |  |
| `EmailConfirmationCodes` | `CodeExpiresAt` | `timestamp with time zone` | No |  |  |
| `EmailConfirmationCodes` | `IsUsed` | `boolean` | No |  |  |
| `EmailConfirmationCodes` | `Attempts` | `integer` | No |  |  |
| `EmailConfirmationCodes` | `CreatedAt` | `timestamp with time zone` | No |  |  |
| `employee_activation_codes` | `id` | `integer` | SÃ­ | PK |  |
| `employee_activation_codes` | `user_id` | `integer` | No | FK | `users.id` |
| `employee_activation_codes` | `code` | `character varying(20)` | No |  |  |
| `employee_activation_codes` | `code_expires_at` | `timestamp with time zone` | No |  |  |
| `employee_activation_codes` | `is_used` | `boolean` | No |  |  |
| `employee_activation_codes` | `attempts` | `integer` | No |  |  |
| `employee_activation_codes` | `created_at` | `timestamp with time zone` | No |  |  |
| `employees` | `id` | `integer` | SÃ­ | PK |  |
| `employees` | `user_id` | `integer` | No | FK | `users.id` |
| `employees` | `name` | `character varying(120)` | No |  |  |
| `employees` | `last_name` | `character varying(80)` | SÃ­ |  |  |
| `employees` | `document` | `character varying(20)` | No |  |  |
| `employees` | `phone` | `character varying(20)` | SÃ­ |  |  |
| `employees` | `address` | `character varying(255)` | SÃ­ |  |  |
| `employees` | `photo` | `character varying(255)` | SÃ­ |  |  |
| `employees` | `branch_id` | `integer` | SÃ­ | FK | `branches.Id` |
| `employees` | `status` | `character varying(15)` | No |  |  |
| `employees` | `base_pay` | `numeric(10,2)` | No |  |  |
| `employees` | `cv_file` | `bytea` | SÃ­ |  |  |
| `employees` | `cv_filename` | `character varying(255)` | SÃ­ |  |  |
| `employees` | `cv_content_type` | `character varying(100)` | SÃ­ |  |  |
| `employees` | `created_at` | `timestamp with time zone` | No |  |  |
| `Notifications` | `Id` | `integer` | SÃ­ | PK |  |
| `Notifications` | `UserId` | `integer` | No | FK | `users.id` |
| `Notifications` | `Title` | `character varying(150)` | No |  |  |
| `Notifications` | `Message` | `character varying(500)` | No |  |  |
| `Notifications` | `Type` | `integer` | No |  |  |
| `Notifications` | `RelatedEntityType` | `text` | SÃ­ |  |  |
| `Notifications` | `RelatedEntityId` | `integer` | SÃ­ |  |  |
| `Notifications` | `IsRead` | `boolean` | No |  |  |
| `Notifications` | `ReadAt` | `timestamp with time zone` | SÃ­ |  |  |
| `Notifications` | `CreatedAt` | `timestamp with time zone` | No |  |  |
| `password_reset_codes` | `id` | `integer` | SÃ­ | PK |  |
| `password_reset_codes` | `user_id` | `integer` | No | FK | `users.id` |
| `password_reset_codes` | `code` | `character varying(20)` | No |  |  |
| `password_reset_codes` | `code_expires_at` | `timestamp with time zone` | No |  |  |
| `password_reset_codes` | `is_code_used` | `boolean` | No |  |  |
| `password_reset_codes` | `Attempts` | `integer` | No |  |  |
| `password_reset_codes` | `reset_token` | `character varying(255)` | SÃ­ |  |  |
| `password_reset_codes` | `reset_token_expires_at` | `timestamp with time zone` | SÃ­ |  |  |
| `password_reset_codes` | `is_completed` | `boolean` | No |  |  |
| `password_reset_codes` | `created_at` | `timestamp with time zone` | No |  |  |
| `password_reset_codes` | `UserId1` | `integer` | SÃ­ | FK | `users.id` |
| `RefreshTokens` | `Id` | `integer` | SÃ­ | PK |  |
| `RefreshTokens` | `UserId` | `integer` | No | FK | `users.id` |
| `RefreshTokens` | `Token` | `text` | No |  |  |
| `RefreshTokens` | `ExpiresAt` | `timestamp with time zone` | No |  |  |
| `RefreshTokens` | `IsRevoked` | `boolean` | No |  |  |
| `RefreshTokens` | `CreatedAt` | `timestamp with time zone` | No |  |  |
| `user_preferences` | `id` | `integer` | SÃ­ | PK |  |
| `user_preferences` | `user_id` | `integer` | No | FK | `users.id` |
| `user_preferences` | `screen` | `character varying(100)` | No |  |  |
| `user_preferences` | `key` | `character varying(100)` | No |  |  |
| `user_preferences` | `value` | `text` | No |  |  |
| `user_preferences` | `data_type` | `character varying(20)` | No |  |  |
| `user_preferences` | `updated_at` | `timestamp with time zone` | No |  |  |
| `user_roles` | `user_id` | `integer` | No | PK | `users.id` |
| `user_roles` | `role_id` | `integer` | No | PK | `roles.id` |
| `user_roles` | `assigned_at` | `timestamp with time zone` | No |  |  |
| `DailyMenuItems` | `Id` | `integer` | SÃ­ | PK |  |
| `DailyMenuItems` | `BranchId` | `integer` | No | FK | `branches.Id` |
| `DailyMenuItems` | `ProductId` | `integer` | No | FK | `products.id` |
| `DailyMenuItems` | `Date` | `timestamp with time zone` | No |  |  |
| `DailyMenuItems` | `MealPeriod` | `integer` | No |  |  |
| `DailyMenuItems` | `IsAvailable` | `boolean` | No |  |  |
| `DailyMenuItems` | `CreatedAt` | `timestamp with time zone` | No |  |  |
| `addresses` | `id` | `integer` | SÃ­ | PK |  |
| `addresses` | `customer_id` | `integer` | No | FK | `customers.id` |
| `addresses` | `address_line` | `character varying(255)` | No |  |  |
| `addresses` | `reference` | `character varying(255)` | SÃ­ |  |  |
| `addresses` | `latitude` | `numeric(9,6)` | No |  |  |
| `addresses` | `longitude` | `numeric(9,6)` | No |  |  |
| `addresses` | `is_default` | `boolean` | No |  |  |
| `EmployeeSchedules` | `Id` | `integer` | SÃ­ | PK |  |
| `EmployeeSchedules` | `EmployeeId` | `integer` | No | FK | `employees.id` |
| `EmployeeSchedules` | `BranchId` | `integer` | No | FK | `branches.Id` |
| `EmployeeSchedules` | `RoleId` | `integer` | No | FK | `roles.id` |
| `EmployeeSchedules` | `ShiftDate` | `date` | No |  |  |
| `EmployeeSchedules` | `StartTime` | `time` | No |  |  |
| `EmployeeSchedules` | `EndTime` | `time` | No |  |  |
| `EmployeeSchedules` | `ReminderSent` | `boolean` | No |  |  |
| `EmployeeSchedules` | `Status` | `integer` | No |  |  |
| `EmployeeSchedules` | `Notes` | `text` | SÃ­ |  |  |
| `EmployeeSchedules` | `CreatedAt` | `timestamp with time zone` | No |  |  |
| `EmployeeSchedules` | `UpdatedAt` | `timestamp with time zone` | SÃ­ |  |  |
| `orders` | `id` | `integer` | SÃ­ | PK |  |
| `orders` | `customer_id` | `integer` | SÃ­ | FK | `customers.id` |
| `orders` | `employee_id` | `integer` | No | FK | `employees.id` |
| `orders` | `table_id` | `integer` | SÃ­ | FK | `tables.id` |
| `orders` | `branch_id` | `integer` | No | FK | `branches.Id` |
| `orders` | `order_type` | `character varying(30)` | No |  |  |
| `orders` | `channel` | `character varying(20)` | No |  |  |
| `orders` | `status` | `character varying(30)` | No |  |  |
| `orders` | `sub_total` | `numeric(10,2)` | No |  |  |
| `orders` | `tax` | `numeric(10,2)` | No |  |  |
| `orders` | `total` | `numeric(10,2)` | No |  |  |
| `orders` | `notes` | `character varying(500)` | SÃ­ |  |  |
| `orders` | `created_at` | `timestamp with time zone` | No |  |  |
| `orders` | `updated_at` | `timestamp with time zone` | SÃ­ |  |  |
| `deliveries` | `id` | `integer` | SÃ­ | PK |  |
| `deliveries` | `order_id` | `integer` | No | FK | `orders.id` |
| `deliveries` | `address_id` | `integer` | No | FK | `addresses.id` |
| `deliveries` | `delivery_person_id` | `integer` | No | FK | `employees.id` |
| `deliveries` | `status` | `character varying(30)` | No |  |  |
| `deliveries` | `assigned_at` | `timestamp with time zone` | No |  |  |
| `deliveries` | `delivered_at` | `timestamp with time zone` | SÃ­ |  |  |
| `order_details` | `id` | `integer` | SÃ­ | PK |  |
| `order_details` | `order_id` | `integer` | No | FK | `orders.id` |
| `order_details` | `product_id` | `integer` | No | FK | `products.id` |
| `order_details` | `last_modified_by_employee_id` | `integer` | No | FK | `employees.id` |
| `order_details` | `quantity` | `integer` | No |  |  |
| `order_details` | `unit_price` | `numeric(10,2)` | No |  |  |
| `order_details` | `sub_total` | `numeric(10,2)` | No |  |  |
| `order_details` | `notes` | `character varying(255)` | SÃ­ |  |  |
| `order_details` | `status` | `character varying(30)` | No |  |  |
| `order_details` | `OrderId1` | `integer` | SÃ­ | FK | `orders.id` |
| `order_status_history` | `id` | `integer` | SÃ­ | PK |  |
| `order_status_history` | `order_id` | `integer` | No | FK | `orders.id` |
| `order_status_history` | `changed_by_employee_id` | `integer` | No | FK | `employees.id` |
| `order_status_history` | `status` | `character varying(30)` | No |  |  |
| `order_status_history` | `notes` | `character varying(255)` | SÃ­ |  |  |
| `order_status_history` | `changed_at` | `timestamp with time zone` | No |  |  |
| `order_status_history` | `OrderId1` | `integer` | SÃ­ | FK | `orders.id` |
| `payments` | `id` | `integer` | SÃ­ | PK |  |
| `payments` | `order_id` | `integer` | No | FK | `orders.id` |
| `payments` | `cashier_id` | `integer` | No | FK | `employees.id` |
| `payments` | `method` | `character varying(30)` | No |  |  |
| `payments` | `amount` | `numeric(10,2)` | No |  |  |
| `payments` | `status` | `character varying(30)` | No |  |  |
| `payments` | `paid_at` | `timestamp with time zone` | No |  |  |
| `reviews` | `id` | `integer` | SÃ­ | PK |  |
| `reviews` | `order_id` | `integer` | No | FK | `orders.id` |
| `reviews` | `customer_id` | `integer` | No | FK | `customers.id` |
| `reviews` | `rating` | `smallint` | No |  |  |
| `reviews` | `comment` | `character varying(500)` | SÃ­ |  |  |
| `reviews` | `created_at` | `timestamp with time zone` | No |  |  |
| `order_detail_history` | `id` | `integer` | SÃ­ | PK |  |
| `order_detail_history` | `order_detail_id` | `integer` | No | FK | `order_details.id` |
| `order_detail_history` | `changed_by_employee_id` | `integer` | No | FK | `employees.id` |
| `order_detail_history` | `action` | `character varying(30)` | No |  |  |
| `order_detail_history` | `old_value` | `text` | SÃ­ |  |  |
| `order_detail_history` | `new_value` | `text` | SÃ­ |  |  |
| `order_detail_history` | `reason` | `character varying(255)` | SÃ­ |  |  |
| `order_detail_history` | `changed_at` | `timestamp with time zone` | No |  |  |
| `Invoices` | `Id` | `integer` | SÃ­ | PK |  |
| `Invoices` | `PaymentId` | `integer` | No | FK | `payments.id` |
| `Invoices` | `OrderId` | `integer` | No | FK | `orders.id` |
| `Invoices` | `BranchId` | `integer` | No | FK | `branches.Id` |
| `Invoices` | `InvoiceNumber` | `text` | No |  |  |
| `Invoices` | `SubTotal` | `numeric` | No |  |  |
| `Invoices` | `Tax` | `numeric` | No |  |  |
| `Invoices` | `Total` | `numeric` | No |  |  |
| `Invoices` | `IsVoided` | `boolean` | No |  |  |
| `Invoices` | `VoidReason` | `text` | SÃ­ |  |  |
| `Invoices` | `IssuedAt` | `timestamp with time zone` | No |  |  |
| `branch_operational_settings` | `id` | `integer` | SÃ­ | PK |  |
| `branch_operational_settings` | `branch_id` | `integer` | No | FK | `branches.Id` |
| `branch_operational_settings` | `opening_time` | `time` | No |  |  |
| `branch_operational_settings` | `closing_time` | `time` | No |  |  |
| `branch_operational_settings` | `tax_rate` | `numeric(5,2)` | No |  |  |
| `branch_operational_settings` | `delivery_fee` | `numeric(12,2)` | No |  |  |
| `branch_operational_settings` | `suggested_tip_percent` | `numeric(5,2)` | No |  |  |
| `branch_operational_settings` | `delivery_radius_km` | `numeric(5,2)` | No |  |  |
| `branch_operational_settings` | `min_order_amount` | `numeric(12,2)` | No |  |  |
| `branch_operational_settings` | `accepts_delivery` | `boolean` | No |  |  |
| `branch_operational_settings` | `accepts_dine_in` | `boolean` | No |  |  |
| `branch_operational_settings` | `updated_at` | `timestamp with time zone` | No |  |  |
| `user_settings` | `id` | `integer` | SÃ­ | PK |  |
| `user_settings` | `user_id` | `integer` | No | FK | `users.id` |
| `user_settings` | `theme` | `character varying(10)` | No |  |  |
| `user_settings` | `email_notifications` | `boolean` | No |  |  |
| `user_settings` | `push_notifications` | `boolean` | No |  |  |
| `user_settings` | `sound_notifications` | `boolean` | No |  |  |
| `user_settings` | `time_zone` | `character varying(60)` | No |  |  |
| `user_settings` | `updated_at` | `timestamp with time zone` | No |  |  |
| `push_devices` | `id` | `integer` | SÃ­ | PK |  |
| `push_devices` | `user_id` | `integer` | No | FK | `users.id` |
| `push_devices` | `expo_push_token` | `character varying(256)` | No |  |  |
| `push_devices` | `platform` | `character varying(20)` | No |  |  |
| `push_devices` | `sound_enabled` | `boolean` | No |  |  |
| `push_devices` | `vibration_enabled` | `boolean` | No |  |  |
| `push_devices` | `created_at` | `timestamp with time zone` | No |  |  |
| `push_devices` | `updated_at` | `timestamp with time zone` | No |  |  |
| `cash_closures` | `id` | `integer` | SÃ­ | PK |  |
| `cash_closures` | `schedule_id` | `integer` | No | FK | `EmployeeSchedules.Id` |
| `cash_closures` | `cashier_id` | `integer` | No | FK | `employees.id` |
| `cash_closures` | `branch_id` | `integer` | No | FK | `branches.Id` |
| `cash_closures` | `shift_date` | `date` | No |  |  |
| `cash_closures` | `shift_started_at_utc` | `timestamp with time zone` | No |  |  |
| `cash_closures` | `closed_at_utc` | `timestamp with time zone` | No |  |  |
| `cash_closures` | `cash_expected` | `decimal(14,2)` | No |  |  |
| `cash_closures` | `cash_counted` | `decimal(14,2)` | No |  |  |
| `cash_closures` | `cash_difference` | `decimal(14,2)` | No |  |  |
| `cash_closures` | `card_total` | `decimal(14,2)` | No |  |  |
| `cash_closures` | `transfer_total` | `decimal(14,2)` | No |  |  |
| `cash_closures` | `wompi_total` | `decimal(14,2)` | No |  |  |
| `cash_closures` | `total_sales` | `decimal(14,2)` | No |  |  |
| `cash_closures` | `payments_count` | `integer` | No |  |  |
| `cash_closures` | `cashier_name` | `character varying(250)` | No |  |  |
| `cash_closures` | `branch_name` | `character varying(250)` | No |  |  |
| `cash_closures` | `notes` | `character varying(500)` | SÃ­ |  |  |
| `cash_closures` | `payments_snapshot_json` | `text` | No |  |  |
| `table_release_audits` | `Id` | `bigint` | SÃ­ | PK |  |
| `table_release_audits` | `TableId` | `integer` | No |  |  |
| `table_release_audits` | `TableNumber` | `integer` | No |  |  |
| `table_release_audits` | `BranchId` | `integer` | No |  |  |
| `table_release_audits` | `PreviousSessionId` | `uuid` | SÃ­ |  |  |
| `table_release_audits` | `ActorUserId` | `integer` | No |  |  |
| `table_release_audits` | `Administrative` | `boolean` | No |  |  |
| `table_release_audits` | `Reason` | `character varying(500)` | No |  |  |
| `table_release_audits` | `OrderIdsJson` | `text` | No |  |  |
| `table_release_audits` | `OutstandingAmount` | `numeric(18,2)` | No |  |  |
| `table_release_audits` | `ReleasedAtUtc` | `timestamp with time zone` | No |  |  |
