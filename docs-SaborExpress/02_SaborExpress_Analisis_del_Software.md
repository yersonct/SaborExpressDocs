# Análisis del software SaborExpress

**Proyecto:** SaborExpress  |  **Fecha de corte:** 14 de octubre de 2026  |  **Versión:** 2.0  |  **Tipo:** Documento técnico y académico

**Estado de la evidencia:** inspección documental y estática del código. Las pruebas de ejecución y los datos institucionales no aportados no se presumen realizados.

## 1. Problema de negocio

Una operación gastronómica combina catálogo, atención de mesa, cocina, caja, despachos y reparto. Cuando estos procesos usan registros aislados, se incrementa el riesgo de confusión de estados, transcripciones manuales y baja trazabilidad. La solución analizada centraliza contratos y datos de pedidos a través de una API; esto es una justificación de diseño, no una medición real de reducción de errores.

## 2. Interesados y responsabilidades

| Interesado | Necesidad | Acciones principales |
| --- | --- | --- |
| Cliente | Comprar y dar seguimiento | Catálogo, pedido, pago, cancelación, calificación |
| Cajero | Consolidar transacciones | Pedido, cobro, cierre de turno |
| Cocina | Atender órdenes | Tablero, cambios de estado por plato |
| Administrador | Coordinar sede | Personal, productos, horarios, caja, entregas |
| Repartidor | Gestionar domicilio | Órdenes asignadas, estatus, ubicación |
| Gerente | Supervisar operación | Sedes, reportes, permisos |
| Equipo técnico | Operar y mantener | API, migraciones, logs, incidentes |

## 3. Casos de uso principales

### CU-01. Inicio de sesión

Precondición: usuario registrado. Flujo: introducir credenciales → enviar `POST /api/Auth/login` → recibir respuesta o error controlado → habilitar rutas conforme a roles. Excepciones: cuenta no activada, correo sin confirmar, intentos fallidos, token inválido. Postcondición: sesión autenticada según el contrato de la API.

### CU-02. Gestión del catálogo

Precondición: sede o catálogo disponible. Flujo: `GET /api/Products` con `branchId` opcional, elegir productos, consultar categorías. Actor administrador puede crear, modificar o inhabilitar productos bajo permisos específicos. Excepciones: producto inexistente, sede inactiva, error de imagen.

### CU-03. Pedido y cocina

El usuario selecciona detalles, cantidades y tipo (comer en sitio, para llevar o domicilio). Se envía `POST /api/Orders`; el personal consulta vistas filtradas y actualiza estado mediante PATCH. El tablero de cocina atiende etapas operativas; se deben demostrar las transiciones válidas en pruebas futuras.

### CU-04. Cobro por pasarela

Se inicia la transacción con Wompi; el backend genera una referencia y expone un webhook para confirmación de eventos externos. La sincronización por ID funciona como alternativa de consulta. Riesgos: firmas erróneas, eventos duplicados, carrera entre confirmación y cancelación, latencia del proveedor.

### CU-05. Domicilio y entrega

Gerente o administrador asigna entrega; repartidor consulta sus órdenes, actualiza estados, cliente califica. Se deben validar reglas de privacidad y segregación por sede.

## 4. Flujos de información

`Interfaz → servicio de cliente → HTTP/JWT → controlador → servicio de dominio → repositorio/EF → BD`. Para notificaciones: `evento de negocio → notificación → hub SignalR → cliente suscrito`; el código del Hub prueba su existencia, no la garantía de entrega.

## 5. Escenarios excepcionales y riesgos

| ID | Escenario | Comportamiento esperado | Prueba pendiente |
| --- | --- | --- | --- |
| EX-01 | JWT expirado | 401 y renovación guiada | Token caducado |
| EX-02 | Acceso a otra sede | 403 sin filtrar información | Prueba cruzada |
| EX-03 | Webhook repetido | No duplicar pago | Repetición mismo evento |
| EX-04 | Falla de base de datos | Respuesta controlada + recuperación | Interrupción de DB |
| EX-05 | Pérdida de SignalR | Reintento o estado reconciliado | Reconexión |
| EX-06 | Dirección inválida | Validación sin pedido inconsistente | Caso domicilio |
| EX-07 | Estado de cocina incompatible | Rechazo de transición | Secuencia inválida |
| EX-08 | Pago rechazado | Pedido no aparece abonado | Sandbox Wompi |

## 6. Análisis de viabilidad

**Técnica:** el stack identificado dispone de bibliotecas y convenciones para la integración. **Operativa:** requiere roles, política de turnos y manuales por actor. **Financiera:** no hay datos reales de costos operativos, por lo que no se presenta ROI; se incluye una matriz de rubros a cotizar. **Jurídica y de privacidad:** se requiere política de tratamiento de datos, términos y controles de seguridad para operación real.

## 7. Hallazgos y decisiones abiertas

Los controladores contienen numerosas operaciones, pero el repositorio no demuestra por sí solo la cobertura de tests, permisos en profundidad ni consistencia multi-proveedor de las migraciones. El archivo `README.md` del repositorio documental describía Supabase como backend principal, contradiciendo el proyecto .NET inspeccionado; esta versión lo corrige.

## Fuentes primarias de implementación

- API: https://github.com/yersonct/SaborExpressBack/tree/main
- Web: https://github.com/yersonct/SaborExpressWeb/tree/main
- Móvil: https://github.com/yersonct/SaborExpressMovil/tree/main
- Referencia de presentación: https://github.com/jsgh1/SRD-v1/tree/dev/docs/docs-SRD

**Control documental:** documento elaborado a partir del estado observado en octubre de 2026. Antes de entregar, verificar el commit exacto, responsable, revisión del instructor y cualquier cambio posterior del código.
