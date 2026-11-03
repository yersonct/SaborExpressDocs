# Auditoría del expediente y pendientes para entrega

**Proyecto:** SaborExpress  |  **Fecha de corte:** 14 de octubre de 2026  |  **Versión:** 2.0  |  **Tipo:** Documento técnico y académico

**Estado de la evidencia:** inspección documental y estática del código. Las pruebas de ejecución y los datos institucionales no aportados no se presumen realizados.

## 1. Documentos incluidos

Se documentaron todos los formatos vacíos del repositorio de destino, creando versiones Word/PDF/Markdown y anexos de ingeniería. Los cuatro PDFs académicos anteriores del repositorio deben **conservarse sin borrar**; el paquete de actualización no los incluye porque el trabajo complementa la historia documental.

## 2. Qué está sustentado

| Hallazgo verificable | Archivo inspeccionado | Alcance de la afirmación |
|---|---|---|
| Backend ASP.NET Core 8 | `SaborExpressBack/SaborExpress.csproj` | TargetFramework net8.0; no prueba de despliegue |
| Registro de JWT, Swagger, SignalR y servicios en segundo plano | `SaborExpressBack/Program.cs` | Registro de componentes; no certifica seguridad operativa |
| Persistencia EF Core y migraciones | `SaborExpressBack/Data/AppDbContext.cs.cs`, `Program.cs` | Modelos y arranque con MigrateAsync; debe probarse por motor |
| Proveedores MySQL, PostgreSQL y SQL Server seleccionables | `SaborExpressBack/Configuration/DatabaseConfiguration.cs` | Soporte programado; compatibilidad real por motor no validada |
| Autenticación y recuperación de cuentas | `SaborExpressBack/Controllers/AuthController.cs` | Acciones HTTP presentes |
| Creación, consulta, modificación y cancelación de pedidos | `SaborExpressBack/Controllers/OrdersController.cs` | Acciones presentes; flujos sin test ejecutado |
| Wompi: inicio, QR, webhook y sincronización | `SaborExpressBack/Controllers/PaymentsController.cs` | Controlador presente; pagos reales no verificados |
| Estado y calificación de repartos | `SaborExpressBack/Controllers/DeliveriesController.cs` | Acciones presentes |
| Productos públicos, gestión y estado | `SaborExpressBack/Controllers/ProductsController.cs` | Acciones presentes |
| Next.js 16.2.6 y React 19.2.4 | `SaborExpressWeb/package.json` | Versiones declaradas |
| Rutas web de pedidos, empleados, sedes y reportes | `SaborExpressWeb/src/app/.../page.tsx` | Archivos de página identificados |
| Expo 57, React Native 0.86.3 y SignalR | `SaborExpressMovil/package.json` | Dependencias declaradas |

## 3. Lo que sigue pendiente y no debe afirmarse como completado

- Autores, filiación, ficha, instructor, fechas de aceptación y firmas institucionales: no proporcionados.
- Ejecución de `dotnet build`, `npm run build`, E2E, pruebas de pago y pruebas en dispositivos: no realizada en esta entrega.
- Evidencia real de capturas del sistema, métricas p95, cobertura de tests, evaluaciones de usuario: no aportada.
- DDL físico y nombres de tablas/índices del motor de producción: se requiere exportación desde EF o BD.
- Dependencias de infraestructura de producción: dominio, SSL, servidor, backups, costos y SLA son decisiones no cerradas.
- Compatibilidad verificada de tres motores de BD: implementación seleccionable, sin pruebas por motor.
- Autoría del artículo y revisión editorial: pendiente de confirmación de equipo/instructor.

## 4. Calidad del material para subir a Git

Se deben preservar los archivos PDF previos `SENA_*` y la guía limpia anterior para evitar eliminación accidental. Para documentar una revisión, abrir los PDFs y DOCX antes del commit y confirmar que todos los archivos tienen tamaño no nulo. Las carpetas `docs-SaborExpress` y `11-research` añaden documentación en estilo semejante a SRD; no se modifican repositorios de código.

## Fuentes primarias de implementación

- API: https://github.com/yersonct/SaborExpressBack/tree/main
- Web: https://github.com/yersonct/SaborExpressWeb/tree/main
- Móvil: https://github.com/yersonct/SaborExpressMovil/tree/main
- Referencia de presentación: https://github.com/jsgh1/SRD-v1/tree/dev/docs/docs-SRD

**Control documental:** documento elaborado a partir del estado observado en octubre de 2026. Antes de entregar, verificar el commit exacto, responsable, revisión del instructor y cualquier cambio posterior del código.
