# Manual de usuario final por rol

**Proyecto:** SaborExpress | **Autor / integrante:** Yerson Stiven Cuellar Rubiano | **Ficha:** 3145555 | **Fecha:** 14 de octubre de 2026 | **Versión documental:** 4.0

**Estado de la evidencia:** inspección documental y estática del código. Las pruebas de ejecución y los datos institucionales no aportados no se presumen realizados.

## 1. Introducción y condiciones

Este manual describe recorridos funcionales inferidos de pantallas identificadas y endpoints. Nombres y ubicación exacta de botones pueden variar y necesitan capturas de la versión final. Para ingresar se requieren credenciales personales autorizadas; no se proporcionan usuarios compartidos ni contraseñas por defecto.

## 2. Cliente (móvil)

**Ingresar:** abrir la aplicación, seleccionar iniciar sesión, indicar correo y contraseña, completar confirmación/activación si procede. **Consultar productos:** elegir sede o ubicación, revisar categorías, descripción y precio. **Realizar pedido:** añadir productos, confirmar cantidades, domicilio/mesa/retiro según pantalla; revisar resumen e importe antes de confirmar. **Pagar:** elegir medio de pago disponible. Para Wompi, seguir el flujo seguro del proveedor y esperar confirmación de estado; no cerrar proceso suponiendo que “pendiente” significa “aprobado”. **Consultar estado:** abrir pedidos y revisar cambios. **Calificar reparto:** tras entrega completada, utilizar la opción disponible.

## 3. Cajero y mesero

Iniciar sesión con rol correspondiente y turno válido; acceder a pedidos/mesas; verificar sede y mesa; registrar pedido y sus productos; confirmar observaciones de cocina; cuando corresponda, registrar pago o presentar QR; al cerrar turno, revisar operaciones propias. Si un pago Wompi está pendiente, no marcar arbitrariamente el pedido como pagado.

## 4. Cocina

Visualizar órdenes entrantes en tablero, identificar mesa, modalidad y detalle; iniciar preparación según reglas de operación; marcar ítems terminados; comunicar novedades evitando editar pagos. Si existe enlace de cocina público, controlar su caducidad y no compartirlo indiscriminadamente.

## 5. Repartidor

Acceder al panel de entregas asignadas; revisar dirección y contacto solo en el alcance necesario; aceptar o marcar estado conforme al flujo; entregar sin compartir datos personales; reportar incidente mediante canal organizacional. No manipular órdenes de otros repartidores.

## 6. Administrador de sede

Acceder al panel Next.js; administrar personal, horarios, catálogo, productos, mesas, pedidos y repartos según sus permisos. Verificar siempre la sede activa antes de hacer cambios. Consultar reportes disponibles sin inferir ingresos adicionales que no estén registrados.

## 7. Gerente

Gestionar sedes y supervisar la operación permitida. Revisar acceso a reportes, pagos, empleados y entregas. Antes de eliminar un elemento, comprobar implicaciones en historial y auditoría.

## 8. Problemas frecuentes

| Situación | Acción del usuario | Escalamiento |
| --- | --- | --- |
| No entra a su cuenta | Revisar correo/clave, recuperación y activación | Soporte con hora y mensaje de error |
| Pedido no aparece | Comprobar sede y sincronizar consulta | Caja/soporte con ID de pedido |
| Pago pendiente | No repetir cobro automáticamente; esperar conciliación | Caja/soporte, sin compartir token |
| No llegan notificaciones | Ver permisos, red y sesión | Soporte con versión del dispositivo |
| No aparece repartidor | Consultar asignación de la sede | Administrador |
| Producto agotado | No confirmar sustituciones sin cliente | Cocina y caja |

## 9. Privacidad y uso responsable

No compartir claves, documentos de clientes ni capturas con información privada en grupos externos. Cerrar sesión en equipos compartidos. Reportar cambios no reconocidos en pedidos y pagos. No usar información ficticia como si fuera evidencia de ventas reales.


## 8. Procedimientos detallados por perfil

Esta guía utiliza los roles identificados en backend y componentes web/móvil. Los nombres de botones pueden variar por versión; las instrucciones se basan en flujos funcionales respaldados por controladores y no sustituyen una validación con capturas actualizadas.


### U01. Registro e ingreso

**Perfil:** Cliente. **Objetivo:** completar la operación correspondiente con la identidad autorizada y los datos correctos de la sede.

**Pasos de usuario:** Abrir app, elegir acceso, escribir credenciales o registro, completar verificaciones que muestre la interfaz, confirmar estado de sesión.

**Resultado a comprobar:** el listado o detalle debe reflejar el registro actualizado; si aparece un código de error o una demora, consultar el estado actual antes de reintentar.

**Advertencia:** Códigos de recuperación deben quedar privados; nunca compartir contraseña. **Escalamiento:** reportar a soporte el identificador de pedido y una captura sin tokens, contraseñas ni información personal ajena.


### U02. Consultar sedes y carta

**Perfil:** Cliente. **Objetivo:** completar la operación correspondiente con la identidad autorizada y los datos correctos de la sede.

**Pasos de usuario:** Elegir sede, revisar categorías y disponibilidad; regresar al catálogo si el producto cambia de estado.

**Resultado a comprobar:** el listado o detalle debe reflejar el registro actualizado; si aparece un código de error o una demora, consultar el estado actual antes de reintentar.

**Advertencia:** El catálogo puede incluir productos globales y locales. **Escalamiento:** reportar a soporte el identificador de pedido y una captura sin tokens, contraseñas ni información personal ajena.


### U03. Crear pedido

**Perfil:** Cliente. **Objetivo:** completar la operación correspondiente con la identidad autorizada y los datos correctos de la sede.

**Pasos de usuario:** Añadir producto/cantidad, verificar tipo de consumo, dirección si es domicilio, revisar total y confirmar solo una vez.

**Resultado a comprobar:** el listado o detalle debe reflejar el registro actualizado; si aparece un código de error o una demora, consultar el estado actual antes de reintentar.

**Advertencia:** Conservar número de orden y evitar reenviar ante conexión lenta. **Escalamiento:** reportar a soporte el identificador de pedido y una captura sin tokens, contraseñas ni información personal ajena.


### U04. Pagar Wompi

**Perfil:** Cliente. **Objetivo:** completar la operación correspondiente con la identidad autorizada y los datos correctos de la sede.

**Pasos de usuario:** Elegir medio disponible, completar flujo de pasarela sin cerrar prematuramente y esperar estado de pedido reflejado.

**Resultado a comprobar:** el listado o detalle debe reflejar el registro actualizado; si aparece un código de error o una demora, consultar el estado actual antes de reintentar.

**Advertencia:** No confundir redirección con confirmación financiera; informar al soporte si demora. **Escalamiento:** reportar a soporte el identificador de pedido y una captura sin tokens, contraseñas ni información personal ajena.


### U05. Cancelar pedido propio

**Perfil:** Cliente. **Objetivo:** completar la operación correspondiente con la identidad autorizada y los datos correctos de la sede.

**Pasos de usuario:** Abrir detalle del pedido y usar cancelación solo cuando la interfaz y política lo habiliten.

**Resultado a comprobar:** el listado o detalle debe reflejar el registro actualizado; si aparece un código de error o una demora, consultar el estado actual antes de reintentar.

**Advertencia:** Si cocina ya procesa, el sistema puede rechazar cancelación. **Escalamiento:** reportar a soporte el identificador de pedido y una captura sin tokens, contraseñas ni información personal ajena.


### U06. Consultar entrega y calificar

**Perfil:** Cliente. **Objetivo:** completar la operación correspondiente con la identidad autorizada y los datos correctos de la sede.

**Pasos de usuario:** Abrir seguimiento, revisar cambios de reparto y calificar entrega propia cuando finalice.

**Resultado a comprobar:** el listado o detalle debe reflejar el registro actualizado; si aparece un código de error o una demora, consultar el estado actual antes de reintentar.

**Advertencia:** Evitar compartir ubicaciones o referencias de pedido. **Escalamiento:** reportar a soporte el identificador de pedido y una captura sin tokens, contraseñas ni información personal ajena.


### U07. Ingresar y activar turno

**Perfil:** Cajero. **Objetivo:** completar la operación correspondiente con la identidad autorizada y los datos correctos de la sede.

**Pasos de usuario:** Iniciar sesión con su cuenta, comprobar turno asignado y sede antes de registrar cobros.

**Resultado a comprobar:** el listado o detalle debe reflejar el registro actualizado; si aparece un código de error o una demora, consultar el estado actual antes de reintentar.

**Advertencia:** Si acceso es rechazado por turno, solicitar corrección al administrador. **Escalamiento:** reportar a soporte el identificador de pedido y una captura sin tokens, contraseñas ni información personal ajena.


### U08. Crear cobro presencial

**Perfil:** Cajero. **Objetivo:** completar la operación correspondiente con la identidad autorizada y los datos correctos de la sede.

**Pasos de usuario:** Identificar pedido, confirmar subtotal/total mostrado, elegir método y registrar exactamente una transacción.

**Resultado a comprobar:** el listado o detalle debe reflejar el registro actualizado; si aparece un código de error o una demora, consultar el estado actual antes de reintentar.

**Advertencia:** Ante error, buscar pago existente antes de repetir. **Escalamiento:** reportar a soporte el identificador de pedido y una captura sin tokens, contraseñas ni información personal ajena.


### U09. Crear cobro QR

**Perfil:** Cajero. **Objetivo:** completar la operación correspondiente con la identidad autorizada y los datos correctos de la sede.

**Pasos de usuario:** Seleccionar orden, solicitar QR Wompi y mostrarlo al cliente; comprobar evento confirmado.

**Resultado a comprobar:** el listado o detalle debe reflejar el registro actualizado; si aparece un código de error o una demora, consultar el estado actual antes de reintentar.

**Advertencia:** Un QR generado no prueba que esté pagado. **Escalamiento:** reportar a soporte el identificador de pedido y una captura sin tokens, contraseñas ni información personal ajena.


### U10. Revisar cierre de turno

**Perfil:** Cajero. **Objetivo:** completar la operación correspondiente con la identidad autorizada y los datos correctos de la sede.

**Pasos de usuario:** Consultar my-shift y conciliar registros con soportes físicos y digitales.

**Resultado a comprobar:** el listado o detalle debe reflejar el registro actualizado; si aparece un código de error o una demora, consultar el estado actual antes de reintentar.

**Advertencia:** Diferencias deben elevarse al gerente, sin editar manualmente historial. **Escalamiento:** reportar a soporte el identificador de pedido y una captura sin tokens, contraseñas ni información personal ajena.


### U11. Administrar mesa

**Perfil:** Mesero. **Objetivo:** completar la operación correspondiente con la identidad autorizada y los datos correctos de la sede.

**Pasos de usuario:** Verificar sede, elegir mesa correcta, crear orden y revisar detalle por mesa.

**Resultado a comprobar:** el listado o detalle debe reflejar el registro actualizado; si aparece un código de error o una demora, consultar el estado actual antes de reintentar.

**Advertencia:** Evitar acciones de otra sede o duplicar pedido. **Escalamiento:** reportar a soporte el identificador de pedido y una captura sin tokens, contraseñas ni información personal ajena.


### U12. Seguir cola de pedidos

**Perfil:** Cocinero. **Objetivo:** completar la operación correspondiente con la identidad autorizada y los datos correctos de la sede.

**Pasos de usuario:** Acceder al tablero, seleccionar orden y marcar etapas cuando el proceso físico corresponda.

**Resultado a comprobar:** el listado o detalle debe reflejar el registro actualizado; si aparece un código de error o una demora, consultar el estado actual antes de reintentar.

**Advertencia:** Tras pérdida de red recargar estado desde API. **Escalamiento:** reportar a soporte el identificador de pedido y una captura sin tokens, contraseñas ni información personal ajena.


### U13. Consultar entregas propias

**Perfil:** Repartidor. **Objetivo:** completar la operación correspondiente con la identidad autorizada y los datos correctos de la sede.

**Pasos de usuario:** Autenticarse, revisar orden, dirección y estado de disponibilidad cuando corresponda.

**Resultado a comprobar:** el listado o detalle debe reflejar el registro actualizado; si aparece un código de error o una demora, consultar el estado actual antes de reintentar.

**Advertencia:** No consultar ni modificar entregas de otros repartidores. **Escalamiento:** reportar a soporte el identificador de pedido y una captura sin tokens, contraseñas ni información personal ajena.


### U14. Actualizar entrega

**Perfil:** Repartidor. **Objetivo:** completar la operación correspondiente con la identidad autorizada y los datos correctos de la sede.

**Pasos de usuario:** Reportar estado que refleje el avance real y confirmar entrega según procedimiento local.

**Resultado a comprobar:** el listado o detalle debe reflejar el registro actualizado; si aparece un código de error o una demora, consultar el estado actual antes de reintentar.

**Advertencia:** No alterar estado final para corregir error sin soporte. **Escalamiento:** reportar a soporte el identificador de pedido y una captura sin tokens, contraseñas ni información personal ajena.


### U15. Gestionar sede, productos y personal

**Perfil:** Administrador. **Objetivo:** completar la operación correspondiente con la identidad autorizada y los datos correctos de la sede.

**Pasos de usuario:** Entrar al panel web, revisar sede en encabezado, crear/editar registro y validar resultado en listado.

**Resultado a comprobar:** el listado o detalle debe reflejar el registro actualizado; si aparece un código de error o una demora, consultar el estado actual antes de reintentar.

**Advertencia:** Datos personales de empleados requieren autorización. **Escalamiento:** reportar a soporte el identificador de pedido y una captura sin tokens, contraseñas ni información personal ajena.


### U16. Consultar reportes y sedes

**Perfil:** Gerente. **Objetivo:** completar la operación correspondiente con la identidad autorizada y los datos correctos de la sede.

**Pasos de usuario:** Entrar a panel, elegir sede y revisar filtros por período; confirmar fuente de cada métrica.

**Resultado a comprobar:** el listado o detalle debe reflejar el registro actualizado; si aparece un código de error o una demora, consultar el estado actual antes de reintentar.

**Advertencia:** La página de reportes existe, pero sus KPIs exactos se verifican en el navegador. **Escalamiento:** reportar a soporte el identificador de pedido y una captura sin tokens, contraseñas ni información personal ajena.


## 9. Mensajes, errores frecuentes y solución del usuario

| Mensaje o síntoma | Significado posible | Qué hacer | Qué NO hacer |
| --- | --- | --- | --- |
| No autorizado | sesión ausente o expirada | ingresar otra vez por canal oficial | compartir token |
| Acceso prohibido | rol o sede insuficiente | solicitar permiso al administrador | usar cuenta ajena |
| Pedido no aparece | filtros o falta de sincronización | comprobar sede y refrescar | crear varios pedidos |
| Pago pendiente | confirmación externa no recibida | esperar consulta/sincronización, contactar caja | pagar repetidas veces |
| Producto no disponible | catálogo cambió | seleccionar alternativa | forzar petición manual |
| Notificación tardía | conexión SignalR interrumpida | recargar estado desde consulta | asumir que no existió operación |
| Dirección inválida | error de geocodificación | corregir campos y ubicación | revelar localización en grupo |


## 10. Buenas prácticas y protección de información

Cierre sesión en dispositivos compartidos. No fotografíe claves, códigos de recuperación ni tarjetas. Evite comunicar información de pedidos ajenos. En caso de error en cobros, nunca realice una segunda transacción sin comprobar primero si la anterior fue contabilizada. Repartidores solo deben usar las direcciones necesarias durante la entrega. Personal de caja no debe modificar estados financieros por fuera de procesos autorizados. Reporte incidentes con una referencia no sensible, horario aproximado, módulo y mensaje, sin compartir datos de tarjeta o contraseña.


## 11. Guion de capacitación y aceptación

**Cliente (15 min propuestos):** ingreso, catálogo, pedido, pago simulado, seguimiento, cancelación; tarea aprobada si reconoce confirmación y evita doble pago.

**Cajero (20 min):** turno, cobro, QR, conciliación, detección de pago pendiente; escenario de doble evento.

**Cocina y mesero (15 min):** consulta de cola y mesa, actualización correcta, cambio de sede y reconexión.

**Repartidor (15 min):** aceptación/consulta de entrega, cambio de estado, intento de visualizar entrega ajena.

**Administrador/gerente (25 min):** personal, productos y sedes; ajustes de permisos y revisión de registros.

**Registro obligatorio:** fecha, versión, asistentes voluntarios, tareas, resultado observado, incidentes, cambios UX y autorización para publicar capturas. No se indica que estas sesiones se hayan efectuado.


## Fuentes primarias de implementación

- API: https://github.com/yersonct/SaborExpressBack/tree/main
- Web: https://github.com/yersonct/SaborExpressWeb/tree/main
- Móvil: https://github.com/yersonct/SaborExpressMovil/tree/main
- Referencia de presentación: https://github.com/jsgh1/SRD-v1/tree/dev/docs/docs-SRD

**Control documental:** documento elaborado a partir del estado observado en octubre de 2026. Antes de entregar, verificar el commit exacto, responsable, revisión del instructor y cualquier cambio posterior del código.


## 13. Guía de tareas por perfil y controles de errores

**Cliente:** entrar al catálogo, escoger sede, revisar productos y precios, confirmar unidades y tipo de pedido, revisar dirección de entrega si procede, consultar el importe antes de confirmar y esperar respuesta con identificador. Si se presenta fallo de red, consultar historial antes de intentar otra compra para no crear duplicados. Para pago Wompi, no compartir claves ni repetir el enlace indiscriminadamente; la confirmación de la pasarela debe reflejarse en el estado que entrega el sistema.

**Cajero:** iniciar sesión y comprobar turno vigente cuando corresponda, consultar pedidos activos, registrar cobro permitido, verificar estado y comprobante, no marcar manualmente como pagado un pedido con intento Wompi pendiente y revisar resumen de turno. Ante pago dudoso, escalar a gerente, no alterar valores en el cliente.

**Cocina:** visualizar tablero asociado a sede, seleccionar pedido, comprobar estado de detalle, registrar preparación según permisos y revisar que no existan duplicados del mismo pedido. Ante una desconexión, reabrir estado persistente antes de repetir una acción.

**Repartidor:** consultar asignaciones visibles, confirmar dirección autorizada, actualizar únicamente entregas propias, respetar los estados disponibles y solicitar apoyo si la información de pedido no coincide con la asignación. La ubicación, cuando se utilice, se trata conforme a la política de privacidad de la institución.

**Gerente/administrador:** ingresar al panel web, administrar sedes, productos y empleados según rol, aplicar cambios fuera de horarios críticos, revisar avisos de cambios y garantizar que los permisos concedidos sean mínimos. No registrar datos personales de producción durante demostraciones.

## 14. Mapa visual de tareas


![08_CASOS_USO](recursos/08_CASOS_USO.png)

*Nota. Elaboración para el estudio de caso SaborExpress; las figuras no certifican operaciones desplegadas.*
## 15. Guía de accesibilidad y ayuda

En tareas importantes, presentar mensajes claros y recuperables, evitar depender exclusivamente de color, confirmar acciones irreversibles, disponer navegación táctil accesible y mantener tamaño de texto apropiado. La guía describe el comportamiento deseado de la interfaz; se requiere contraste con pantallas reales para afirmar que cada criterio se cumple.

