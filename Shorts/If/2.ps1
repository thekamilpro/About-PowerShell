Clear-Host

$number = Get-Random -Maximum 15

if ($number -le 9)
{
    Write-Host "Number [$Number] is less than 10"
}
else
{
    Write-Host "Number [$Number] is 10 or more"
}