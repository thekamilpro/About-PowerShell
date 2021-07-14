# Link to the video: https://youtu.be/YQnBVn-9SN0

# Documentation:
# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_for?view=powershell-7.1

# Basic syntax:

# for (Initial Value/statement; Condition; Repeat) { Run my code }

# Initial value: Set this is up before starting the loop 
# Condition: For loops ends, when condition evaluates to false; or it keep running as lon as condition is true
# Repeat: Do this after every loop

for ($MyVariable = 0; $MyVariable -lt 10; $MyVariable = $MyVariable + 1) {
    '$MyVariable is {0}' -f $MyVariable
    Start-Sleep -Seconds 2
}

for ($MyVariable = 0; $MyVariable -lt 99; $MyVariable++) {
    '$MyVariable is {0}' -f $MyVariable
}

# We can also decrease it
for ($MyVariable = 10; $MyVariable -gt 5; $MyVariable = $MyVariable - 1) {
    '$MyVariable is {0}' -f $MyVariable
}

# or specify variable outside if
$outside = 7
for (; $outside -lt 15; $outside++) {
    '$Outside is {0}' -f $outside
}

#Looping through array
$pets = @("Cat", "Dog", "Fish", "Turtle")
$pets.Count

$pets[2]

"My pets in order:"
for ($i = 0; $i -lt $pets.Count; $i++) {
    $pets[$i]
}

# How about I'd like to add numbers
""
"My pets in order:"
""
for ($i = 0; $i -lt $pets.Count; $i++) {
    $Number = $i + 1
    "  {0}. {1}" -f $Number, $pets[$i]
}

# For also works with strings
for ($text = ''; $text.Length -lt 10; $text += '@') {
    $text
}

# Nested for
$row = 1..10
$column = 1..10

for ($i = 0; $i -lt $row.Count; $i++) {
    for ( $j = 0; $j -lt $column.Count; $j++) {

        $r = $row[$i]
        $c = $column[$j]
        $result = $r * $c

        $t = "{0} * {1} = {2}" -f $r, $c, $result
        Write-Host $t
    }
}
     
# It never ends... We need to break with CTRL - C
for ( $i = 0 ; ; $i++ ) {
    "Loop number: $I"
}

# Or we can break when certain condition is met 
for ( $i = 0 ; ; $i++ ) {
    "Loop number: $I"
    if ($i -eq 1000) {
        "Breaking out"
        break
    }
}

# A real case scenario with Azure Application Insigts

$Headers = @("First Name", "Email", "Phone Number")

$Rows = @(
    @("Kamil", "kamil@kamil.mail", "111-111-111"),
    @("John", "john@john.mail", "222-222-222"),
    @("Abigail", "abigail@abigail.mail", "333-333-333")
)

# List is like an array, however it allows to add new entries to it
$result = New-Object System.Collections.Generic.List[System.Object]

# We work with one record at the time
foreach ($row in $Rows) {

    # We need a blank PowerShell object. Notice we don't specify any properties up front
    $record = [PSCustomObject]@{}

    # Now we are going to iterate through each property in the row
    for ($i = 0; $i -lt $Headers.Count; $i++) {

        # Since we are working with PowerShell object, we can add members
        # Notice we use index for both name and value
        $record | Add-Member -MemberType NoteProperty -Name $Headers[$i] -Value $row[$i]
    }
    # We add completed object object to the list
    $result.Add($record)
}
#Display list with all records
$result