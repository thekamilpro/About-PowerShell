
#Non terminating errors
Write-Error "I just errored"
Write-Host "I'm Here!"

#We need to tell PowerShell to stop in case of error
Write-Error "Another failure" -ErrorAction Stop
Write-Host "I'm Here, again"

