# SaborExpress · Documentación técnica, funcional y de investigación

**Versión documental 2.0 — 14 de octubre de 2026.** Este repositorio contiene documentación del backend ASP.NET Core 8, portal Next.js y aplicación Expo/React Native. Su organización integra las carpetas existentes y una colección `docs-SaborExpress/` con entregables homólogos a `docs/docs-SRD` del proyecto SRD.

**Fuentes de software:**

- [Backend](https://github.com/yersonct/SaborExpressBack/tree/main) · API ASP.NET Core 8 / Entity Framework Core / JWT / SignalR
- [Portal web](https://github.com/yersonct/SaborExpressWeb/tree/main) · Next.js 16 / React 19
- [Aplicación móvil](https://github.com/yersonct/SaborExpressMovil/tree/main) · Expo 57 / React Native 0.86
- [Referencia de entregables SRD](https://github.com/jsgh1/SRD-v1/tree/dev/docs/docs-SRD)

## Índice de entregables

| Carpeta | Material |
|---|---|
| `1-project-charter/` | Acta de proyecto; mantener PDF original institucional |
| `2-requirements/` | SRS, matriz de requisitos y aceptación |
| `3-analysis/` | Actores, casos de uso, excepciones y viabilidad |
| `4-design/` | Arquitectura actual y diagramas |
| `5-database/` | Diccionario de entidades e instrucciones para DDL real |
| `6-api/` | Catálogo parcial verificado y colección Postman inicial |
| `7-manuals/` | Instalación, técnico y usuario por rol |
| `8-testing/` | Plan de pruebas (no ejecutadas) |
| `9-traceability/` | Matriz requisito-evidencia-prueba y acciones de mejora |
| `10-deliverables/` | Informe de cierre documental y presentación para adaptar |
| `11-research/` | Artículos ES/EN, bibliografía y protocolo experimental |
| `docs-SaborExpress/` | 14 entregables principales en Word, PDF y Markdown |

## Estado responsable

Se inspeccionaron repositorios y archivos principales; no se realizaron pruebas de la API, pagos reales, UX, seguridad ofensiva ni carga. Las capturas, firmas, fechas institucionales, datos de autoría y mediciones quedan por completar con evidencia. Los documentos *no* deben describirse como pruebas aprobadas. Para detalle leer [AUDITORIA-DOCUMENTAL.md](AUDITORIA-DOCUMENTAL.md).

## Advertencia de integración

No eliminar ni sobrescribir sin revisión los cuatro PDF originales `SENA_*` ni `clean-architecture-guide.md`. En `git status` se pueden restaurar archivos eliminados con `git restore -- <rutas>`. La carpeta `docs-SaborExpress` complementa, no reemplaza, la documentación institucional preexistente.

## Sugerencia de commit

`docs: completar expediente técnico y artículos científicos de SaborExpress`

Toda actualización futura debe anotar fecha, commit de código, responsable y evidencia.
