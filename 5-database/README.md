# Base de datos y esquema derivado

## Fuente comprobable

Los artefactos `database-schema-ef-postgresql.sql`, `DICCIONARIO-EF-POSTGRESQL.md` y `DER-EF-POSTGRESQL.mmd` se generaron desde el SQL de migraciones EF Core de Backend, para PostgreSQL. El inventario contiene 34 tablas de aplicación, 286 columnas y 53 relaciones FK. El archivo `__EFMigrationsHistory` queda fuera del diccionario de tablas de aplicación.

Estos artefactos describen el esquema que construirían las migraciones. **No prueban el esquema desplegado ni son evidencia de que las migraciones se aplicaron en staging o producción.** No se obtuvo conexión a una base aislada o desplegada durante este cierre, por lo que la conciliación y el ensayo de restore siguen pendientes.

## Regeneración

Desde el directorio de trabajo que contiene ambos repositorios, generar primero el script EF Core de Backend y luego ejecutar el generador documental:

```powershell
dotnet ef migrations script --project .\SaborExpressBack\SaborExpressBack.csproj --output .\SaborExpressBack\artifacts\ef-migrations.sql
powershell -ExecutionPolicy Bypass -File .\SaborExpressDocs\scripts\generate-ef-schema-docs.ps1 -InputPath .\SaborExpressBack\artifacts\ef-migrations.sql
```

El script de documentación escribe solo en `SaborExpressDocs/5-database`. Revisar el diff y el proveedor antes de aplicar cualquier SQL. En el ensayo de 2026-11-03, la generación EF Core finalizó con la herramienta `dotnet-ef` 8.0.18 y runtime 8.0.29; EF mostró un aviso de diferencia de versión. El SQL es un artefacto para revisión, no se ejecutó contra una base.

## Archivos

- [`database-schema-ef-postgresql.sql`](database-schema-ef-postgresql.sql): DDL generado desde migraciones.
- [`DICCIONARIO-EF-POSTGRESQL.md`](DICCIONARIO-EF-POSTGRESQL.md): tablas, columnas, tipos, nulabilidad y claves.
- [`DER-EF-POSTGRESQL.mmd`](DER-EF-POSTGRESQL.mmd): relaciones para Mermaid.
- [`database-schema.sql`](database-schema.sql): consulta de inventario `information_schema`; no es DDL y no debe ejecutarse como esquema.
- [`DICCIONARIO-DE-DATOS.md`](DICCIONARIO-DE-DATOS.md): referencia previa pendiente de conciliación con migraciones.
