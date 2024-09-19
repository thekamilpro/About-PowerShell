help Get-Process -Parameter Name | Out-Host

[pscustomobject]@{Name = "pwsh"} | Get-Process

[pscustomobject]@{Name = "pwsh"; Rubbish = $True} | Get-Process

help Stop-Process -Parameter InputObject | Out-Host

Get-Process -Id $pid
Get-Process -Id $pid | Get-Member

#Stop process expectes System.Diadnostic.Process, which is what Get-Process outputs. So it should work
Get-Process -Id $pid | Stop-Process