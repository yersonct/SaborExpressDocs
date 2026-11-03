param(
    [string] $SourcePath = "..\7-manuals\SaborExpress_Manual_de_Usuario.md",
    [string] $PreviewHtmlPath
)

$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest
Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem

$repoRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot ".."))
$source = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot $SourcePath))
$markdown = [System.IO.File]::ReadAllText($source, [System.Text.Encoding]::UTF8)
$utf8 = [System.Text.UTF8Encoding]::new($false)

function Convert-InlineHtml([string] $value) {
    $encoded = [System.Net.WebUtility]::HtmlEncode($value)
    $encoded = [regex]::Replace($encoded, '\[([^\]]+)\]\((https?://[^)]+)\)', '<a href="$2">$1</a>')
    $encoded = [regex]::Replace($encoded, '\*\*(.+?)\*\*', '<strong>$1</strong>')
    $encoded = [regex]::Replace($encoded, '`([^`]+)`', '<code>$1</code>')
    return $encoded
}

function Get-TableCells([string] $line) {
    $trimmed = $line.Trim().Trim('|')
    return ,@($trimmed.Split('|') | ForEach-Object { $_.Trim() })
}

function Get-MarkdownBlocks([string] $text) {
    $lines = $text -split "`r?`n"
    $blocks = [System.Collections.Generic.List[object]]::new()
    $index = 0
    while ($index -lt $lines.Count) {
        $line = $lines[$index].Trim()
        if (-not $line) { $index++; continue }
        if ($line -match '^\s*([-*_])\1\1+\s*$') { $index++; continue }
        if ($line -match '^(#{1,4})\s+(.+)$') {
            $blocks.Add([pscustomobject]@{ Type = 'heading'; Level = $Matches[1].Length; Text = $Matches[2] })
            $index++; continue
        }
        if ($line.StartsWith('|')) {
            $rows = [System.Collections.Generic.List[object]]::new()
            while ($index -lt $lines.Count -and $lines[$index].Trim().StartsWith('|')) {
                $cells = Get-TableCells $lines[$index]
                if ($lines[$index] -notmatch '^\|?\s*:?-{3,}') {
                    $rows.Add([pscustomobject]@{ Cells = $cells; Header = ($rows.Count -eq 0) })
                }
                $index++
            }
            if ($rows.Count) { $blocks.Add([pscustomobject]@{ Type = 'table'; Rows = $rows.ToArray() }) }
            continue
        }
        if ($line -match '^[-*+]\s+(.+)$') {
            $blocks.Add([pscustomobject]@{ Type = 'bullet'; Text = $Matches[1] })
            $index++; continue
        }
        if ($line -match '^(\d+)\.\s+(.+)$') {
            $blocks.Add([pscustomobject]@{ Type = 'number'; Number = $Matches[1]; Text = $Matches[2] })
            $index++; continue
        }
        if ($line -match '^>\s?(.*)$') {
            $blocks.Add([pscustomobject]@{ Type = 'quote'; Text = $Matches[1] })
            $index++; continue
        }

        $paragraph = [System.Collections.Generic.List[string]]::new()
        while ($index -lt $lines.Count) {
            $candidate = $lines[$index].Trim()
            if (-not $candidate -or $candidate.StartsWith('|') -or
                $candidate -match '^(#{1,4})\s+|^[-*+]\s+|^\d+\.\s+|^>\s?|^\s*([-*_])\1\1+\s*$') { break }
            $paragraph.Add($candidate)
            $index++
        }
        if ($paragraph.Count) {
            $blocks.Add([pscustomobject]@{ Type = 'paragraph'; Text = ($paragraph -join ' ') })
        } else { $index++ }
    }
    return ,$blocks.ToArray()
}

function Convert-InlineWord([string] $value, [bool] $forceBold = $false) {
    $builder = [System.Text.StringBuilder]::new()
    $pattern = '\*\*(.+?)\*\*|`([^`]+)`|\[([^\]]+)\]\(([^)]+)\)'
    $cursor = 0
    foreach ($match in [regex]::Matches($value, $pattern)) {
        if ($match.Index -gt $cursor) {
            $plain = [System.Security.SecurityElement]::Escape($value.Substring($cursor, $match.Index - $cursor))
            [void]$builder.Append((New-WordRun $plain $forceBold $false))
        }
        if ($match.Groups[1].Success) {
            $runText = [System.Security.SecurityElement]::Escape($match.Groups[1].Value)
            [void]$builder.Append((New-WordRun $runText $true $false))
        } elseif ($match.Groups[2].Success) {
            $runText = [System.Security.SecurityElement]::Escape($match.Groups[2].Value)
            [void]$builder.Append((New-WordRun $runText $forceBold $true))
        } else {
            $runText = [System.Security.SecurityElement]::Escape("$($match.Groups[3].Value) ($($match.Groups[4].Value))")
            [void]$builder.Append((New-WordRun $runText $forceBold $false))
        }
        $cursor = $match.Index + $match.Length
    }
    if ($cursor -lt $value.Length) {
        $plain = [System.Security.SecurityElement]::Escape($value.Substring($cursor))
        [void]$builder.Append((New-WordRun $plain $forceBold $false))
    }
    return $builder.ToString()
}

function New-WordRun([string] $escapedText, [bool] $bold, [bool] $code) {
    $properties = [System.Text.StringBuilder]::new()
    if ($bold) { [void]$properties.Append('<w:b/>') }
    if ($code) { [void]$properties.Append('<w:rFonts w:ascii="Consolas" w:hAnsi="Consolas"/><w:color w:val="40536D"/>') }
    $runProperties = if ($properties.Length) { "<w:rPr>$($properties)</w:rPr>" } else { '' }
    return "<w:r>$runProperties<w:t xml:space=`"preserve`">$escapedText</w:t></w:r>"
}

function New-WordParagraph([string] $text, [string] $style = 'Normal', [bool] $bold = $false) {
    $indent = if ($style -eq 'Bullet') { '<w:ind w:left="420" w:hanging="220"/>' } else { '' }
    $paragraphStyle = if ($style -in @('Bullet','Number')) { 'Normal' } else { $style }
    $runs = Convert-InlineWord $text $bold
    return "<w:p><w:pPr><w:pStyle w:val=`"$paragraphStyle`"/>$indent<w:spacing w:after=`"120`"/></w:pPr>$runs</w:p>"
}

function New-WordTable($rows) {
    $columnCount = ($rows | ForEach-Object { $_.Cells.Count } | Measure-Object -Maximum).Maximum
    if (-not $columnCount) { return '' }
    $cellWidth = [int][math]::Floor(9360 / $columnCount)
    $builder = [System.Text.StringBuilder]::new()
    [void]$builder.Append('<w:tbl><w:tblPr><w:tblW w:w="9360" w:type="dxa"/><w:tblLayout w:type="autofit"/><w:tblBorders><w:top w:val="single" w:sz="4" w:color="B8C7D9"/><w:left w:val="single" w:sz="4" w:color="B8C7D9"/><w:bottom w:val="single" w:sz="4" w:color="B8C7D9"/><w:right w:val="single" w:sz="4" w:color="B8C7D9"/><w:insideH w:val="single" w:sz="4" w:color="D6DEE8"/><w:insideV w:val="single" w:sz="4" w:color="D6DEE8"/></w:tblBorders></w:tblPr>')
    for ($rowIndex = 0; $rowIndex -lt $rows.Count; $rowIndex++) {
        [void]$builder.Append('<w:tr>')
        for ($columnIndex = 0; $columnIndex -lt $columnCount; $columnIndex++) {
            $cell = if ($columnIndex -lt $rows[$rowIndex].Cells.Count) { $rows[$rowIndex].Cells[$columnIndex] } else { '' }
            $headerProperties = if ($rows[$rowIndex].Header) { '<w:shd w:fill="EAF1F8"/><w:vAlign w:val="center"/>' } else { '<w:vAlign w:val="center"/>' }
            $runs = Convert-InlineWord $cell ([bool]$rows[$rowIndex].Header)
            [void]$builder.Append("<w:tc><w:tcPr><w:tcW w:w=`"$cellWidth`" w:type=`"dxa`"/>$headerProperties</w:tcPr><w:p><w:pPr><w:spacing w:after=`"40`"/></w:pPr>$runs</w:p></w:tc>")
        }
        [void]$builder.Append('</w:tr>')
    }
    [void]$builder.Append('</w:tbl><w:p/>')
    return $builder.ToString()
}

function New-RenderedHtml($blocks) {
    $builder = [System.Text.StringBuilder]::new()
    [void]$builder.Append(@'
<!doctype html><html lang="es"><head><meta charset="utf-8"><title>SaborExpress · Manual de usuario</title><style>
@page{size:A4;margin:17mm 16mm}body{font:10.5pt/1.48 Arial,sans-serif;color:#192a3b;max-width:100%;}h1{font-size:23pt;color:#123458;border-bottom:2px solid #e2a541;padding-bottom:8px;margin:0 0 15px}h2{font-size:15pt;color:#174b73;margin:20px 0 8px;page-break-after:avoid}h3{font-size:12pt;color:#174b73;page-break-after:avoid}p{margin:6px 0 9px}ul,ol{padding-left:22px;margin:4px 0 12px}li{margin:3px 0}table{border-collapse:collapse;width:100%;font-size:9pt;margin:10px 0 15px;page-break-inside:auto}thead{display:table-header-group}tr{page-break-inside:avoid;page-break-after:auto}th,td{border:1px solid #c8d4e0;padding:6px;vertical-align:top}th{background:#eaf1f8;text-align:left;color:#153a5d}blockquote{border-left:3px solid #e2a541;margin:8px 0;padding:3px 12px;color:#516579}code{font:9pt Consolas,monospace;color:#40536d}a{color:#175a88;text-decoration:none}.meta{color:#40536d;font-size:9.5pt}.callout{background:#f4f7fa;padding:9px;border-radius:4px}
</style></head><body>
'@)
    foreach ($block in $blocks) {
        switch ($block.Type) {
            'heading' {
                $level = [math]::Min([int]$block.Level, 3)
                $tag = "h$level"
                [void]$builder.Append("<$tag>$(Convert-InlineHtml $block.Text)</$tag>")
            }
            'paragraph' { [void]$builder.Append("<p>$(Convert-InlineHtml $block.Text)</p>") }
            'bullet' { [void]$builder.Append("<ul><li>$(Convert-InlineHtml $block.Text)</li></ul>") }
            'number' { [void]$builder.Append("<ol start=`"$($block.Number)`"><li>$(Convert-InlineHtml $block.Text)</li></ol>") }
            'quote' { [void]$builder.Append("<blockquote>$(Convert-InlineHtml $block.Text)</blockquote>") }
            'table' {
                [void]$builder.Append('<table>')
                foreach ($row in $block.Rows) {
                    $tag = if ($row.Header) { 'th' } else { 'td' }
                    $rowHtml = ($row.Cells | ForEach-Object { "<$tag>$(Convert-InlineHtml $_)</$tag>" }) -join ''
                    [void]$builder.Append("<tr>$rowHtml</tr>")
                }
                [void]$builder.Append('</table>')
            }
        }
    }
    [void]$builder.Append('</body></html>')
    return $builder.ToString()
}

function Write-WordDocument([string] $path, $blocks, [string] $title) {
    $body = [System.Text.StringBuilder]::new()
    foreach ($block in $blocks) {
        switch ($block.Type) {
            'heading' {
                $style = switch ([math]::Min([int]$block.Level, 3)) { 1 { 'Title' } 2 { 'Heading1' } 3 { 'Heading2' } default { 'Heading3' } }
                [void]$body.Append((New-WordParagraph $block.Text $style))
            }
            'paragraph' { [void]$body.Append((New-WordParagraph $block.Text)) }
            'bullet' { [void]$body.Append((New-WordParagraph "• $($block.Text)" 'Bullet')) }
            'number' { [void]$body.Append((New-WordParagraph "$($block.Number). $($block.Text)" 'Number')) }
            'quote' { [void]$body.Append((New-WordParagraph $block.Text 'Quote')) }
            'table' { [void]$body.Append((New-WordTable $block.Rows)) }
        }
    }
    [void]$body.Append('<w:sectPr><w:pgSz w:w="11906" w:h="16838"/><w:pgMar w:top="850" w:right="900" w:bottom="850" w:left="900" w:header="420" w:footer="420" w:gutter="0"/></w:sectPr>')
    $document = @"
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:document xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"><w:body>$body</w:body></w:document>
"@
    $styles = @'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:styles xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"><w:docDefaults><w:rPrDefault><w:rPr><w:rFonts w:ascii="Aptos" w:hAnsi="Aptos"/><w:sz w:val="21"/></w:rPr></w:rPrDefault><w:pPrDefault><w:pPr><w:spacing w:after="100" w:line="276" w:lineRule="auto"/></w:pPr></w:pPrDefault></w:docDefaults><w:style w:type="paragraph" w:default="1" w:styleId="Normal"><w:name w:val="Normal"/></w:style><w:style w:type="paragraph" w:styleId="Title"><w:name w:val="Title"/><w:rPr><w:b/><w:color w:val="123458"/><w:sz w:val="42"/></w:rPr><w:pPr><w:spacing w:after="280"/></w:pPr></w:style><w:style w:type="paragraph" w:styleId="Heading1"><w:name w:val="heading 1"/><w:basedOn w:val="Normal"/><w:next w:val="Normal"/><w:qFormat/><w:rPr><w:b/><w:color w:val="174B73"/><w:sz w:val="30"/></w:rPr><w:pPr><w:keepNext/><w:spacing w:before="260" w:after="100"/></w:pPr></w:style><w:style w:type="paragraph" w:styleId="Heading2"><w:name w:val="heading 2"/><w:basedOn w:val="Normal"/><w:next w:val="Normal"/><w:qFormat/><w:rPr><w:b/><w:color w:val="174B73"/><w:sz w:val="25"/></w:rPr><w:pPr><w:keepNext/><w:spacing w:before="180" w:after="80"/></w:pPr></w:style><w:style w:type="paragraph" w:styleId="Heading3"><w:name w:val="heading 3"/><w:basedOn w:val="Normal"/><w:rPr><w:b/><w:color w:val="174B73"/><w:sz w:val="23"/></w:rPr><w:pPr><w:keepNext/></w:pPr></w:style><w:style w:type="paragraph" w:styleId="Quote"><w:name w:val="Quote"/><w:basedOn w:val="Normal"/><w:rPr><w:i/><w:color w:val="516579"/></w:rPr><w:pPr><w:ind w:left="240"/><w:spacing w:after="160"/></w:pPr></w:style><w:style w:type="table" w:styleId="TableGrid"><w:name w:val="Table Grid"/></w:style></w:styles>
'@
    $contentTypes = @'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types"><Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/><Default Extension="xml" ContentType="application/xml"/><Override PartName="/word/document.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml"/><Override PartName="/word/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.styles+xml"/><Override PartName="/docProps/core.xml" ContentType="application/vnd.openxmlformats-package.core-properties+xml"/></Types>
'@
    $packageRels = @'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="word/document.xml"/><Relationship Id="rId2" Type="http://schemas.openxmlformats.org/package/2006/relationships/metadata/core-properties" Target="docProps/core.xml"/></Relationships>
'@
    $documentRels = @'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Target="styles.xml"/></Relationships>
'@
    $escapedTitle = [System.Security.SecurityElement]::Escape($title)
    $core = @"
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<cp:coreProperties xmlns:cp="http://schemas.openxmlformats.org/package/2006/metadata/core-properties" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><dc:title>$escapedTitle</dc:title><dc:creator>yersonct</dc:creator><cp:lastModifiedBy>yersonct</cp:lastModifiedBy><dcterms:created xsi:type="dcterms:W3CDTF">2026-11-03T00:00:00Z</dcterms:created></cp:coreProperties>
"@

    if (Test-Path -LiteralPath $path) { Remove-Item -LiteralPath $path -Force }
    $file = [System.IO.File]::Open($path, [System.IO.FileMode]::CreateNew)
    try {
        $archive = [System.IO.Compression.ZipArchive]::new($file, [System.IO.Compression.ZipArchiveMode]::Create, $false)
        try {
            $entries = @{
                '[Content_Types].xml' = $contentTypes
                '_rels/.rels' = $packageRels
                'word/document.xml' = $document
                'word/styles.xml' = $styles
                'word/_rels/document.xml.rels' = $documentRels
                'docProps/core.xml' = $core
            }
            foreach ($entryName in $entries.Keys) {
                $entry = $archive.CreateEntry($entryName)
                $stream = $entry.Open()
                try {
                    $writer = [System.IO.StreamWriter]::new($stream, $utf8)
                    try { $writer.Write($entries[$entryName]) } finally { $writer.Dispose() }
                } finally { $stream.Dispose() }
            }
        } finally { $archive.Dispose() }
    } finally { $file.Dispose() }
}

function Assert-Docx([string] $path) {
    $archive = [System.IO.Compression.ZipFile]::OpenRead($path)
    try {
        $entry = $archive.GetEntry('word/document.xml')
        if (-not $entry) { throw "DOCX sin word/document.xml: $path" }
        $reader = [System.IO.StreamReader]::new($entry.Open(), [System.Text.Encoding]::UTF8)
        try { [xml]$null = $reader.ReadToEnd() } finally { $reader.Dispose() }
    } finally { $archive.Dispose() }
}

$blocks = Get-MarkdownBlocks $markdown
$html = New-RenderedHtml $blocks
$tempRoot = Join-Path ([System.IO.Path]::GetTempPath()) ([guid]::NewGuid().ToString('N'))
$null = New-Item -ItemType Directory -Path $tempRoot
$edge = @(
    'C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe',
    'C:\Program Files\Microsoft\Edge\Application\msedge.exe'
) | Where-Object { Test-Path -LiteralPath $_ } | Select-Object -First 1
if (-not $edge) { throw 'No se encontró Microsoft Edge para exportar el PDF.' }

$outputs = @(
    @{ Docx = '7-manuals\SaborExpress_Manual_de_Usuario.docx'; Pdf = '7-manuals\SaborExpress_Manual_de_Usuario.pdf' },
    @{ Docx = '7-manuals\user-manual.docx'; Pdf = 'docs-SaborExpress\06_Manual_de_usuario_final_SaborExpress.pdf' },
    @{ Docx = 'docs-SaborExpress\06_Manual_de_usuario_final_SaborExpress.docx'; Pdf = $null }
)
$staged = [System.Collections.Generic.List[object]]::new()
try {
    $htmlPath = Join-Path $tempRoot 'manual.html'
    [System.IO.File]::WriteAllText($htmlPath, $html, $utf8)
    if ($PreviewHtmlPath) {
        $previewPath = [System.IO.Path]::GetFullPath($PreviewHtmlPath)
        [System.IO.File]::WriteAllText($previewPath, $html, $utf8)
    }
    $htmlUri = ([System.Uri]$htmlPath).AbsoluteUri
    $profile = Join-Path $tempRoot 'edge-profile'

    foreach ($output in $outputs) {
        $docxTarget = Join-Path $repoRoot $output.Docx
        $docxStage = Join-Path $tempRoot ([System.IO.Path]::GetFileName($docxTarget) + '.staging.docx')
        Write-WordDocument $docxStage $blocks 'Manual de usuario final por rol · SaborExpress'
        Assert-Docx $docxStage
        $staged.Add([pscustomobject]@{ Stage = $docxStage; Target = $docxTarget })

        if ($output.Pdf) {
            $pdfTarget = Join-Path $repoRoot $output.Pdf
            $pdfStage = Join-Path $tempRoot ([System.IO.Path]::GetFileName($pdfTarget) + '.staging.pdf')
            $arguments = @('--headless=new','--disable-gpu','--no-sandbox','--no-first-run','--no-pdf-header-footer',"--user-data-dir=$profile","--print-to-pdf=$pdfStage",$htmlUri) | ForEach-Object { '"' + $_.Replace('"','\"') + '"' }
            $process = Start-Process -FilePath $edge -ArgumentList $arguments -WindowStyle Hidden -PassThru -Wait
            if (-not (Test-Path -LiteralPath $pdfStage)) { throw "Edge no produjo el PDF (código $($process.ExitCode)): $pdfTarget" }
            $pdfBytes = [System.IO.File]::ReadAllBytes($pdfStage)
            $signature = [System.Text.Encoding]::ASCII.GetString($pdfBytes, 0, [math]::Min(4, $pdfBytes.Length))
            $tailLength = [math]::Min(2048, $pdfBytes.Length)
            $pdfTail = [System.Text.Encoding]::ASCII.GetString($pdfBytes, $pdfBytes.Length - $tailLength, $tailLength)
            if ($signature -ne '%PDF' -or $pdfBytes.Length -lt 5000 -or $pdfTail -notmatch '%%EOF') { throw "Salida PDF inválida: $pdfTarget" }
            $staged.Add([pscustomobject]@{ Stage = $pdfStage; Target = $pdfTarget })
        }
    }

    foreach ($item in $staged) {
        Move-Item -LiteralPath $item.Stage -Destination $item.Target -Force
        "GENERATED=$($item.Target)"
    }
} finally {
    if (Test-Path -LiteralPath $tempRoot) { Remove-Item -LiteralPath $tempRoot -Recurse -Force }
}
