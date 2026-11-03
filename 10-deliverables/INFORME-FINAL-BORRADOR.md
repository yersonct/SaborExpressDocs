# Informe final de ingeniería — versión documental

**Proyecto:** SaborExpress  |  **Fecha de corte:** 14 de octubre de 2026  |  **Versión:** 2.0  |  **Tipo:** Documento técnico y académico

**Estado de la evidencia:** inspección documental y estática del código. Las pruebas de ejecución y los datos institucionales no aportados no se presumen realizados.

## 1. Síntesis del trabajo

Este expediente reúne un análisis del estado de código de SaborExpress a octubre de 2026 y documentos de requisitos, diseño, datos, interfaz, operación e investigación. No se ha realizado una evaluación experimental ni aceptación del sistema.

## 2. Sistema caracterizado

API central ASP.NET Core 8, EF Core, JWT, SignalR y procesos hospedados; interfaz administrativa web Next.js 16/React 19; móvil Expo 57/React Native 0.86; persistencia relacional con configuración de motores alternativos. Existe integración programada con Wompi que exige validación real en sandbox.

## 3. Evidencia y método

Se consultaron `Program.cs`, los manifiestos, controladores de dominio, modelos de entidad y estructura de carpetas. Se construyó una matriz de brechas documentales y pruebas futuras. Este informe puede servir como línea base para la presentación del proyecto, no como demostración de rendimiento.

## 4. Principales entregables de la carpeta

| Categoría | Resultado |
| --- | --- |
| 01 | SRS y acta de constitución |
| 02 | Análisis funcional y propuesta técnica |
| 03 | Diseño arquitectónico y diagramas |
| 04 | Manual técnico y de instalación |
| 05 | Manual por roles |
| 06 | Datos y catálogo API |
| 07 | Pruebas/trazabilidad/mejora |
| 08 | Artículo científico ES y EN |

## 5. Conclusiones y próximas actividades

El software puede caracterizarse como una solución modular multi-cliente. El conjunto de documentos elimina vacíos y corrige descripciones obsoletas. La mejora prioritaria es ejecutar pruebas reproducibles de integridad, pagos, autorizaciones, usabilidad y migraciones; completar capturas reales y actas de aprobación.

**Aprobación del equipo / instructor:** pendiente; no se inventa firma.


## 7. Estado detallado de entregables y evidencia

| Entregable | Evidencia documental | Validación faltante |
| --- | --- | --- |
| Requisitos | RF-01..25 / RNF-01..15 | aprobación y ensayos |
| Análisis | 14 casos de uso extendidos | contrastar pantallas y servicios |
| Diseño | vistas, diagramas y ADR | revisión técnica de componentes |
| Datos | 8 entidades C# inspeccionadas | DDL del motor y restricciones EF |
| API | 52 rutas inventariadas de 6 controladores | export OpenAPI y resto de controllers |
| Calidad | 38 casos de prueba diseñados | ejecución y actas |
| Instalación | runbook multi-cliente | entorno fresco |
| Usuario | 16 procedimientos por rol | capturas y capacitación |
| Investigación | artículos ES/EN y bibliografía | autoría/ajuste revista y revisión externa |
| Operación | controles y plan de mejora | simulacro incidente y copias |


## 8. Resultados observados vs. resultados pendientes

**Observado en repositorio:** stack .NET 8 con EF Core y SignalR, clientes Next.js y Expo, rutas para pedidos, productos, pagos y entregas, DbSets de múltiples dominios y existencia de lógica Wompi. **No observado experimentalmente:** tasa de transacciones exitosas, disponibilidad real, carga máxima, beneficio comercial, satisfacción de usuarios, precisión de geolocalización y seguridad demostrada.

Los diagramas documentan la arquitectura inferida; un diagrama no sustituye trazas o configuración desplegada. El informe se clasifica como cierre **documental preliminar**, no acta de puesta en producción.


## 9. Conclusiones, amenazas a validez y recomendaciones

La separación de clientes y una API centralizada constituyen una base verificable para centralizar flujos gastronómicos. El dominio integra relaciones críticas pedido–pago–entrega y permisos por sede. Sin embargo, la robustez operativa requiere resolver idempotencia de Wompi, aislamiento de objetos, estrategia de migración y evidencia de pruebas.

**Limitaciones:** acceso a código fuente, no a ambiente de despliegue; fuentes bibliográficas dirigidas, no revisión sistemática completa; no se dispone de registros de usuarios ni instrumentación; no hay aprobación del instructor ni métricas de producción.

**Siguientes hitos:** congelar SHAs, reproducir build, extraer OpenAPI y esquema físico, ejecutar los casos críticos, formalizar manuales de pantalla con capturas y actualizar este informe con resultados observados, hallazgos y bibliografía completa.

## 10. Análisis del cumplimiento de los objetivos documentales

La inspección de código permitió reconocer el conjunto de clientes y componentes, mapear dominios de negocio y construir una línea base de documentación. Se cumplieron objetivos exclusivamente documentales: especificación de necesidades, caracterización de arquitectura, inventario parcial de contratos y modelos, preparación de escenarios de prueba y fundamentación bibliográfica. No se confirma el cumplimiento de objetivos que exigen ejecución, producción, satisfacción de usuarios o métricas de rendimiento.

El valor del expediente reside en aportar trazabilidad del trabajo y facilitar que un revisor pueda comprender qué existe, dónde está implementado y cómo habría que comprobarlo. También identifica diferencias entre la descripción inicial del README y las dependencias actuales del proyecto, especialmente en la caracterización del backend. La denominación correcta es una API ASP.NET Core modular, no un sistema de microservicios verificados.

## 11. Valoración por dimensiones de calidad

| Dimensión | Hallazgo documentado | Prueba requerida |
| --- | --- | --- |
| Adecuación funcional | Rutas y modelos de negocio identificados | Casos de aceptación usuario/operación |
| Seguridad | JWT, roles y políticas presentes | Prueba negativa BOLA y Wompi |
| Fiabilidad | Persistencia relacional y transiciones | Fallo/reintento y recuperación |
| Mantenibilidad | Módulos backend y features clientes | Cobertura de pruebas, complejidad |
| Portabilidad | Dockerfile API y clientes multiplataforma | Construcción en ambiente fresco |
| Rendimiento | No se obtuvo instrumentación real | Carga p50/p95 con configuración descrita |
| Usabilidad | Pantallas y componentes disponibles | Prueba de tareas con usuarios |
| Compatibilidad | Versiones múltiples de clientes y API | Pruebas de contratos compatibles |

## 12. Discusión de resultados y limitaciones

El sistema presenta una separación técnica de preocupaciones suficiente para desarrollar una documentación profesional por componentes. No obstante, el repositorio de documentos contenía originalmente archivos binarios de tamaño cero y afirmaciones tecnológicas desactualizadas. Esas brechas dificultan revisión, reproducción y sustentación de decisiones, por lo que fueron un objetivo de esta intervención documental.

La inspección es una modalidad de evidencia limitada: la existencia de una acción API demuestra intención e implementación estructural, pero no funcionamiento correcto en ambiente real. Del mismo modo, la presencia de políticas de autorización no permite deducir aislamiento total entre sedes sin casos negativos. La literatura científica sirve para establecer variables de calidad y confianza, no para atribuir a SaborExpress resultados estadísticos obtenidos en otros países.

## 13. Recomendaciones de cierre y hoja de ruta

Se propone ejecutar primero pruebas de integridad de pedido–detalle–pago, seguido de aislamiento de clientes y sedes, webhook auténtico e idempotente, recuperación de red, control de turnos, restauración de la base de datos y compatibilidad de versiones de móvil. Después podrán instrumentarse tiempos y errores en servidor, realizar pruebas de accesibilidad y recoger percepción de usuarios con consentimiento.

La entrega de artículos científicos debe pasar por una revisión final de autoría, filiación, bibliografía alfabética, coincidencia entre referencias y citas, licencia de figuras y declaraciones éticas. Antes de una sustentación deben reemplazarse capturas esquemáticas por evidencia de los módulos operativos y documentar resultados reales sin alterarlos.

## 14. Registro final de pendientes no simulables

| Pendiente | Por qué no se puede afirmar terminado | Prueba material requerida |
| --- | --- | --- |
| Aceptación funcional | Sin acta de usuario/QA | Firmas y ejecución de casos |
| Esquema físico SQL | Modelo con proveedor configurable | DDL exportado por motor |
| Despliegue estable | Sin acceso a infraestructura objetivo | Health, logs, trazas y respaldo |
| Rendimiento | Sin carga medida | Reporte JMeter/k6/otro |
| Usabilidad | Sin estudio de tareas | Consentimiento, protocolos, resultados |
| Conformidad editorial | Sin aprobación del instructor o revista | Plantilla, firmas y revisión |

## 15. Cierre del expediente

Este documento constituye un **informe final de caracterización documental y preparación de validación**, no una certificación final del producto software. La versión pasa a estado “lista para revisión técnica y académica” una vez se cotejen los documentos con el commit objetivo, se eliminen secretos de los artefactos y el equipo apruebe el contenido. El cierre de pruebas, explotación y publicación exige evidencia adicional de los responsables correspondientes.

## Fuentes primarias de implementación

- API: https://github.com/yersonct/SaborExpressBack/tree/main
- Web: https://github.com/yersonct/SaborExpressWeb/tree/main
- Móvil: https://github.com/yersonct/SaborExpressMovil/tree/main
- Referencia de presentación: https://github.com/jsgh1/SRD-v1/tree/dev/docs/docs-SRD

**Control documental:** documento elaborado a partir del estado observado en octubre de 2026. Antes de entregar, verificar el commit exacto, responsable, revisión del instructor y cualquier cambio posterior del código.
