param(
    [Parameter(Mandatory = $true)]
    [string] $InputPath,

    [string] $OutputDirectory = "..\5-database",

    [string] $GeneratedDate = "2026-11-03"
)

$ErrorActionPreference = "Stop"
$sqlPath = (Resolve-Path -LiteralPath $InputPath).Path
$outputPath = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot $OutputDirectory))
New-Item -ItemType Directory -Path $outputPath -Force | Out-Null
$sql = [System.IO.File]::ReadAllText($sqlPath)

$sqlOutput = Join-Path $outputPath "database-schema-ef-postgresql.sql"
$sqlHeader = @"
-- Generated from SaborExpressBack EF Core migrations for PostgreSQL.
-- Generated date: $GeneratedDate
-- This is migration DDL, not a snapshot of a deployed database.
-- Review provider, backup, target, and migration plan before applying anywhere.

"@
$sqlText = ($sqlHeader + $sql).TrimEnd()
[System.IO.File]::WriteAllText($sqlOutput, $sqlText + [System.Environment]::NewLine, [System.Text.UTF8Encoding]::new($false))

$createTablePattern = '(?ims)^\s*CREATE TABLE(?:\s+IF NOT EXISTS)?\s+(?:"(?<quoted>[^"]+)"|(?<bare>[A-Za-z_][A-Za-z0-9_]*))\s*\((?<body>.*?)^\s*\);'
$tableMatches = [regex]::Matches($sql, $createTablePattern)
$tables = @()
$foreignKeys = @()
$typePattern = '^(?<type>character varying\(\d+\)|timestamp with time zone|time with time zone|double precision|numeric\(\d+(?:,\s*\d+)?\)|smallint|integer|bigint|boolean|text|uuid|bytea|date|time|jsonb|real)(?=\s|$)'

foreach ($match in $tableMatches) {
    $tableName = if ($match.Groups["quoted"].Success) { $match.Groups["quoted"].Value } else { $match.Groups["bare"].Value }
    $body = $match.Groups["body"].Value
    $columns = @()
    $primaryKeys = @()

    foreach ($pkMatch in [regex]::Matches($body, '(?i)PRIMARY KEY\s*\((?<columns>[^)]+)\)')) {
        foreach ($name in ($pkMatch.Groups["columns"].Value -split ',')) {
            $primaryKeys += $name.Trim().Trim('"')
        }
    }

    foreach ($line in ($body -split "`r?`n")) {
        $columnMatch = [regex]::Match($line, '^\s*(?:"(?<quoted>[^"]+)"|(?<bare>[A-Za-z_][A-Za-z0-9_]*))\s+(?<definition>.+?)\s*,?\s*$')
        if (-not $columnMatch.Success) { continue }

        $columnName = if ($columnMatch.Groups["quoted"].Success) { $columnMatch.Groups["quoted"].Value } else { $columnMatch.Groups["bare"].Value }
        $definition = $columnMatch.Groups["definition"].Value.Trim().TrimEnd(',')
        if ($columnName -in @("CONSTRAINT", "PRIMARY", "UNIQUE", "CHECK", "FOREIGN")) { continue }
        $typeMatch = [regex]::Match($definition, $typePattern, [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
        $type = if ($typeMatch.Success) { $typeMatch.Groups["type"].Value } else { ($definition -split '\s+')[0] }
        $columns += [pscustomobject]@{
            Name = $columnName
            Type = $type
            Nullable = ($definition -notmatch '(?i)\bNOT NULL\b')
            IsPrimaryKey = ($columnName -in $primaryKeys)
        }
    }

    $tables += [pscustomobject]@{ Name = $tableName; Columns = $columns }
    foreach ($fkMatch in [regex]::Matches($body, '(?i)CONSTRAINT\s+"(?<constraint>[^"]+)"\s+FOREIGN KEY\s*\((?<columns>[^)]+)\)\s+REFERENCES\s+(?:"(?<quoted>[^"]+)"|(?<bare>[A-Za-z_][A-Za-z0-9_]*))\s*\((?<target>[^)]+)\)')) {
        $foreignKeys += [pscustomobject]@{
            Table = $tableName
            Constraint = $fkMatch.Groups["constraint"].Value
            Column = $fkMatch.Groups["columns"].Value.Trim().Trim('"')
            TargetTable = if ($fkMatch.Groups["quoted"].Success) { $fkMatch.Groups["quoted"].Value } else { $fkMatch.Groups["bare"].Value }
            TargetColumn = $fkMatch.Groups["target"].Value.Trim().Trim('"')
        }
    }
}

$applicationTables = @($tables | Where-Object { $_.Name -ne "__EFMigrationsHistory" })
$dictionary = [System.Collections.Generic.List[string]]::new()
$dictionary.Add("# Diccionario de datos derivado de migraciones EF Core")
$dictionary.Add("")
$dictionary.Add("Generado: $GeneratedDate · Proveedor: PostgreSQL · Tablas de aplicación: $($applicationTables.Count) · Columnas: $(($applicationTables | ForEach-Object { $_.Columns.Count } | Measure-Object -Sum).Sum) · Relaciones FK: $($foreignKeys.Count).")
$dictionary.Add("")
$dictionary.Add("La fuente es el script idempotente generado desde el conjunto de migraciones del repositorio Backend. Describe el esquema que esas migraciones construirían; no prueba el esquema actualmente desplegado ni sustituye la conciliación con una base accesible.")
$dictionary.Add("")
$dictionary.Add("| Tabla | Columna | Tipo PostgreSQL | Acepta NULL | Clave | Referencia |")
$dictionary.Add("|---|---|---|---|---|---|")

foreach ($table in $applicationTables) {
    foreach ($column in $table.Columns) {
        $reference = ($foreignKeys | Where-Object { $_.Table -eq $table.Name -and $_.Column -eq $column.Name } | ForEach-Object { "``$($_.TargetTable).$($_.TargetColumn)``" }) -join ", "
        $keyType = if ($column.IsPrimaryKey) { "PK" } elseif ($reference) { "FK" } else { "" }
        $nullable = if ($column.Nullable) { "Sí" } else { "No" }
        $dictionary.Add("| ``$($table.Name)`` | ``$($column.Name)`` | ``$($column.Type)`` | $nullable | $keyType | $reference |")
    }
}

$dictionaryPath = Join-Path $outputPath "DICCIONARIO-EF-POSTGRESQL.md"
[System.IO.File]::WriteAllLines($dictionaryPath, $dictionary, [System.Text.UTF8Encoding]::new($false))

$diagram = [System.Collections.Generic.List[string]]::new()
$diagram.Add("erDiagram")
foreach ($table in $applicationTables) {
    $diagram.Add("    $($table.Name) {")
    foreach ($column in $table.Columns) {
        $key = if ($column.IsPrimaryKey) { " PK" } else { "" }
        $diagram.Add("        $($column.Type -replace '[^A-Za-z0-9_]', '_') $($column.Name -replace '[^A-Za-z0-9_]', '_')$key")
    }
    $diagram.Add("    }")
}
foreach ($foreignKey in $foreignKeys) {
    if ($foreignKey.Table -eq "__EFMigrationsHistory" -or $foreignKey.TargetTable -eq "__EFMigrationsHistory") { continue }
    $column = $tables | Where-Object { $_.Name -eq $foreignKey.Table } | ForEach-Object { $_.Columns | Where-Object { $_.Name -eq $foreignKey.Column } } | Select-Object -First 1
    $cardinality = if ($column -and -not $column.Nullable) { "}|--||" } else { "}o--||" }
    $label = $foreignKey.Column -replace '[^A-Za-z0-9_]', '_'
    $diagram.Add("    $($foreignKey.Table) $cardinality $($foreignKey.TargetTable) : `"$label`"")
}

$diagramPath = Join-Path $outputPath "DER-EF-POSTGRESQL.mmd"
[System.IO.File]::WriteAllLines($diagramPath, $diagram, [System.Text.UTF8Encoding]::new($false))

Write-Output "Generados: $sqlOutput, $dictionaryPath, $diagramPath"
Write-Output "Tablas de aplicación=$($applicationTables.Count); columnas=$(($applicationTables | ForEach-Object { $_.Columns.Count } | Measure-Object -Sum).Sum); FK=$($foreignKeys.Count)"
