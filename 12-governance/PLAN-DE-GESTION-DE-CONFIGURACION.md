# Gestión de configuración y control de versiones

Autor: Yerson Stiven Cuellar Rubiano · Ficha: 3145555 · 14-10-2026.

## 1. Línea base de código

Los tres repositorios principales son fuentes independientes y deben fijarse por SHA en cada revisión: `yersonct/SaborExpressBack`, `yersonct/SaborExpressWeb` y `yersonct/SaborExpressMovil`. El repositorio `yersonct/SaborExpressDocs` conserva requisitos, investigación y evidencias. La guía formal de SRD fue `jsgh1/SRD-v1/tree/dev/docs/docs-SRD`.

## 2. Política de ramas

Trabajo en ramas de cambio derivadas de `dev`; commits describen intención; revisión de seguridad y QA antes de integrar. Mantener cambios documentales y de código vinculados por IDs de issue/PR. No realizar modificaciones de código de las aplicaciones para crear documentación.

## 3. Registro de release

| Campo | Valor / regla |
|---|---|
| Fecha | AAAA-MM-DD |
| Repo | Nombre exacto |
| SHA | `git rev-parse HEAD` |
| Versión framework | `dotnet --info` / `npm ls` |
| Migración DB | versión SQL/EF revisada |
| Resultados | evidencia y URL de ejecución, no suposición |
| Autor/revisor | firmas de personas reales |

## 4. Reversión y evidencia

Conservar el tag previo, artefactos de build y respaldo restaurable; nunca usar `git push --force` para ocultar historia de una rama compartida. Preservar documentos SENA originales aunque la versión elaborada se actualice.
