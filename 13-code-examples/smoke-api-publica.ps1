param([string]$ApiBaseUrl = 'http://localhost:5000')
$Url = "$($ApiBaseUrl.TrimEnd('/'))/api/Products"
try {
  $Result = Invoke-WebRequest -Uri $Url -Method GET -TimeoutSec 10
  Write-Host "HTTP $($Result.StatusCode) consultando $Url"
} catch {
  Write-Error "Fallo al consultar endpoint de catálogo. Verifique puerto, CORS y servicio: $_"
  exit 1
}
