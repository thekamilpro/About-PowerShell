# Link to the video:

# Documentation

# What is an array and why do I need it?
<#
Array is data structure that allows to collect multiple items under one collection
so that these items can be accessed individually, iterated over or even changed.

In other words, arrays allow us to stash bunch of values under one variable,
and work with it.
#>

# How to create an empty array
$stuff = @()
$stuff
"I've got lot's of stuff: $($stuff.Count)"

# Create an array with some stuff
$stuff = @("Fork", "Knife", "Salt")
$stuff
"Now really, I've got lot's of stuff: $($stuff.Count)"

# Comma separating also works for creating an array
$stuff = "Table", "Cup", "Coffe", "Milk"
$stuff

# Mixing different types in array
$mix = @("Hi", 74, (Get-Date), "Bye")
$mix

# Accessing items in an array; Arrays are 0 based indexed
$stuff[0]
$stuff[2]
$stuff[-1]
$stuff[2,1,2,0]
$stuff[0..2]
$stuff[2..0]

# Accessing items outside of an array is silent
$stuff[20]

[bool]$stuff[20]

# However null will throw an error 
$IDidntCreateThis[3]

# Looping
$domains = @('bbc.com', 'github.com', 'youtube.com', 'blah.blah')
$ProgressPreference = 'SilentlyContinue'
foreach ($domain in $domains) {
    $Result = Test-NetConnection -ComputerName $domain -InformationLevel Quiet
    "$domain is pinging: $Result"
}

$domains | ForEach-Object {
    $Result = Test-NetConnection -ComputerName $_ -InformationLevel Quiet
    "$_ is pinging: $Result"
}

$domains.ForEach{
    $Result = Test-NetConnection -ComputerName $_ -InformationLevel Quiet
    "$_ is pinging: $Result"}


for ($i = 0; $i -lt $domains.Count; $i++) {
    $Result = Test-NetConnection -ComputerName $domains[$i] -InformationLevel Quiet
    "$($domains[$i]) is pinging: $Result"
}




# Updating items in array
# Arraylist/List
