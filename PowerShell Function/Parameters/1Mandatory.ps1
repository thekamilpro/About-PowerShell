# Mandatory attributes are required, powershell prompts for them
# Since Mandatory is bool, we don't need to specify it's true
# Pay attention to $PSBoundParameter
function Get-Person {
    param (
        [Parameter(Mandatory)]
        [string]$Name,

        [Parameter(Mandatory = $true)]
        [int]$Age,

        [Guid]$Id
    )

    Write-Host "=================="

    $email = '{0}@company.com' -f $Name.ToLower()

    Write-Host "Hi $($Name.ToUpper()) $Age"

    If ($PSBoundParameters.ContainsKey('id')) {
        "Your ID is: $Id"
    }

    Write-Host "Your email address is: $email"

    if ($Age -gt 17) {
        Write-Host "You will be able to access any website"
    }
    else {
        Write-Host "We will turn on content blocker approriate to your age"
    }
}
$guid = New-Guid
Get-Person
Get-Person -Name Kamil -Age 32 -Id $guid
Get-Person Kamil -Id $guid




