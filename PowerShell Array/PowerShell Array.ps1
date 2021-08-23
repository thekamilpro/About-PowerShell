# Link to the video: https://youtu.be/rvGd8kxXlVc

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

###############################
# Accessing items in an array #
###############################

#Arrays are 0 based indexed
$stuff[0]
$stuff[2]
$stuff[-1]
$stuff[2,1,2,0]
$stuff[0..2]
$stuff[2..0]

# Accessing items outside of an array is silent
$stuff[20]
[bool]$stuff[20]

# Mixing different types in array
$mix = @("Hi", 74, (Get-Date), "Bye")
$mix

# More often, we can store projects
$people = @(
    [pscustomobject]@{Name = "John"; Email = "john@john.com"}
    [pscustomobject]@{Name = "Tony"; Email = "tony@tony.com"}
    [pscustomobject]@{Name = "Fiber"; Email = "fiber@optics.com"}
)
$people
$people[-1]
$people.Email
$people | Where-Object {$_.Name -eq "John"}
$people.Where({$_.Name -eq "John"}).Email

# Null will throw an error 
$IDidntCreateThis[3]

###########
# Looping #
###########

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

###################
# Updating values #
###################

$Week = @("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")
$Week[2] #Now it is Wednesday
$Week[2] = "Boo"
$Week[2]
$Week

# Update out of index throws error
$Week[8] = "Hi"

#############
# Operators #
#############

# Join
$Week
$Week -join "|"
$Week -join $null

# In
"Tuesday" -in $Week

# Match
$Week -match "es"

###################
# Adding to array #
###################

# Arrays have by definition fixed size in memory, in other words 
# you shouldn't be able to add more items to it. 
# PowerShell however allows you to do that, hiding all complexity
# by creating a new array, copying all existing item, adding new one
# and finally removing old array. 
# If you plan to add items to your array, look at ArrayList and List below

# Adding elements to array
$Week
$Week.Add("January") #this throws an error
$Week += "January"
$Week

# Adding arrays together
$ArrayA = 1..10
$ArrayB = 11..20
$ArrayA + $ArrayB

#############
# ArrayList #
#############

#Adding items to ArrayList
$alist = [System.Collections.ArrayList]::new() #This is .Net framework
$alist.Add("January")
[void]$alist.Add("February") #Void stops prevents writing to console
$alist

# Removing from ArrayList
$alist.Remove($alist[1])
$alist
