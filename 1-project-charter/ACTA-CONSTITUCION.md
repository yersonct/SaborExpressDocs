# Acta de constitución y alcance del proyecto

**Proyecto:** SaborExpress  |  **Fecha de corte:** 14 de octubre de 2026  |  **Versión:** 2.0  |  **Tipo:** Documento técnico y académico

**Estado de la evidencia:** inspección documental y estática del código. Las pruebas de ejecución y los datos institucionales no aportados no se presumen realizados.

## 1. Identificación

**Nombre:** SaborExpress. **Naturaleza:** desarrollo de plataforma para operación y pedidos gastronómicos, con clientes web y móvil y backend central. **Equipo / ficha SENA / instructor / entidad patrocinadora:** pendientes de datos confirmados por sus responsables.

## 2. Justificación

La coordinación digital de catálogo, atención de mesa, preparación, pagos y domicilios puede mejorar trazabilidad operativa. El beneficio medible aún debe comprobarse en un piloto; aquí se registra una solución de ingeniería y su alcance técnico verificable.

## 3. Objetivo general

Analizar, documentar y validar una plataforma digital integrada para gestionar operaciones de restaurantes mediante API REST modular, portal web y aplicación móvil.

## 4. Alcance incluido y excluido

Incluye gestión de usuarios/roles, sedes, personal, catálogo, pedidos, pagos, reparto, notificaciones y configuraciones observadas en código. Excluye: prueba de operación real a escala, seguridad certificada, condiciones contractuales de Wompi, costos finalizados, mercadeo y flota física.

## 5. Entregables

SRS, análisis, propuesta, diseño, datos, catálogo API/Postman, instalación, manuales, plan de pruebas, matriz de trazabilidad, correctivos, informe de cierre y artículos académicos.

## 6. Interesados, cronograma y riesgos

Los roles de responsabilidad se definirán en acta aprobada. Cronograma relativo P1–P6 según propuesta técnica, sin fechas comprometidas. Riesgos principales: autorización intersede, cobros, migraciones, disponibilidad, datos personales, ausencia de pruebas reproducibles.

## 7. Criterios de aprobación

La documentación se considera entregable para **revisión**, no aceptada, cuando cada formato abre, los requisitos tienen pruebas trazables, el artículo identifica límites y los manuales corresponden a SHA documentados. La aprobación académica requiere revisión del instructor y evidencias operativas.


## 8. Línea base de alcance, gobernanza y entregables

| Elemento | Alcance detallado | No se afirma |
| --- | --- | --- |
| Producto | API REST de restaurante + clientes web y móvil | que sea microservicio o producción |
| Usuarios | cliente, caja, cocina, reparto, gerencia y administración | piloto con usuarios realizado |
| Funcional | pedidos, pagos, sedes, catálogo, personal, entregas | todos los módulos aceptados |
| Documental | SRS, SDD, plan QA, manuales y artículo científico | aprobación institucional |
| Plataforma | ASP.NET Core 8, Next.js 16, Expo 57 | calidad del despliegue real |
| Investigación | estudio de caso documental y bibliografía dirigida | experimentos de campo |
| Ejecución | propuesta de fases con hitos verificables | fechas, costos y nombres inventados |


## 9. Hitos y criterios de decisión

**H1 Alcance y requisitos aprobados:** matriz SRS revisada por responsable funcional, reglas de sede y pago precisadas. **H2 Arquitectura aprobada:** diagramas y ADR versionados, motor de datos oficial acordado. **H3 Desarrollo y contratos:** build reproducible de tres clientes, OpenAPI validado, migraciones aprobadas. **H4 Seguridad/calidad:** pruebas de autorización, Wompi, respaldo y carga ejecutadas con evidencia. **H5 Entrenamiento/piloto:** personal realiza flujos en sandbox y reporta hallazgos. **H6 Entrega:** informe final, aceptación, inventario de versiones y transferencia operativa.

**Gobierno del proyecto:** solicitante, responsable funcional, líder técnico, desarrolladores, QA, operación y protección de datos; personas y fechas por asignar. Actas de decisión y cambios se almacenan en documentación. Un hito se considera cerrado solo con evidencia y aceptación formal.


## 10. Criterios de éxito y límites

- Integridad de pedidos y de pagos respaldada por pruebas.
- Segregación por rol, cliente y sede probada.
- Manuales de instalación/operación replicables en equipo limpio.
- Respaldo y restauración ejecutados.
- Riesgos críticos controlados y firmados.
- Métricas de rendimiento y usabilidad definidas antes de medir.

Los anteriores son criterios propuestos, no resultados. Presupuesto total, duración, roles nominativos, establecimiento piloto y propiedad intelectual requieren información aportada por el equipo.

## 10. Gestión de interesados y comunicación

La gobernanza propuesta requiere un patrocinador funcional para validar objetivos, un representante de operación gastronómica que confirme estados y reglas de negocio, un responsable de backend para contratos y datos, responsables de interfaz web y móvil, un equipo de calidad para evidencias y un propietario documental para vigencia de los entregables. No se dispone de designaciones nominales ni firmas; los cargos constituyen roles de proyecto sugeridos.

El equipo celebrará revisión de avance por incremento o entrega funcional, registrará decisiones en acta con ID, contexto, alternativas, decisión, impacto, responsable y fecha, y conservará las aprobaciones dentro de un sistema de control de versiones. Las decisiones con consecuencia financiera, de seguridad o privacidad requieren la revisión simultánea de operaciones, backend y pruebas, incluso si una implementación concreta solo toca una capa.

### 10.1. Matriz de responsabilidades de referencia

| Actividad | Responsable de ejecución | Revisión / aprobación | Evidencia mínima |
| --- | --- | --- | --- |
| Alcance de pedido | Analista funcional | Representante operativo | SRS y acta |
| Cambios API | Backend | Líder técnico y clientes | OpenAPI y casos de prueba |
| Validación de caja/pagos | Integraciones | QA y operaciones | Pruebas sandbox y conciliación |
| Entregas y tracking | Móvil / backend | Operaciones y QA | Caso de entrega sintético |
| Documentación | Responsable documental | Líder técnico/instructor | Commit, versión y aprobaciones |
| Seguridad | Responsable designado | Líder técnico | Matriz de riesgos y remediación |

## 11. Criterios de transición de etapas

**Salida de análisis:** requisitos con identificadores, actor, disparador, pre/postcondiciones y criterios de aceptación revisados. **Salida de diseño:** arquitectura actual, contratos, modelo de datos conceptual, amenazas e impactos de cambio aceptados. **Salida de construcción:** builds reproducibles e integraciones registradas. **Salida de validación:** actas con procedimiento, ambiente, resultado observado, evidencia y defectos abiertos. **Salida a producción:** backup y restauración probados, secretos externalizados, TLS y dominios correctos, monitoreo y procedimiento de reversión aprobados.

No se considera cumplido un hito por disponer únicamente del archivo que lo nombra. Una matriz con evidencia, fecha y firma debe acompañarlo. El cierre académico es distinto del despliegue comercial.

## 12. Supuestos, restricciones y condiciones de éxito

Se asume que el equipo podrá ejecutar los tres proyectos con configuraciones compatibles, que la pasarela de pago ofrece sandbox y que la base de datos de prueba podrá reconstruirse sin usar información de clientes. Las restricciones son el acceso a infraestructura operativa, licencias y secretos, la necesidad de coordinación entre tres repositorios y los límites de verificación estática. La adopción real y la rentabilidad no son indicadores que puedan concluirse mediante revisión de código.

Se considerará éxito documental cuando: todos los documentos de la matriz tengan contenido y control de versión; los hallazgos apunten a archivos verificables; las referencias científicas puedan localizarse; la SRS se relacione con escenarios de prueba; los manuales permitan un arranque en entorno nuevo; y las pruebas no realizadas se mantengan señaladas hasta producir evidencia auténtica.

## Fuentes primarias de implementación

- API: https://github.com/yersonct/SaborExpressBack/tree/main
- Web: https://github.com/yersonct/SaborExpressWeb/tree/main
- Móvil: https://github.com/yersonct/SaborExpressMovil/tree/main
- Referencia de presentación: https://github.com/jsgh1/SRD-v1/tree/dev/docs/docs-SRD

**Control documental:** documento elaborado a partir del estado observado en octubre de 2026. Antes de entregar, verificar el commit exacto, responsable, revisión del instructor y cualquier cambio posterior del código.
