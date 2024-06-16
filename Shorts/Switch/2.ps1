Clear-Host

$person = "Nagata"

$role = switch ($person)
{
    {$_ -like "B*"} { "Mechanic" }
    {$_ -like "N*"} { "Engineer" }
    {$_ -like "H*"} { "Captain" }
    {$_ -like "K*"} { "Pilot" }
}

Write-Host "Person: [$person] is [$role]"