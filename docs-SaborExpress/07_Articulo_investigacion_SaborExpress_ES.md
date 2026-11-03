# Arquitectura, trazabilidad y verificación técnica de una plataforma web y móvil para operaciones gastronómicas: estudio de caso SaborExpress

**Yerson Stiven Cuéllar Rubiano** · SENA CIES, ADSO 3145555 · 3 noviembre 2026 / November 3, 2026

**Resumen.** Este estudio examina qué afirmaciones sobre la integración funcional de SaborExpress pueden sostenerse mediante evidencia de repositorios y pruebas identificadas por versión. Se empleó un estudio de caso documental y descriptivo, complementado con una revisión dirigida de literatura, extracción de contratos y análisis de registros de validación publicados. La plataforma integra una API ASP.NET Core 8, una interfaz Next.js y un cliente Expo/React Native, con procesos de pedidos, cocina, caja, pagos y domicilios. El informe documental del 3 de noviembre de 2026 registra 90 pruebas de seguridad, 62 de QA y 11 de facturación PDF aprobadas localmente en un candidato de backend, así como 7 pruebas web y 8 móviles sobre otros SHA; estas cifras describen conjuntos de pruebas de alcance limitado, no aceptación integral. Una verificación local de readiness del backend candidato respondió 503 por migraciones pendientes, mientras que un smoke de staging anterior fue satisfactorio. Se concluye que existe evidencia de implementación y verificación parcial, pero no de mejora causal, despliegue integral o aceptación de usuarios. Se proponen instrumentos y controles replicables para cerrar esas brechas.

**Palabras clave:** gestión gastronómica; ingeniería de software; estudio de caso; trazabilidad; validación; aplicaciones web y móviles

## I. INTRODUCCIÓN

Las operaciones de un restaurante conectan catálogo, sedes, personal, mesas, pedidos, cocina, caja y entregas. En sistemas multicliente, una modificación de estados o permisos en el servidor puede alterar la interacción web y móvil. La literatura sobre reparto de comida destaca confianza, calidad de servicio y experiencia de usuario [1]–[5], mientras que TAM y UTAUT orientan investigaciones sobre adopción [6], [7]. Ninguno de esos estudios acredita resultados de SaborExpress. Este trabajo aporta una cadena de evidencia que diferencia arquitectura declarada, pruebas observadas, limitaciones y acciones pendientes.

## II. PROBLEMA, PREGUNTA Y OBJETIVOS

Problema: la documentación previa caracterizó riesgos plausibles de inconsistencias de pedidos, pagos, sedes y reparto, sin una línea base levantada en un establecimiento real. El árbol analítico de problemas identifica como nodo central la insuficiente trazabilidad comprobada entre operaciones y evidencia de calidad; como causas hipotéticas, cambios contractuales entre clientes, permisos por sede no evaluados integralmente y dependencias externas; como posibles efectos, duplicidades o estados inconsistentes. Estas relaciones son hipótesis de trabajo, no incidentes medidos. Pregunta: ¿qué capacidades y resultados de verificación pueden identificarse de forma reproducible en el conjunto documental y técnico de SaborExpress, y qué validaciones faltan para sustentar preparación operativa? Objetivo general: caracterizar la arquitectura y valorar la suficiencia de evidencia de sus flujos críticos. Objetivos específicos: (1) identificar componentes y límites arquitectónicos; (2) relacionar riesgos con estándares y fuentes académicas; (3) tabular pruebas por SHA, entorno y alcance; (4) proponer instrumentos de validación funcional y con usuarios.

## III. MARCO DE REFERENCIA Y VIGILANCIA TECNOLÓGICA

La síntesis de Shroff et al. [1] y la revisión de Shankar et al. [2] contextualizan actores y sistemas de entrega digital. Prasetyo et al. [3], Fakfare [4] y Koay et al. [5] examinan atributos de satisfacción y calidad desde otros contextos. Davis [6] y Venkatesh et al. [7] sirven para operacionalizar utilidad, facilidad y aceptación futura, pero sus constructos todavía no han sido medidos aquí. Kruchten [8] fundamenta separar vistas arquitectónicas; Taibi et al. [9] ayuda a contrastar patrones sin afirmar que una aplicación modular sea una arquitectura de microservicios. Yin [10] orienta el estudio de caso; Kitchenham y Charters [11] ayudan a hacer explícitos criterios de selección bibliográfica. ISO/IEC 25010 [12] proporciona atributos de calidad, OWASP [13] orienta casos de autorización y RFC 9110 y 7519 [14], [15] describen contratos HTTP y JWT. La matriz complementaria registra 15 fuentes con identificadores y síntesis aplicadas. Se trata de revisión dirigida y no de una búsqueda exhaustiva certificada.

## IV. MÉTODO E INSTRUMENTOS

Diseño: estudio de caso descriptivo, documental, no experimental y de corte transversal, con actualización documental al 3 de noviembre de 2026. Unidad: el sistema SaborExpress y sus repositorios Back, Web, Móvil y Docs. Instrumentos aplicados en la evidencia documental consultada: ficha de extracción de tecnologías, tabla de trazabilidad ruta–cliente, y revisión de resultados de QA consignados en el informe de cierre del repositorio Docs. Jerarquía: A) ejecución de pruebas con identificador y entorno; B) hallazgo de código o configuración; C) propuesta no ejecutada. No se realizaron entrevistas ni encuestas en este trabajo de edición; se anexa formulario propuesto sin respuestas. Fuentes de datos: código y manifiestos disponibles, artículo previo, README y reporte 9-traceability/CIERRE-HU-2026-11-03.md. Para reproducir: fijar SHA, entorno, comandos y salida de CI; no comparar métricas de SHA diferentes como si fueran un experimento controlado. Se excluyen credenciales, transacciones y datos personales reales.

## V. RESULTADOS OBSERVADOS

Arquitectura: backend central ASP.NET Core 8/EF Core con autenticación JWT y comunicación SignalR; portal administrativo Next.js y aplicación móvil Expo/React Native. Los dominios documentados comprenden sedes, catálogo, personal, pedidos, pagos Wompi, cocina, caja y entregas. El expediente informa un OpenAPI generado desde un SHA anterior del backend con 269 rutas, 346 operaciones y 84 esquemas; ese inventario no constituye prueba de funcionamiento de cada operación. Contratos estáticos: Web 92/92 firmas ruta+método y Móvil 47/47 coincidieron contra el OpenAPI de referencia; no se verificaron payloads ni semántica en ejecución. Validaciones locales: backend candidato 17a8ce4 reporta Security 90/90, QA 62/62 y Invoice PDF 11/11; Web aa5cb8d reporta 7/7; Móvil af52bba registra 8/8. Una auditoría Playwright web con API sintética reportó 1/1 prueba en 11 pantallas; no constituye estudio de usabilidad. Smoke HTTP local: /health 200 y /health/ready 503 por migraciones pendientes. Un smoke de staging sobre el SHA anterior ac2b39e fue satisfactorio el 29 de octubre de 2026; no valida el candidato actual. Una serie histórica k6 registró una ejecución que cumplió umbrales y dos que no cumplieron la condición de encabezado Server-Timing. Las cifras provienen del expediente de cierre; no fueron reejecutadas durante la preparación de este artículo.

## VI. DISCUSIÓN Y AMENAZAS A LA VALIDEZ

Las pruebas de código y CI demuestran comprobaciones delimitadas, no la ejecución de extremo a extremo del negocio en producción. El backend candidato continúa sin integración a main, y la evidencia de Web y Móvil corresponde a versiones distintas. La comparación de rutas es una prueba de compatibilidad estática, no de autorización, idempotencia de pagos ni consistencia concurrente. Los escenarios OWASP de acceso entre sedes, las firmas de webhook de Wompi, la reconciliación después de desconexión, el control de secretos y los recorridos con siete roles requieren verificación adicional. Validez de constructo: ruta declarada ≠ operación correcta; validez interna: sin diseño antes/después no hay atribución causal; validez externa: un proyecto no representa al sector; replicabilidad: conservar SHAs, artefactos y entorno. No hay registro de entrevista a restaurante ni encuesta a usuarios; por tanto no se presentan tasas de aceptación ni diagnóstico de necesidades reales.

## VII. PROTOCOLO DE VALIDACIÓN Y TRABAJO FUTURO

Se propone un piloto con un responsable operativo y, sujeto a consentimiento, uno o más usuarios reales. Antes de ejecutar se debe capturar sede, rol, escenario, versión, fecha y autorización; aplicar entrevista semiestructurada y tarea observada; anonimizar respuestas; y registrar discrepancias entre resultado esperado y observado. En entorno de pruebas aislado: (a) pedidos/cocina/caja/domicilios por siete roles y dos sedes; (b) rechazo de accesos horizontales y verticales; (c) webhooks duplicados y alterados con proveedor sandbox; (d) pérdida de conexión y recuperación; (e) pruebas de carga con dataset y umbrales explícitos; (f) migraciones, rollback y copias de seguridad; (g) prueba en dispositivo e impresora. Los formatos anexos son instrumentos preparados, no aplicados.

## VIII. CONCLUSIONES

El estudio caracteriza una solución gastronómica web y móvil basada en backend modular y establece una cadena de trazabilidad entre código, documentación, estándares y validaciones con SHA. La evidencia de pruebas locales y CI representa avance verificable respecto de la versión exclusivamente documental, pero es insuficiente para afirmar aceptación de usuarios, disponibilidad en producción o cierre total de historias de usuario. La contribución investigativa es delimitar qué puede concluirse y cómo repetir las verificaciones, y proponer un piloto de campo y un protocolo técnico que permitirían contrastar los riesgos identificados.

## IX. DECLARACIONES

Autor declarado del manuscrito: Yerson Stiven Cuéllar Rubiano (sujeto a confirmación personal de contribuciones y autoría). Afiliación: SENA, Centro de la Industria, la Empresa y los Servicios, ficha ADSO 3145555. Financiación y conflictos de interés: no se aportó información comprobable; el autor debe confirmarlos antes de presentar. Ética: no se realizó investigación con participantes en esta revisión; los instrumentos sin aplicar requieren autorización y consentimiento. Disponibilidad de datos: repositorios públicos citados y evidencia documental según SHA. Uso de inteligencia artificial: se utilizó ChatGPT (OpenAI, familia GPT-6) el 3 de noviembre de 2026 para apoyar la reorganización, redacción, traducción y generación de archivos de esta versión. Los resultados técnicos se extrajeron de los documentos existentes y no fueron generados experimentalmente por la herramienta. Corresponde al autor humano leer, contrastar referencias, verificar afirmaciones y aprobar esta declaración; deben añadirse otras herramientas si se utilizaron.

## REFERENCIAS

[1] Shroff, A., Shah, B. J., and Gajjar, H., “Online food delivery research: A systematic literature review,” *International Journal of Contemporary Hospitality Management*, 2022. https://doi.org/10.1108/IJCHM-10-2021-1273

[2] Shankar, A. et al., “Online food delivery: A systematic synthesis of literature and a framework development,” *International Journal of Hospitality Management*, 2022. https://doi.org/10.1016/j.ijhm.2022.103240

[3] Prasetyo, Y. T. et al., “Factors affecting customer satisfaction and loyalty in online food delivery service during the COVID-19 pandemic,” *Journal of Open Innovation: Technology, Market, and Complexity*, 2021. https://doi.org/10.3390/joitmc7010076

[4] Fakfare, P., “Influence of service attributes of food delivery application on customers’ satisfaction and their behavioural responses: The IPMA approach,” *International Journal of Gastronomy and Food Science*, 2021. https://doi.org/10.1016/j.ijgfs.2021.100392

[5] Koay, K. Y., Cheah, C. W., and Chang, Y. X., “A model of online food delivery service quality, customer satisfaction and customer loyalty: A combination of PLS-SEM and NCA approaches,” *British Food Journal*, 2022. https://doi.org/10.1108/BFJ-10-2021-1169

[6] Davis, F. D., “Perceived usefulness, perceived ease of use, and user acceptance of information technology,” *MIS Quarterly*, 1989. https://doi.org/10.2307/249008

[7] Venkatesh, V. et al., “User acceptance of information technology: Toward a unified view,” *MIS Quarterly*, 2003. https://doi.org/10.2307/30036540

[8] Kruchten, P., “The 4+1 view model of architecture,” *IEEE Software*, 1995. https://doi.org/10.1109/52.469759

[9] Taibi, D., Lenarduzzi, V., and Pahl, C., “Architectural patterns for microservices: A systematic mapping study,” *CLOSER 2018*, 2018. https://doi.org/10.5220/0006798302210232

[10] Yin, R. K., “Case Study Research and Applications: Design and Methods,” *SAGE, 6th ed.*, 2018. https://study.sagepub.com/yin6e

[11] Kitchenham, B., and Charters, S., “Guidelines for performing systematic literature reviews in software engineering,” *EBSE-2007-01*, 2007. https://homepages.dcc.ufmg.br/~figueiredo/disciplinas/papers/guidelines-kitchenham.pdf

[12] ISO/IEC, “ISO/IEC 25010:2023 — Product quality model,” *ISO standard*, 2023. https://www.iso.org/standard/78176.html

[13] OWASP Foundation, “OWASP API Security Top 10 — 2023,” *OWASP*, 2023. https://owasp.org/API-Security/

[14] Fielding, R., Nottingham, M., and Reschke, J., “HTTP Semantics (RFC 9110),” *IETF*, 2022. https://www.rfc-editor.org/rfc/rfc9110

[15] Jones, M., Bradley, J., and Sakimura, N., “JSON Web Token (JWT) (RFC 7519),” *IETF*, 2015. https://www.rfc-editor.org/rfc/rfc7519


Sources and traceability / Fuentes y trazabilidad:
- https://github.com/yersonct/SaborExpressDocs/blob/main/9-traceability/CIERRE-HU-2026-11-03.md
- https://github.com/yersonct/SaborExpressDocs/blob/main/docs-SaborExpress/07_Articulo_investigacion_SaborExpress_ES.md
- https://github.com/yersonct/SaborExpressBack
- https://github.com/yersonct/SaborExpressWeb
- https://github.com/yersonct/SaborExpressMovil

