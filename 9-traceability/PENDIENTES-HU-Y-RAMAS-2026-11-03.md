# HU pendientes y estado de ramas — 2026-11-03

## Propósito y alcance

Este documento resume qué partes del plan de 30 HU de cierre siguen pendientes, dónde ya se publicaron cambios y qué trabajo queda por repositorio. El plan fuente es una propuesta de cierre, no la lista oficial completa de los 28 hallazgos ni una certificación del 100 %. Una HU puede tener código y pruebas locales y seguir pendiente de CI remoto, revisión, staging, dispositivo, operación o aprobación.

Se identificaron cuatro repositorios de trabajo. **Dos ya tienen una rama de cierre publicada (Backend y Docs); Web y Móvil siguen en `main` y no tienen una rama de cierre creada por esta entrega.** Por eso, no hay cuatro ramas nuevas faltantes: hay cuatro frentes de repositorio, con dos ramas publicadas y dos propuestas por crear.

## Cambios publicados

| Repositorio | Rama/HEAD publicado | Cambios subidos en este trabajo | Estado de integración |
|---|---|---|---|
| [SaborExpressBack](https://github.com/yersonct/SaborExpressBack) | [`codex/hu-cierre-04-06-integracion`](https://github.com/yersonct/SaborExpressBack/tree/codex/hu-cierre-04-06-integracion) · `0f2b1f4` | HU-04: POST/DELETE de la matriz global restringidos a GERENTE en controlador y servicio, con pruebas 401/403/éxito. Ajustes de build para excluir tests/salidas generadas. Limpieza del diff neto que quitaba `.vs` y 48 imágenes existentes. | Push realizado al remoto `yersonct`. No hay PR abierto ni merge a `main`; falta revisión, CI remoto y validación de migración. |
| [SaborExpressDocs](https://github.com/yersonct/SaborExpressDocs) | [`codex/hu-cierre-documentacion`](https://github.com/yersonct/SaborExpressDocs/tree/codex/hu-cierre-documentacion) · HEAD previo a este documento: `3bb2bb0` | Informe de estado HU y resultados observados; este mapa de pendientes y ramas. Los commits de esta entrega se atribuyen a `yersonct`. | Push realizado al remoto `yersonct`. No hay PR abierto ni merge a `main`. |
| [SaborExpressWeb](https://github.com/yersonct/SaborExpressWeb) | `main` · `b4e3c93` | No se publicó código de cierre. Se verificaron localmente lint, tipos, 5 pruebas, i18n, build y 144/144 E2E con datos sintéticos. | No hay rama de cierre ni push de HU de esta entrega. Rama sugerida para trabajo futuro: `codex/hu-cierre-web`. |
| [SaborExpressMovil](https://github.com/yersonct/SaborExpressMovil) | `main` · `09e60c9` | No se publicó código de cierre. Se verificaron localmente lint, tipos, 8 pruebas e i18n. `app.json` tiene un cambio local previo y permanece fuera de los commits; no se probó exportación Android ni dispositivo. | No hay rama de cierre ni push de HU de esta entrega. Rama sugerida para trabajo futuro: `codex/hu-cierre-movil`. |

Los nombres sugeridos para Web y Móvil son propuestas; no se han creado esas ramas. Los remotos observados para los cuatro proyectos apuntan a repositorios de `yersonct`. No se hicieron commits ni pushes de esta entrega bajo `jsgh1`. No se deben aplicar cambios directamente a `main`.

## Pendientes por repositorio

El estado “parcial” significa que existe alguna implementación o prueba, pero falta al menos uno de los criterios de aceptación del plan. No implica que toda la HU carezca de código.

### Backend — continuar en `codex/hu-cierre-04-06-integracion`

| HU | Pendiente principal |
|---|---|
| 01–02 | Revocar/rotar credenciales comprometidas y decidir el saneamiento del historial con respaldo y coordinación operativa. No hacer cambios en proveedores ni reescribir historial sin el proceso seguro descrito en el plan. |
| 03, 07 | Ejecutar CI/secret-scan de forma remota en SHA candidato y prueba negativa con secreto artificial. |
| 05 | Completar matriz de acceso por recurso, rol y sede; probar usuario de sede A contra datos de sede B. |
| 06, 09 | Abrir PR, conseguir revisión, comprobar protecciones y documentar checks requeridos. El cambio está en rama, no integrado. |
| 10–13 | Probar arranque limpio y health/readiness; despliegue/reversión en staging; ensayo de migración en base aislada; backup y restore medidos. |
| 15–17 | Comparar OpenAPI con clientes; completar pruebas contractuales de errores/archivos; ejecutar matriz CORS/JWT/privacidad en staging. |
| 18–23 | Completar flujos integrados de siete roles y dos sedes para pedidos, cocina, caja, Wompi/facturas, domicilios y catálogo, incluidos casos de red/recuperación. |

### Web — rama propuesta `codex/hu-cierre-web`

| HU | Pendiente principal |
|---|---|
| 08 | Publicar/observar CI remoto en el SHA candidato y asociar resultados a la rama/PR. La suite local pasó, pero no equivale a CI. |
| 09–11 | PR y revisión, rama protegida, clon/arranque reproducible y prueba de despliegue/smoke/reversión en staging. |
| 15–16 | Probar compatibilidad real con el contrato API y respuestas/errores de carga, junto con Backend y Móvil. |
| 18–23 | Completar recorridos integrados de roles y operaciones; los E2E locales existentes usan datos sintéticos y no prueban integración de backend/staging. |
| 25 | Medir accesibilidad y rendimiento con criterios y resultados reproducibles. |
| 30 | Incluir el SHA Web definitivo en release candidato, CI, smoke y evaluación institucional. |

### Móvil — rama propuesta `codex/hu-cierre-movil`

| HU | Pendiente principal |
|---|---|
| 08 | Obtener CI remoto y build/export Android asociado al SHA candidato. Las pruebas locales pasaron, pero no se verificó la exportación. |
| 09–11 | PR/revisión, protección de rama, instalación desde clon reproducible y flujo de release/EAS, smoke y reversión en staging. |
| 15–16 | Verificar compatibilidad de API, manejo de errores y archivos con Backend/Web. |
| 18–23 | Ejecutar recorridos integrados por rol para pedidos, cocina, caja, pagos, domicilios y catálogo; incluir desconexión y sincronización. |
| 24 | Generar APK de producción e instalarla en dispositivo físico; probar BLE, impresora térmica, QR, sesión y reconexión. |
| 25 | Medir accesibilidad y rendimiento en dispositivos definidos. |
| 30 | Incluir el SHA móvil y evidencia de build/dispositivo en la evaluación final. |

El `app.json` local preexistente debe revisarse por su responsable antes de incluirlo en una rama o commit. Este documento no lo añade ni lo modifica.

### Docs — continuar en `codex/hu-cierre-documentacion`

| HU | Pendiente principal |
|---|---|
| 14 | Derivar DER/diccionario desde EF Core y migraciones y conciliarlos con un esquema desplegado verificable. |
| 26 | Completar matriz RF → HU → repositorio/SHA → PR → prueba ejecutada → evidencia/fecha; no registrar PASS sin ejecución. |
| 27 | Actualizar manuales y arquitectura contra versión vigente; calcular KPIs con fuente y método, sin cifras inventadas. |
| 28 | Registrar issues, responsables y PR revisados; mantener autoría real y SHAs de los cuatro repositorios. |
| 29 | Conseguir el anexo institucional que enumera los 28 hallazgos y registrar cada uno. El resumen disponible no permite inventariarlos individualmente. |
| 30 | Preparar el paquete de evidencias para reevaluación, con los SHAs finales de Backend/Web/Móvil/Docs. |

## Cierre transversal

Las HU 04, 06 y parte de 07/08 tienen evidencia de código o pruebas locales, pero falta completar aceptación y revisión. HU 01–03, 05, 09–30 conservan acciones pendientes descritas arriba; varias requieren acceso operativo, entorno aislado, dispositivo, anexo faltante o aprobación. No declarar las 30 cerradas ni el proyecto al 100 % hasta completar sus criterios.

Secuencia recomendada: trabajar en ramas de feature de cada repositorio, ejecutar sus checks, publicar commits atribuidos a `yersonct`, abrir PR y dejar revisión/checks antes de integrar. Mantener los cambios de Backend y Docs en sus ramas publicadas actuales; crear las ramas Web/Móvil solo cuando se vaya a implementar su contenido. Toda migración, rotación de secreto, saneamiento de historial o despliegue debe seguir las salvaguardas del plan fuente.
