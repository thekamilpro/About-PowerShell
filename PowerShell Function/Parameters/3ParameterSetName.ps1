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

    $items = [System.Collections.Generic.List[pscustomobject]]::new()
    $data = Import-PowerShellDataFile -Path "$PSScriptRoot\data.psd1"
    $users = $data.users

    if (!($IncludeInactive.IsPresent)) {
        $users = $users | Where-Object {$_.Active -eq $true}
    }

    foreach ($u in $users) {
        $items.Add([pscustomobject]$u)
    }

    if ($PSCmdlet.ParameterSetName -eq "All") {
        return $items
    }

    if ($PSCmdlet.ParameterSetName -eq "byId") {
        return $items.Where({$_.ID -eq $Id})
    }

    if ($PSCmdlet.ParameterSetName -eq "byName") {

        if ($PSBoundParameters.ContainsKey("Firstname")) {
            return $items.Where( { $_.Surname -eq $Surname -and $_.FirstName -eq $Firstname })
        }
        else {
            return $items.Where( { $_.Surname -eq $Surname })
        }
    }
}