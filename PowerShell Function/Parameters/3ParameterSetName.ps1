function Get-Person {
    [cmdletbinding(DefaultParameterSetName = "All")]
    param (
        [Parameter(Mandatory, ParameterSetName = "byName")]
        [string]$Surname,

        [Parameter(ParameterSetName = "byName")]
        [string]$Firstname,

        [Parameter(Mandatory, ParameterSetName = "byId")]
        [int]$Id,

        [Parameter(ParameterSetName = "All")]
        [switch]$All,

        [Parameter()]
        [switch]$IncludeInactive
    )

    $data = Import-PowerShellDataFile -Path "$PSScriptRoot\data.psd1"

    if (!($IncludeInactive.IsPresent)) {
        $data = $data | Where-Object {$_.Active -eq $true}
    }

    if ($PSCmdlet.ParameterSetName -eq "All") {
        return $data
    }

    if ($PSCmdlet.ParameterSetName -eq "byId") {
        return $data[$id]
    }

    if ($PSCmdlet.ParameterSetName -eq "byName") {

        if ($PSBoundParameters.ContainsKey("Firstname")) {
            return $data.Values | Where-Object { $_.Surname -eq $Surname -and $_.FirstName -eq $Firstname }
        }
        else {
            return $data.Values | Where-Object { $_.Surname -eq $Surname }
        }

        
    }
}