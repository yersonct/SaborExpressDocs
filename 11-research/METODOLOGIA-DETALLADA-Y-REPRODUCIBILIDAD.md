# Metodología de estudio de caso y reproducibilidad del informe

**Autor:** Yerson Stiven Cuellar Rubiano; ficha 3145555; corte 14 de octubre de 2026.

## Pregunta de investigación

¿Qué capacidades técnicas y límites de calidad pueden identificarse, mediante inspección estática reproducible, en un sistema de gestión gastronómica con backend ASP.NET Core y aplicaciones Next.js y React Native, y qué protocolo empírico se requeriría para evaluar su idoneidad operativa?

## Enfoque

Estudio de caso descriptivo y análisis documental de artefactos de ingeniería, con criterios de codificación previos: (A) existente en ruta y fuente, (B) inferido de estructura, (C) recomendado según norma, (D) pendiente de prueba. Este enfoque no equivale a un ensayo clínico, un experimento controlado ni una revisión sistemática PRISMA.

## Unidad, muestra y fuentes

Unidad de análisis: proyecto SaborExpress; fuentes primarias: `SaborExpressBack`, `SaborExpressWeb`, `SaborExpressMovil` y `SaborExpressDocs`. La muestra es intencional sobre controladores Auth, Orders, Payments, Products, Branches y Deliveries, entidades de EF, configuración, archivos package.json y rutas web. Las fuentes secundarias son artículos con DOI y normas de ingeniería para contextualizar los hallazgos.

## Procedimiento de extracción

1. Registrar SHA de cada repositorio. 2. Enumerar estructura, módulos, controladores y dependencias. 3. Inspeccionar clases para construir tabla atributo–entidad. 4. Extraer rutas desde anotaciones HTTP. 5. Trazar un mapa de dependencias y casos de uso. 6. Comparar criterios con ISO 29148 y 25010. 7. Formular pruebas futuras para cada riesgo. 8. Asegurar que las conclusiones solo mencionen hechos avalados por esta evidencia.

## Riesgos de interpretación

Presencia de endpoint ≠ capacidad funcional validada; dependencia instalada ≠ integración operativa; soporte en código de DB ≠ migración exitosa; documentación generada ≠ aceptación docente. Los porcentajes de desempeño y satisfacción requieren datos de campo y no se agregan de modo especulativo. Conservar tanto resultados favorables como negativos.

## Instrumento de extracción replicable

| Campo | Registro necesario |
|---|---|
| Repositorio / SHA | URL y hash exacto de commit |
| Archivo / intervalo | Ruta comprobada y símbolo del código |
| Hallazgo | Declaración verificable sin generalizar |
| Tipo de evidencia | A / B / C / D |
| Requisito vinculado | RF o RNF |
| Riesgo | amenaza o incertidumbre concreta |
| Experimento posterior | prueba y dato observable requerido |
| Responsable | persona que revisa y aprueba |

## Criterios para resultados futuros

La investigación posterior documentará configuración de equipo, red, DB, dataset, concurrencia, tiempo de calentamiento, métricas p50/p95, error rate, número de muestras, herramientas y condiciones de ejecución. Los hallazgos de seguridad se reportarán con autorización de prueba, sin datos sensibles y con remediación. En usabilidad se publicarán procedimientos y resultados agregados con consentimiento informado.
