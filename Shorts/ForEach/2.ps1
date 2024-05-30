Clear-Host
#BREAK out of the loop
$users = @("Geralt", "Triss", "Yenefer")

foreach ($user in $users)
{
    if ($user -eq "Triss")
    {
        break
    }
    Write-Host $user
}