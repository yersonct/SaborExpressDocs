# Árbol de problemas e hipótesis de caso (NO evidencia de incidentes)

**Problema central:** falta de evidencia integral y reproducible que conecte pedidos, cocina, caja, pagos, domicilios y permisos de SaborExpress.

**Causas hipotéticas:** contratos API cambiantes entre clientes; permisos de sede probados parcialmente; servicios externos y desconexiones; cobertura de pruebas con versiones distintas.

**Efectos potenciales (NO observados):** pedido o pago en estado inconsistente, datos intersede expuestos, retraso de entrega, dificultades de soporte.

**Caso documental A:** cliente web que usa un contrato distinto al backend; evaluación mediante OpenAPI y pruebas de integración. **Caso documental B:** webhook de pago repetido; prueba propuesta con Wompi sandbox. **Caso documental C:** acceso de trabajador de sede A a pedidos de sede B; prueba propuesta con dos sedes. **Caso real de restaurante:** pendiente de entrevista y registro autorizado.
