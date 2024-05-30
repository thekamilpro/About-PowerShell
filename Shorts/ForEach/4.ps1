Clear-Host
#Create iteration
$users = @("Geralt", "Triss", "Yenefer")

$i = 1
foreach ($user in $users)
{
    Write-host "Doing: $i"
    Write-Host $user
    $i++
}