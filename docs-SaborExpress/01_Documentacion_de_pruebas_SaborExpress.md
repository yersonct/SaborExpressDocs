# Plan de pruebas, evidencias y aceptación

**Proyecto:** SaborExpress  |  **Fecha de corte:** 14 de octubre de 2026  |  **Versión:** 2.0  |  **Tipo:** Documento técnico y académico

**Estado de la evidencia:** inspección documental y estática del código. Las pruebas de ejecución y los datos institucionales no aportados no se presumen realizados.

## 1. Principio de evidencia

**Estado general: NO EJECUTADO en esta elaboración.** Este documento diseña pruebas reproducibles; no hay actas, capturas de ejecución ni registros de CI entregados que permitan certificarlas como aprobadas. Se inspeccionaron rutas y código fuente, no se desplegó la aplicación ni se realizaron cobros.

## 2. Estrategia por niveles

Pruebas unitarias de servicios y validadores; integración con EF Core sobre base efímera; contrato API desde Swagger y Postman; E2E por rol; seguridad negativa de roles/recursos; sandbox de Wompi; carga de HTTP/SignalR; accesibilidad/usabilidad; restauración/recuperación; despliegue y smoke. Cada prueba debe registrar commit, ambiente, conjunto de datos sintéticos, ejecutor, fecha y resultado observado.

## 3. Casos críticos propuestos

| ID | Grupo | Datos/estímulo | Resultado esperado | Ejecución |
| --- | --- | --- | --- | --- |
| CP-01 | Auth válido | Credenciales de prueba válidas | Login exitoso, JWT válido | Pendiente |
| CP-02 | Auth inválido | Contraseña errónea | Respuesta controlada sin token | Pendiente |
| CP-03 | Token expirado | JWT fuera de vigencia | 401 | Pendiente |
| CP-04 | Token manipulado | Firma inválida | 401 | Pendiente |
| CP-05 | Acceso intersede | Admin de sede A consulta B | 403 o filtrado seguro | Pendiente |
| CP-06 | Producto público | GET catálogo sede | Solo productos de sede y globales | Pendiente |
| CP-07 | Crear producto sin rol | Cliente invoca POST | 403 | Pendiente |
| CP-08 | Crear pedido | Detalle consistente | 201 + total calculado | Pendiente |
| CP-09 | Pedido negativo | Cantidad <=0 | Rechazado sin persistencia | Pendiente |
| CP-10 | Pedido domicilio | Sin dirección | Regla de validación consistente | Pendiente |
| CP-11 | Cancelación propia | Cliente propietario, estado admisible | Cancelación controlada | Pendiente |
| CP-12 | Cancelación ajena | Cliente distinto | 403/404 seguro | Pendiente |
| CP-13 | Estado inválido | Transición de pedido prohibida | Conflicto controlado | Pendiente |
| CP-14 | Pago válido | Sandbox Wompi firma válida | Un pago reconciliado | Pendiente |
| CP-15 | Webhook adulterado | Checksum incorrecto | No se aplica pago | Pendiente |
| CP-16 | Webhook repetido | Mismo evento dos veces | Idempotencia | Pendiente |
| CP-17 | Pago rechazado | Sandbox REJECTED | No cambiar a pagado | Pendiente |
| CP-18 | QR cajero | Generar link desde turno válido | Referencia y valor correctos | Pendiente |
| CP-19 | Cierre de caja | Pagos del cajero actual | No mezcla de empleados | Pendiente |
| CP-20 | Entrega ajena | Repartidor A pide B | Acceso rechazado | Pendiente |
| CP-21 | Calificación | Cliente propietario de entrega | Guardar solo 1..5 | Pendiente |
| CP-22 | SignalR | Cliente autorizado suscrito | Evento recibido/reconexión | Pendiente |
| CP-23 | DB falla | Interrumpir motor | Sin corrupción ni secretos en error | Pendiente |
| CP-24 | Migración | BD efímera desde cero | Schema coherente | Pendiente |
| CP-25 | Rollback | Restaurar backup de prueba | Integridad post-restauración | Pendiente |
| CP-26 | Carga HTTP | Carga y duración declaradas | p50/p95 medidos | Pendiente |
| CP-27 | Usabilidad | Tareas por roles voluntarios | Tiempos, errores, SUS si aplica | Pendiente |

## 4. Ambiente y datos sintéticos

Preparar usuarios por cada rol y dos sedes ficticias, productos y pedidos conocidos, cuentas de sandbox, copia limpia de BD de test y timezone consistente. Guardar definición de pruebas sin claves ni información de clientes reales. Controlar estado inicial/final de cada caso para evitar contaminación entre pruebas.

## 5. Matriz de cobertura y formato de resultado

Criterio: 100% de requisitos de prioridad crítica con al menos un caso positivo y uno negativo; cobertura restante acordada por QA. Esta es una **meta**, no porcentaje actual. Plantilla de registro: `ID / SHA / versión / ambiente / datos / pasos / esperado / observado / evidencia / estado / responsable`.

## 6. Requisitos para declarar aceptación

No hay incidentes críticos abiertos, pagos conciliados de forma idempotente, segregación por sede verificada, backup/restore demostrado, documentación e instrucción de usuarios aprobadas y métricas no funcionales medidas contra umbrales acordados. No usar el presente documento para afirmar aprobación del instructor o QA.

## Fuentes primarias de implementación

- API: https://github.com/yersonct/SaborExpressBack/tree/main
- Web: https://github.com/yersonct/SaborExpressWeb/tree/main
- Móvil: https://github.com/yersonct/SaborExpressMovil/tree/main
- Referencia de presentación: https://github.com/jsgh1/SRD-v1/tree/dev/docs/docs-SRD

**Control documental:** documento elaborado a partir del estado observado en octubre de 2026. Antes de entregar, verificar el commit exacto, responsable, revisión del instructor y cualquier cambio posterior del código.
