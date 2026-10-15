# Pruebas de seguridad propuestas para integrar en CI

## Control de recursos

- Usuario A consulta `/api/Orders/{id}` de usuario B: denegar si no tiene permiso específico.
- Repartidor A solicita asignaciones de repartidor B: denegar.
- Administrador sede A modifica producto exclusivo de sede B: denegar.
- Token vencido o manipulado: 401, sin cambio persistente.

## Pagos

- Enviar Wompi webhook sin `X-Event-Checksum`: resultado rechazado según política.
- Enviar dos veces el mismo evento con referencia: una sola imputación.
- Cambiar total de pedido en cliente: servicio recalcula o rechaza.
- Simular evento fuera de orden (FAILED tras APPROVED): no degradar un pago confirmado si la política lo impide.

## Pruebas de recuperación

- Interrumpir respuesta HTTP después de persistencia: cliente no crea duplicados.
- Cortar websocket: cliente reconcilia estado por API REST.
- Restaurar base en ambiente aislado y comparar conteos/integridad referencial.

**Estado:** casos de diseño, no ejecuciones certificadas.
