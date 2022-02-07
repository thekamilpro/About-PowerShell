function Get-Person {
    [cmdletbinding(DefaultParameterSetName = "All")]
    param (
        [Parameter(Mandatory, ParameterSetName = "byName", Position = 1)]
        [string]$Surname,

        [Parameter(ParameterSetName = "byName", Position = 2)]
        [string]$Firstname,

        [Parameter(Mandatory, ParameterSetName = "byId", Position = 1)]
        [int]$Id,

        [Parameter(ParameterSetName = "All")]
        [switch]$All,

        [switch]$IncludeInactive,

        [string]$Region
    )

    $items = [System.Collections.Generic.List[pscustomobject]]::new()
    $data = Import-PowerShellDataFile -Path "$PSScriptRoot\data.psd1"
    $users = $data.users

    if (!($IncludeInactive.IsPresent)) {
        $users = $users | Where-Object {$_.Active -eq $true}
    }

    if ($PSBoundParameters.ContainsKey('Region')) {
        $users = $users | Where-Object {$_.Region -eq $Region}
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