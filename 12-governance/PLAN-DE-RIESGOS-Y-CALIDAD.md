# Plan de riesgos, calidad y continuidad del proyecto SaborExpress

**Autor:** Yerson Stiven Cuellar Rubiano. **Ficha:** 3145555. **Fecha:** 14 de octubre de 2026. **Naturaleza:** plan propuesto basado en inspección de repositorios.

## 1. Identificación y alcance de riesgos

Un riesgo es un evento incierto que puede afectar costo, seguridad, calidad, plazo o confianza. No se asignan porcentajes de probabilidad sin datos históricos. La severidad se propone mediante valoración ordinal y debe ratificarse con el responsable técnico. La gestión se inspira en ciclo identificar–analizar–tratar–verificar–actualizar. Revisar cada cambio de código y en cada hito de entrega.

| Riesgo | Activo | Consecuencia | Medida propuesta | Evidencia de control |
|---|---|---|---|---|
| R-01 Autorización entre sedes | Pedidos, empleados | exposición de datos | filtro por sede, role y recurso | QA-SEC-03 |
| R-02 Webhook repetido | Pagos | cobro imputado dos veces | clave de idempotencia, transacción | QA-PAY-02 |
| R-03 Firma Wompi inválida | Pagos | suplantación evento | verificar checksum y referencia | QA-PAY-01 |
| R-04 Migración en startup | Esquema | caída, colisión al despliegue | migración controlada y respaldo | prueba restauración |
| R-05 Versiones clientes | Compatibilidad | fallos de pedidos | contratos versionados y regresión | pruebas de contrato |
| R-06 Filtración de secretos | API/pagos | credenciales expuestas | escaneo, rotación, vault | reporte de escaneo |
| R-07 Fallo de conectividad | Dispositivos | pedidos duplicados | idempotencia, recuperación | pruebas offline |
| R-08 Dependencia de proveedor | Servicios externos | indisponibilidad parcial | timeouts, cola y estado explícito | simulación caída |

## 2. Gestión del cambio

Antes del merge debe existir issue que vincule código, requisito y QA. El pull request debe describir modificación, migración, prueba, autorización, riesgo y plan de retroceso. Evitar commit de secretos; proteger rama principal; versionar los anexos técnicos simultáneamente. Cambios de tarifa y disponibilidad en servicios externos exigen nueva cotización.

## 3. Calidad, entrega y archivo

Una entrega documental aceptable dispone de fuente primaria, índice navegable, tablas rotuladas, diagramas legibles, bibliografía comprobable y archivo editable. Una entrega de software aceptable requiere compilar y superar casos técnicos previstos en el ambiente acordado; ambas condiciones son distintas. Los artefactos reproducibles deben conservar SHA, licencia y fechas.

## 4. Seguimiento por hito

Se proponen hitos: línea base y configuración, contratos y datos, pedidos y pagos, operaciones de reparto/cocina, seguridad y recuperación, evaluación empírica y sustentación. Cada hito documentará evidencia, observaciones, acciones, responsable y aprobación; ninguna fase se da por terminada solo por escritura documental.
