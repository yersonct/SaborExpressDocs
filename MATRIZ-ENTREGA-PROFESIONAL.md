# Matriz de entrega profesional — SaborExpress

**Corte documental:** 14-10-2026. **Versión:** 3.0. **Límites:** revisión estática de repositorios y referencias oficiales; no se adjuntan datos de producción ni resultados experimentales ficticios.

## Alcance y documentación

| Expediente | Contenido sustancial | Evidencia / estado |
|---|---|---|
| Acta de constitución | alcance, límites, interesados, hitos, éxito, aceptación | requisitos nominativos por firmar |
| SRS | 25 RF individualizados; 15 RNF; criterios, negativos, trazabilidad | criterios propuestos / pruebas pendientes |
| Análisis | 14 CU completos; roles, reglas, escenarios excepcionales, viabilidad | derivado de puntos de entrada conocidos |
| Propuesta técnica | alternativas, fases, costos por cotizar, matriz de riesgos | sin presupuesto arbitrario |
| Diseño | 5 vistas, 6 ADR, secuencias, seguridad, despliegue propuesto | plano de producción pendiente |
| Diccionario de datos | 8 entidades inspeccionadas y 16 relaciones; guía de extracción física | DDL física pendiente |
| API | 52 operaciones inspeccionadas y sus fichas; tokens y Wompi | OpenAPI exportado pendiente |
| QA | 38 pruebas descritas, plan de observabilidad, criterios de cierre | **ninguna prueba marcada aprobada** |
| Implementación | pasos, matrices de compatibilidad, preflight, reversión | ejecución pendiente |
| Manuales | 16 guías por rol, instalación por componente, soporte técnico | capturas de pantallas pendientes |
| CAPA | 10 riesgos y acciones, prevención, seguimiento | revisión y ejecución pendientes |
| Investigación | artículo español e inglés con metodología, resultados documentales, discusión | necesita autoría, evaluación editorial y posible investigación de campo |

## Convenciones de evidencia

- **Observado en código:** un archivo, modelo, ruta o dependencia está presente en el repo inspeccionado.
- **Derivado:** una consecuencia lógica de una estructura o operación; debe confirmarse en ejecución.
- **Propuesto:** un protocolo, umbral, mejora o planificación; no se atribuye al producto como capacidad probada.
- **Pendiente:** falta certificado, ensayo, captura, fecha, aprobador, métricas o DDL.

## Seguridad de la integración Git

Conservar PDF históricos originales del repositorio. Copiar solo los archivos de este ZIP a la raíz del clon local, revisar `git status` y `git diff --cached --name-status` antes de un commit. El ZIP no crea commits ni altera el origen.
