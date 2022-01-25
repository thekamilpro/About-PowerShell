# In this step we formalised parameters, but user must explicitly provide them
param (
    $Name,

    $Age
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