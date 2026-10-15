# Diseño y arquitectura del software

**Proyecto:** SaborExpress  |  **Fecha de corte:** 14 de octubre de 2026  |  **Versión:** 2.0  |  **Tipo:** Documento técnico y académico

**Estado de la evidencia:** inspección documental y estática del código. Las pruebas de ejecución y los datos institucionales no aportados no se presumen realizados.

## 1. Visión de arquitectura

SaborExpress presenta tres repositorios de software separados y un repositorio documental. El backend es **una aplicación ASP.NET Core modular**, no diez microservicios ni una infraestructura distribuida comprobada. El frontend web administra vistas de negocio; el móvil utiliza Expo Router y módulos por función.

![Arquitectura lógica derivada de los repositorios](ARQUITECTURA-COMPONENTES.png)

*Figura 1. Vista lógica propuesta a partir de estructuras y configuraciones de los repositorios. No representa una topología de producción verificada.*

## 2. Vista de desarrollo (Kruchten, 1995)

| Componente | Estructura real | Responsabilidad |
| --- | --- | --- |
| API | Controllers/ | Frontera HTTP |
| API | Modules/*/DTOs | Contratos de entrada/salida |
| API | Modules/*/Services | Lógica de dominio |
| API | Modules/*/Repositories | Persistencia |
| API | Data/Configurations | Mapeos EF Core |
| Web | src/app/*/page.tsx | Páginas de Next.js |
| Web | src/features, src/components | Funciones e interfaz |
| Móvil | src/features/* | Vistas, hooks, servicios |
| Móvil | app.json, package.json | Runtime Expo y dependencias |

## 3. Vista de ejecución

Inicio de API: `Program.cs` registra CORS, controladores, JWT, autorización (`ActiveShift`), DbContext, dependencias, clientes HTTP, Swagger, SignalR y servicios hospedados (turnos, enlaces de cocina, expiración de rol, sincronización de Wompi). También ejecuta `MigrateAsync` y seeders de permisos, rol cliente y gerente inicial. En producción se recomienda separar migraciones y seeds de arranque automático y auditar la idempotencia.

## 4. Vista lógica de negocio

Dominios observados: identidad y roles; sedes; usuarios, clientes y empleados; horarios; catálogos y menú; mesas; pedidos/detalles e historial; pagos; domicilios; notificaciones; preferencias; reseñas y facturas. Las clases Entity Framework enlazan pedidos con sede, cliente, dirección, empleado y mesa, además de colecciones de detalles, estados y pagos.

## 5. Vista de despliegue (objetivo, pendiente de verificar)

**Desarrollo local:** `Next.js → ASP.NET Core API → motor relacional`; aplicación móvil usa URL de red accesible desde dispositivo, no `localhost` del teléfono. **Producción propuesta:** HTTPS, dominio y proxy de capa 7, backend .NET, DB administrada o aislada, almacenamiento protegido y monitoreo. No existe en la evidencia una definición definitiva de infraestructura productiva.

## 6. Secuencia transaccional crítica

![Secuencia de pago y actualización de pedidos](SECUENCIA-PAGOS.png)

La pasarela puede confirmar asíncronamente. El webhook `POST /api/Payments/wompi/webhook` admite acceso anónimo a nivel de controlador para permitir notificaciones de Wompi; el **servicio** debe comprobar checksum/firma, correspondencia de referencia, idempotencia y validez de estados. No se documenta como seguro por el mero hecho de existir.

## 7. Decisiones arquitectónicas (ADR)

| ADR | Decisión | Justificación | Estado |
| --- | --- | --- | --- |
| ADR-001 | Mantener API modular .NET | Código actual y costo de despliegue | Constatada como arquitectura actual |
| ADR-002 | Clientes web y móvil separados | Flujos operativos distintos | Constatado |
| ADR-003 | Contratos REST y canal SignalR | Datos + avisos en vivo | Registrado, no medido |
| ADR-004 | DB provider configurable | Código soporta tres proveedores | Soporte real a validar |
| ADR-005 | Wompi para cobros | Controlador y DTO identificados | Sandbox pendiente |
| ADR-006 | Secrets solo por env o Secret Manager | Seguridad y despliegue | Recomendación |

## 8. Análisis de amenazas y mitigaciones

Autorización de objeto: validar propietario y sede para cada ID proporcionado. Webhook: firma y replay protection. Datos: proteger contraseñas BCrypt, tokens y documentos; jamás registrar bodies sensibles completos. CORS: acotar orígenes al ambiente. Migraciones: respaldo y rollback antes de producción. Imágenes: límites MIME/tamaño, sanitización y rutas no predecibles. Evaluar riesgos según OWASP API Security Top 10 2023.

## Fuentes primarias de implementación

- API: https://github.com/yersonct/SaborExpressBack/tree/main
- Web: https://github.com/yersonct/SaborExpressWeb/tree/main
- Móvil: https://github.com/yersonct/SaborExpressMovil/tree/main
- Referencia de presentación: https://github.com/jsgh1/SRD-v1/tree/dev/docs/docs-SRD

**Control documental:** documento elaborado a partir del estado observado en octubre de 2026. Antes de entregar, verificar el commit exacto, responsable, revisión del instructor y cualquier cambio posterior del código.
