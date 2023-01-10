$ErrorActionPreference

#Or change it globally - this is what is done in production code
$ErrorActionPreference = "Stop"
Write-Error "Third failure"
Write-Host "I'm here, yet again"

