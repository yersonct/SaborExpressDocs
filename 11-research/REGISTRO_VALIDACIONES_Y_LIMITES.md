# Registro de evidencias reportadas — NO reejecutadas para el artículo

Fuente principal: https://github.com/yersonct/SaborExpressDocs/blob/main/9-traceability/CIERRE-HU-2026-11-03.md

| Versión | Entorno | Resultado informado | Límites |
|---|---|---|---|
| Backend 17a8ce4 | Local | Security 90/90, QA 62/62, Invoice PDF 11/11 | No hay CI remoto para este SHA; no está integrado a main |
| Backend 17a8ce4 | Local HTTP | /health 200, /health/ready 503 | Migraciones pendientes |
| Backend ac2b39e | Staging, 2026-10-29 | Smoke satisfactorio | SHA anterior, no valida candidato |
| Web aa5cb8d | Local/CI según expediente | 7/7; CI quality success | No equivale a aceptación con usuarios |
| Web aa5cb8d | Playwright API sintética | 1/1 en 11 pantallas | No prueba entorno real |
| Móvil af52bba | Local/CI según expediente | 8/8; CI quality success | No prueba APK o dispositivo físico |
| OpenAPI backend 7e6950f | Inspección estática | Web 92/92, móvil 47/47 firmas | No valida payload o ejecución |
| Backend ac2b39e | k6 histórico | 1 corrida superó umbrales y 2 fallaron condición Server-Timing | No extrapolar a SHA candidato |

**No realizados:** entrevista real, piloto con usuarios, matriz completa siete roles/dos sedes, validación integral Wompi sandbox, APK producción y certificación de seguridad.
