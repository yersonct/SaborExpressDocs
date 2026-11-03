-- SABOREXPRESS - EXTRACCION DE METADATOS / NO ES DDL DE LA APLICACION
-- Los nombres físicos de tablas/columnas dependen de migraciones EF Core y proveedor configurado.
-- NO ejecutar sobre producción sin respaldo. Generar DDL real desde backend:
-- dotnet ef migrations script --idempotent --output esquema-generado.sql
-- Verificar provider activo: MySQL, PostgreSQL o SqlServer en DatabaseConfiguration.cs.
-- PostgreSQL: ejecutar la siguiente consulta solo si PostgreSQL es el proveedor seleccionado.
SELECT table_schema, table_name, column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_schema NOT IN ('information_schema','pg_catalog')
ORDER BY table_schema, table_name, ordinal_position;
