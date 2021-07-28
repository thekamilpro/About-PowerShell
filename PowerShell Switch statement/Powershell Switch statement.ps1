# Link to the video: 

# Documentation:

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

# We can work with variable
$number = 1
switch ($number) {
    0 { "Blue" }
    1 { "Yellow"}
    2 { "Green"}
    3 { "Red"}
}

# We can also assign variables within scriptblock 
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

# We can use Default in case there's no match
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
switch ((Get-Host).Name) {
    "Visual Studio Code Host" { "You are using VS CODE" }
    "ConsoleHost" { "You are using Console!" }
    default {"Unknown host $_"}
}

# We ca even use arrays!
$employees = @("Developer", "Project Manager", "DevOps Engineer", "Developer", "Sysadmin")
switch ($employees) {
    "Developer" {"We need a Developer!"}
    "Project Manager" {"We need Project Manager"}
    "DevOps Engineer" {"We need DevOps Engineer"}
    "Sysadmin" {"We need Sysadmin"}
}
