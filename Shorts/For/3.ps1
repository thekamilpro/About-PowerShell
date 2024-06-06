Clear-Host
#Iterating over some data
$data = @("Holden", "Burton", "Nagata")

# $data[1] is Burton

for ($i = 0; $i -lt $data.Length; $i++)
{
    Write-Host "Character: $($data[$i])"
}