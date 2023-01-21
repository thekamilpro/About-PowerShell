#Catching typed exception
# try 
# {
#     $null = Invoke-RestMethod -Uri google.com -Ea stop
#     $null = Get-Item -Path "123blah123" -ErrorAction stop
# }
# catch [System.Net.Http.HttpRequestException]
# {
#     Write-Host "Http Request Execption" -ForegroundColor DarkGreen
# }
# catch 
# {
#     Write-Host "Generic error" -ForegroundColor DarkGreen
#     Throw
# }

# Throwing typed exception
Write-Host "Happy working"
Throw [System.AccessViolationException]::new("Not anymore")
(Get-Error).exception.Type