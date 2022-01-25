function Get-Person {
    param (
        [Parameter(Mandatory, ParameterSetName = "byName")]
        [string]$Name,

        [Parameter(Mandatory = $true, ParameterSetName = "byName")]
        [int]$Age,

        [Parameter(ParameterSetName = "byId")]
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