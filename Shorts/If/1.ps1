Clear-Host
$witcherIsTheBestBookSeriesEverWritten = $true

#-eq $True is implicit 
if ($witcherIsTheBestBookSeriesEverWritten)
{
    Write-Host "I win"
}

if ($witcherIsTheBestBookSeriesEverWritten -eq $false)
{
    Write-Host "You loose"
}