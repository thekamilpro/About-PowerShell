<#
By default PowerShell calls parameters in order they are created
#>
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

# Both examples in this context work the same
$guid = New-Guid
Get-Person -Name Kamil -Age 32 -Id $guid
Get-Person Kamil 32 $guid
help Get-Person

function Get-Person {
    param (
        [Parameter(Mandatory, Position = 2)]
        [string]$Name,

        [Parameter(Mandatory = $true, Position = 1)]
        [int]$Age,

        [Parameter(Position = 0)]
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

# Named parameters will work as epxected
Get-Person -Name Kamil -Age 32 -Id $guid

# But positioned parameters fail
Get-Person Kamil 32 $guid