param([string]$Raiz = 'C:\Dev\SaborExpress')
$Repos = @('SaborExpressBack','SaborExpressWeb','SaborExpressMovil')
foreach ($Repo in $Repos) {
  $Ruta = Join-Path $Raiz $Repo
  if (!(Test-Path $Ruta)) { Write-Warning "No existe: $Ruta"; continue }
  Write-Host "--- $Repo ---"
  git -C $Ruta status --short
  git -C $Ruta rev-parse HEAD
}
# No actualiza ramas ni escribe archivos.
