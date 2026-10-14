# Guía de arquitectura limpia para SaborExpress

Este documento define una estructura ordenada, con responsabilidad única y una sola vía de entrada para las peticiones, sin romper el comportamiento actual del proyecto.

## 1) Arquitectura actual que ya usa el proyecto

### Backend .NET

El backend ya tiene una base sólida basada en capas modulares:

- [SaborExpressBack/Program.cs](../SaborExpressBack/Program.cs): Composition Root.
- [SaborExpressBack/Controllers](../SaborExpressBack/Controllers): entrada HTTP.
- [SaborExpressBack/Modules](../SaborExpressBack/Modules): features y módulos funcionales.
- [SaborExpressBack/Data](../SaborExpressBack/Data): persistencia y EF Core.
- [SaborExpressBack/Shared](../SaborExpressBack/Shared): infraestructura transversal.
- [SaborExpressBack/Modules/Notifications/Hubs/NotificationHub.cs](../SaborExpressBack/Modules/Notifications/Hubs/NotificationHub.cs): capa real-time.

La intención correcta del flujo es:

Controller -> Service/Application -> Repository/DbContext -> respuesta

Eso es una estructura válida para una arquitectura limpia ligera.

### Frontend web admin

La web ya tiene una organización funcional por features:

- [admin-web/src/app](../admin-web/src/app): rutas y páginas.
- [admin-web/src/features](../admin-web/src/features): negocio por feature.
- [admin-web/src/components](../admin-web/src/components): UI reutilizable.
- [admin-web/src/config](../admin-web/src/config): configuración global.
- [admin-web/src/providers](../admin-web/src/providers): providers compartidos.

### Frontend móvil

El móvil ya usa una orientación por features y contextos:

- [app-movil/src/features](../app-movil/src/features): módulos funcionales.
- [app-movil/src/locales](../app-movil/src/locales): traducciones.
- [app-movil/src/features/userPreferences/context/ClientPreferencesContext.tsx](../app-movil/src/features/userPreferences/context/ClientPreferencesContext.tsx): preferencias + idioma.
- [app-movil/src/features/waiter/hooks/useWaiterSocket.ts](../app-movil/src/features/waiter/hooks/useWaiterSocket.ts): real-time.

---

## 2) Arquitectura objetivo recomendada

La idea es mantener la lógica actual, pero poner cada archivo donde realmente pertenece.

### Backend objetivo

SaborExpressBack/
├── src/
│ ├── API/
│ │ ├── Controllers/
│ │ ├── DTOs/
│ │ └── Middleware/
│ ├── Application/
│ │ ├── Features/
│ │ │ ├── Orders/
│ │ │ │ ├── Services/
│ │ │ │ ├── Interfaces/
│ │ │ │ ├── DTOs/
│ │ │ │ └── Validators/
│ │ │ ├── Products/
│ │ │ ├── Employees/
│ │ │ ├── Notifications/
│ │ │ └── UserPreferences/
│ │ └── Common/
│ │ ├── Constants/
│ │ ├── Exceptions/
│ │ └── Helpers/
│ ├── Domain/
│ │ ├── Entities/
│ │ ├── Enums/
│ │ └── ValueObjects/
│ ├── Infrastructure/
│ │ ├── Data/
│ │ ├── Persistence/
│ │ ├── Auth/
│ │ ├── ExternalServices/
│ │ └── Realtime/
│ └── Shared/
│ ├── Localization/
│ ├── Authorization/
│ ├── Filters/
│ └── BackgroundServices/
├── Program.cs
├── appsettings.json
└── README.md

Reglas:

- Controller solo recibe y responde.
- Service ejecuta la lógica de negocio.
- Repository/DbContext accede a datos.
- DTOs para contratos de entrada/salida.
- Validadores y excepciones están en Application/Common.
- Los hubs y conexiones en el área de Infraestructura/Realtime.

### Frontend web objetivo

admin-web/src/
├── app/
│ ├── (auth)/
│ ├── (dashboard)/
│ └── layout.tsx
├── components/
│ ├── ui/
│ ├── layout/
│ └── feedback/
├── config/
│ ├── api.ts
│ ├── i18n.ts
│ └── env.ts
├── features/
│ ├── auth/
│ │ ├── components/
│ │ ├── hooks/
│ │ ├── services/
│ │ └── types/
│ ├── dashboard/
│ ├── orders/
│ ├── products/
│ ├── employees/
│ ├── notifications/
│ └── settings/
├── hooks/
├── lib/
├── providers/
├── store/
├── types/
├── utils/
└── styles/

Reglas:

- Las pantallas no deben hacer llamadas HTTP directas.
- Los servicios deben vivir inside cada feature.
- Los hooks reutilizables en `hooks/` o en la feature.
- Los estilos deben estar en componentes o archivos de estilo por feature.
- Los textos traducidos se manejan centralmente desde config/i18n.

### Frontend móvil objetivo

app-movil/src/
├── app/
│ ├── navigation/
│ ├── screens/
│ └── routes/
├── features/
│ ├── auth/
│ │ ├── context/
│ │ ├── hooks/
│ │ ├── services/
│ │ └── types/
│ ├── orders/
│ ├── products/
│ ├── notifications/
│ ├── waiter/
│ ├── cart/
│ └── userPreferences/
├── shared/
│ ├── api/
│ ├── network/
│ ├── storage/
│ ├── theme/
│ └── utils/
├── locales/
├── components/
├── hooks/
└── constants/

Reglas:

- Cada feature encapsula su vista, hooks, services y contexto.
- El websocket debe quedar dentro del feature que lo usa o en shared si se reutiliza por toda la app.
- Los providers deben servir solo a su dominio.
- La lógica de datos no debe mezclarse con estilos visuales.

---

## 3) Patrón de una sola vía de entrada

La idea es que cada petición siga una misma ruta para evitar duplicación y errores.

### Backend

Request -> Controller -> Application Service -> Repository -> DB

Ejemplo:

- POST /api/orders
- Controller OrdersController
- Service CreateOrderService
- Repository IOrderRepository
- DbContext

### Frontend web

UI -> feature service -> API client -> backend

Ejemplo:

- View
- hook useOrders()
- service orders.service.ts
- api client

### Frontend móvil

Screen -> feature hook -> feature service -> API or WebSocket

Esto evita:

- llamadas al backend desde componentes visuales
- lógica en pantallas muy cargadas
- servicios duplicados
- estados inconsistentes

---

## 4) Principios que deben mantenerse

1. Responsabilidad única
   Cada archivo debe hacer una cosa.

2. Separación por feature
   Cada módulo funcional vive en su propia carpeta.

3. Capas claras
   UI, aplicación, dominio, infraestructura.

4. Reutilización real
   Solo lo reutilizable va a shared o components.

5. Sin cambios de comportamiento
   Primero reorganizar carpetas y niveles, luego mover lógica útil en pequeñas etapas.

6. Real-time separado
   SignalR/WebSocket debe estar en una capa dedicada y no mezclado con la vista.

---

## 5) Orden recomendado de migración

1. Ordenar backend por feature y capas.
2. Ordenar web admin por feature y services.
3. Ordenar móvil por feature + hooks + services.
4. Centralizar i18n y configuración.
5. Aislar WebSocket/SignalR en servicios dedicados.
6. Dejar API layer única para cada dominio.
7. Verificar que no se rompe la navegación ni las llamadas.

---

## 6) Qué NO hacer

- No meter lógica de negocio dentro de componentes visuales.
- No dejar llamadas HTTP en pantallas.
- No mezclar traducciones con componentes.
- No dejar callbacks de WebSocket en varias partes del proyecto.
- No duplicar servicios por cada pantalla.

---

## 7) Conclusión

El proyecto ya tiene una buena base modular; lo que falta es reforzar la disciplina del orden. La arquitectura correcta para este repo es:

- Backend: modular + layered + feature-first
- Web admin: feature-first + services + UI reusable
- Móvil: feature-first + context + hooks + services
- Realtime: servicio aislado y centralizado
- Request flow: una sola vía de entrada por dominio

Esto permite crecer sin romper nada y mantener el código entendible.
