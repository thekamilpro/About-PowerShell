# In this case user can either pass parameters, or will be prompted as they are mandatory
# type is specified, therefore $Age only accepts integers
param (
    [Parameter(Mandatory)]
    [string]$Name,

    [Parameter(Mandatory)]
    [int]$Age
)

Write-Host "=================="

$email = '{0}@company.com' -f $Name.ToLower()

Write-Host "Hi $($Name.ToUpper())"
Write-Host "your email address is: $email"

if ($Age -gt 17) {
    Write-Host "You will be able to access any website"
} else {
    Write-Host "We will turn on content blocker approriate to your age"
}