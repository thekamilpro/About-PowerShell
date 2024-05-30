Clear-Host
#Basic foreach use
$users = @("Geralt", "Triss", "Yenefer")

foreach ($user in $users)
{
    Write-Host $user
}