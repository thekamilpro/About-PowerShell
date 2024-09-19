$app = Get-Command -Name pwsh
$app.Path
$app.Path | Get-Item

Get-Process -Name pwsh

#This doesn't work - why?
"pwsh" | Get-Process

#This works
[pscustomobject]@{Name = "pwsh"} | Get-Process

