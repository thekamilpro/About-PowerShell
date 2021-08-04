# Link to the video: https://youtu.be/EqJ0lBO1rM4

# Documentation: https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_switch?view=powershell-7.1

# Basic version

<#
switch ( test-value ) {
    condition {do-stuff}
    another condition {do-stuff}
}
#>

# This will print out Green
switch (2) {
    0 { "Blue" }
    1 { "Yellow"}
    2 { "Green"}
    3 { "Red"}
}

# Work with variable
$number = 1
switch ($number) {
    0 { "Blue" }
    1 { "Yellow"}
    2 { "Green"}
    3 { "Red"}
}

# Assign variables within scriptblock 
$number = 3
switch ($number) {
    0 { $result = "Blue" }
    1 { $result = "Yellow"}
    2 { $result = "Green"}
    3 { $result = "Red"}
}
Write-Host "The result is: $result" -ForegroundColor $result

# We can also assign statement to variable
$number = 0
$result = switch ($number) {
    0 { "Blue" }
    1 { "Yellow"}
    2 { "Green"}
    3 { "Red"}
}
Write-Host "The result is: $result" -ForegroundColor $result

#  Use default in case there's no match
$number = 8
$result = switch ($number) {
    0 { "Blue" }
    1 { "Yellow"}
    2 { "Green"}
    3 { "Red"}
    default {  
        Write-Warning "Unknown value, defaulting to White"
        "White" }
}
Write-Host "The result is: $result" -ForegroundColor $result

# Strings can also be matched
# This also shows working on expression
switch ( (Get-Host).Name ) {
    "Visual Studio Code Host" { "You are using VS CODE" }
    "ConsoleHost" { "You are using Console!" }
    default {"Unknown host $_"}
}

# Arrays!
$employees = @("Developer", "Project Manager", "DevOps Engineer", "Developer", "Sysadmin")
switch ($employees) {
    "Developer" {"We need a Developer!"}
    "Project Manager" {"We need Project Manager"}
    "DevOps Engineer" {"We need DevOps Engineer"}
    "Sysadmin" {"We need Sysadmin"}
}

# Using script block, when comparing value
$age = 25
switch ($age) {
    {$_ -ge 18} {
        "It's an adult"
    }

    {$_ -lt 18} {
        "It's not an adult"
    }
}

# PowerShell will match multiple times
switch ("something") {
    "something" {"This is lower case"}
    "SOMETHING" {"This is upper case"}
    "SomeTHinG" {"This is mixed"}
}

# Stop execution with break
switch ("something") {
    "something" {"This is lower case"}
    "SOMETHING" {"This is upper case" 
                    break}
    "SomeTHinG" {"This is mixed"}
}

# Make test case sensitive
switch -CaseSensitive ("something") {
    "something" {"This is lower case"}
    "SOMETHING" {"This is upper case"; break;}
    "SomeTHinG" {"This is mixed"}
}

# Enable wildcard
switch -Wildcard ("Kamil") {
    "*Anna*" {"There's notification for Anna"}
    "*John*" {"There's notification for John"}
    "*Kamil*" {"There's notification for Kamil"}
    default {"Unknown"}
}

# Enable Regex
switch -Regex ("Kamil") {
    "^Anna" {"There's notification for Anna"}
    "^John" {"There's notification for John"}
    "^Kamil" {"There's notification for Kamil"}
    default {"Unknown"}
}