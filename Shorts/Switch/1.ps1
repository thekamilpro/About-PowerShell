Clear-Host

$person = "Holden"

$role = switch ($person)
{
    "Burton" { "Mechanic" }
    "Nagata" { "Engineer" }
    "Holden" { "Captain" }
    "Kamal" { "Pilot" }
}

Write-Host "Person: [$person] is [$role]"

#we could as well use a hashtable for this example