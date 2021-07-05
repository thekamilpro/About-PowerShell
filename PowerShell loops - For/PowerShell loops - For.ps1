# Link to the video:

# Documentation:
# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_for?view=powershell-7.1

# Basic syntax:

# for (Initial Value/statement; Condition; Repeat) { Run my code }

# Initial value: Set this is up before starting the loop 
# Condition: For loops ends, when condition evaluates to false; or it keep running as lon as condition is true
# Repeat: Do this after every loop

for ($MyVariable = 0; $MyVariable -lt 10; $MyVariable = $MyVariable + 1) {
    '$MyVariable is {0}' -f $MyVariable
}

for ($MyVariable = 0; $MyVariable -lt 99; $MyVariable++) {
    '$MyVariable is {0}' -f $MyVariable
}

# We can also decrease it
for ($MyVariable = 10; $MyVariable -gt 5; $MyVariable = $MyVariable - 1) {
    '$MyVariable is {0}' -f $MyVariable
}
