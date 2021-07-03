# Link to the video: https://youtu.be/j8Ubwv8ApdU

# Documentation:
# Operators: https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators?view=powershell-7.1
# About If: https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_if?view=powershell-7.1

# Basic version
# if something is true then do this

if ($true) { "This is true" }

if ($false) { "This is false" }

# if something is true then do this, otherwise do that

if ($true) { "This is true" } else { "This is false" }

if ($false) { "This is true" } else { "This is false" }

# let's do some actual example
if ( 5 -gt 3 ) { "This is more!" } else { "This is less!" }

# we can also compare against variables.
$random = Get-Random -Minimum 1 -Maximum 11; $random
if ($random -ge 5) { "$Random  is more than 5!" } else { "$Random is less than 5!" }

# running functions and assigning them directly in the statement
if ( ($random = Get-Random -Minimum 1 -Maximum 11) -ge 5) { "$Random  is more than 5!" } else { "$Random is less than 5!" }

$number = 5
if ( ($random = Get-Random -Minimum 1 -Maximum 11) -ge $number) { "$Random  is more than 5!" } else { "$Random is less than 5!" }

#Checking if variable exists
if ($nonExisting -eq $true) { "That variable exists!" } else { "It doesn't exist" }

if ($user) { "User exists" } else { "User doesn't exist" }

$user = @{}
$user['Name'] = 'Geralt'
$user['Surname'] = 'of Rivia'
$user
if ($user) { "User exists" } else { "User doesn't exist" }

#We can do more complex operations
if ($user) {
    $email = '{0}.{1}@novigrad.com' -f $user.Name, $user.Surname -replace ' ', ''
    "Found user: $($user.Name) $($user.Surname)"  
    "Email for user: {0}" -f $email.ToLower()
}

#Like operator
if ($email -like "*Rivia*") { "Email has Rivia in it!" }

#We can check if something is not true
if ( -not $user1 ) { "This user doesn't exist" }
if ( !$user1 ) { "This user doesn't exist" }

# More complex logic
if ( $user.Name -eq "Geralt" -AND $user.Surname -eq "of Rivia" ) { "User Exists" }
if ( $user.Name -eq "Geralt" -AND $user.Surname -eq "of Rivia" -AND $user1 ) { "User Exists" }

# Splitting statement accross different lines
if ( $user.Name -eq "Geralt" -OR 
    $user.Surname -eq "of Rivia" -OR 
    $user1 ) { 
    "User Exists"
}

# Testing if folder exists
$Folder = "C:\Windows"
if ( Test-Path -Path $Folder ) { "Folder: $Folder Exists!" }

#Nested IF Statements
if ($user.Name -eq "Geralt") {
    if ($user.Surname -eq "of Rivia") {
        if ( $email) {
            "User created successfully"
        }
        else {
            "User's email is not created"
        }
    }
    else {
        "Users surname is not created"
    }
}
else {
    "User's name is not set"
}

#Multiple if else statements
$Today = (Get-Date).DayOfWeek

if ($today -eq "Monday" -or $today -eq "Tuesday" -or $today -eq "Wednesday" -or $today -eq "Thursday" -or $today -eq "Friday") {
    "Today is Working day"
}
elseif ($today -eq "Saturday") {
    "Today is first day of the weekend"
}
elseif ($today -eq "Sunday") {
    "Today is the last of week. Tomorrow we begin a new week."
}
else {
    "Unknown day: $today"
}

#Switch
switch ($today) {
    { $_ -in ( "Monday", "Tuesday", "Wednesday", "Thursday", "Friday") } { "Today is working day" }
    "Saturday" { "Today is first day of the weekend" }
    "Sunday" { "Today is the last day of the week." }
    default { "Unknown day: $today" }
}
