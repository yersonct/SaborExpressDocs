# Manual de usuario final por rol

**Proyecto:** SaborExpress  |  **Fecha de corte:** 14 de octubre de 2026  |  **Versión:** 2.0  |  **Tipo:** Documento técnico y académico

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

## Fuentes primarias de implementación

- API: https://github.com/yersonct/SaborExpressBack/tree/main
- Web: https://github.com/yersonct/SaborExpressWeb/tree/main
- Móvil: https://github.com/yersonct/SaborExpressMovil/tree/main
- Referencia de presentación: https://github.com/jsgh1/SRD-v1/tree/dev/docs/docs-SRD

**Control documental:** documento elaborado a partir del estado observado en octubre de 2026. Antes de entregar, verificar el commit exacto, responsable, revisión del instructor y cualquier cambio posterior del código.
