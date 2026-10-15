# Trazabilidad, correcciones y mejora continua

## Estados para registrar

`Identificado` → `En implementación` → `En pruebas` → `Aceptado` / `Rechazado`.

## Registro inicial

| ID | Hallazgo | Acción correctiva/preventiva | Prioridad |
|---|---|---|---|
| DOC-01 | README de docs describe Supabase como backend | Sustituir por ASP.NET Core y EF Core | Alta |
| DOC-02 | 13 archivos vacíos en documentación | Redactar y generar entregables reales | Alta |
| DOC-03 | Falta una colección Postman comprobada | Exportar Swagger y validar ejemplos | Alta |
| DOC-04 | DER/SQL definitivos no contrastados | Generar desde base real, revisar relaciones | Alta |
| DOC-05 | Sin evidencias de pruebas integradas | Ejecutar plan QA y conservar capturas | Alta |
| DOC-06 | Enlaces relativos de guía Clean Architecture apuntan a carpetas externas | Cambiar a enlaces URL absolutos | Media |
| DOC-07 | Readmes de frontend y móvil son plantillas de inicio | Completar instalación y funcionalidad real | Media |
| DOC-08 | Falta cierre académico y artículo de investigación con resultados | Recopilar resultados reales y aprobación | Media |

## Registro por release

Para cada versión registrar fecha, SHA de los tres repositorios, cambios visibles, migraciones ejecutadas, pruebas, problemas conocidos, medidas correctivas y firma/aprobación del responsable. Una actividad pendiente **no equivale a completada**.
