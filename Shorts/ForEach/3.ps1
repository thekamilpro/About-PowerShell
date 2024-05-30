Clear-Host
#SKIP item from the loop
$users = @("Geralt", "Triss", "Yenefer")

foreach ($user in $users)
{
    if ($user -eq "Triss")
    {
        continue
    }
    Write-Host $user
}