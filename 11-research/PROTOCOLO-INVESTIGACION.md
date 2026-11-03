# Protocolo de investigación para etapa experimental

**Proyecto:** SaborExpress  |  **Fecha de corte:** 14 de octubre de 2026  |  **Versión:** 2.0  |  **Tipo:** Documento técnico y académico

**Estado de la evidencia:** inspección documental y estática del código. Las pruebas de ejecución y los datos institucionales no aportados no se presumen realizados.

## Hipótesis exploratorias

H1: Los tiempos de completar pedidos bajo sistema digital podrían diferir frente al procedimiento actual. H2: La claridad del estado de pago influiría en errores de cobro observados. H3: La experiencia de reparto y facilidad de uso se relacionarían con satisfacción. Ninguna hipótesis está contrastada.

## Diseño propuesto

Estudio mixto posterior con medidas de operaciones en ambiente controlado, tareas con usuarios voluntarios autorizados y evaluación de pagos en sandbox. Definir muestra, tamaño y método de selección, consentimiento, anonimización, instrumentos y análisis antes de ejecutar. Para desempeño incluir n de solicitudes, perfiles de carga, herramienta, entorno y percentiles p50/p95. Para aceptación, escalas TAM/UTAUT adaptadas con prueba de validez local.

## Variables e instrumentos

| Variable | Tipo | Operacionalización |
| --- | --- | --- |
| Tiempo de registro de pedido | Cuantitativa | Segundos desde iniciar a confirmación |
| Tasa de errores | Cuantitativa | Errores/total tareas |
| Confirmaciones de pago duplicadas | Conteo | Eventos repetidos procesados |
| Utilidad percibida | Ordinal | Escala validada con consentimiento |
| Facilidad de uso | Ordinal | Cuestionario + tareas |
| P95 de API | Cuantitativa | Carga instrumentada versionada |

## Ética y transparencia

No recolectar documentos, correos reales, GPS preciso ni información bancaria innecesaria. Solicitar permiso escrito y publicar resultados agregados. Reportar hallazgos negativos y limitaciones sin alteración.

## Fuentes primarias de implementación

- API: https://github.com/yersonct/SaborExpressBack/tree/main
- Web: https://github.com/yersonct/SaborExpressWeb/tree/main
- Móvil: https://github.com/yersonct/SaborExpressMovil/tree/main
- Referencia de presentación: https://github.com/jsgh1/SRD-v1/tree/dev/docs/docs-SRD

**Control documental:** documento elaborado a partir del estado observado en octubre de 2026. Antes de entregar, verificar el commit exacto, responsable, revisión del instructor y cualquier cambio posterior del código.
