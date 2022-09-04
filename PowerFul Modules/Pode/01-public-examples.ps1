Import-Module -Name Pode, Pode.Web

Start-PodeServer {
    Add-PodeEndpoint -Address localhost -Port 8080 -Protocol Http

    New-PodeLoggingMethod -Terminal | Enable-PodeErrorLogging -Levels @("Error", "Warning")
    New-PodeLoggingMethod -Terminal | Enable-PodeRequestLogging

    Use-PodeWebTemplates -Title 'Example' -Theme Dark

    $navDiv = New-PodeWebNavDivider
    $navPode = New-PodeWebNavLink -Name 'Pode' -Url 'https://badgerati.github.io/Pode/' -Icon 'help-circle' -NewTab
    $navPodeWeb = New-PodeWebNavLink -Name 'PodeWeb' -Url 'https://badgerati.github.io/Pode.Web/' -Icon 'help-circle' -NewTab
    $navYT = New-PodeWebNavLink -Name 'YouTube' -Url 'https://www.youtube.com/c/KamilPro' -Icon 'youtube' -NewTab
    $navGH = New-PodeWebNavLink -name 'GitHub' -Url 'https://github.com/kprocyszyn/About-PowerShell' -Icon 'github' -NewTab

    Set-PodeWebNavDefault -Items $navPode, $navDiv, $navPodeWeb, $navDiv, $navYT, $navDiv, $navGH

    Add-PodeWebPage -Name 'Services' -Icon 'Settings' -ScriptBlock {
        New-PodeWebContainer -Content @(
            New-PodeWebTable -Name 'Services' -DataColumn "Name" -SimpleFilter -ScriptBlock {
                foreach ($svc in (Get-Service)) {
                    [ordered]@{
                        Name      = $svc.Name
                        Status    = "$($svc.Status)"
                        StartType = "$($svc.StartType)"
                        Actions   = @(
                            New-PodeWebButton -Name 'Stop' -Icon 'Stop-Circle' -IconOnly -ScriptBlock {
                                Stop-Service -Name ($WebEvent.Data.Value) -Force | Out-Null
                                Show-PodeWebToast -Message "$($WebEvent.Data.Value) stopped"
                                Sync-PodeWebTable -Id $ElementData.Parent.ID
                            }
                            New-PodeWebButton -Name 'Start' -Icon 'Play-Circle' -IconOnly -ScriptBlock {
                                Start-Service -Name ($WebEvent.Data.Value) #| Out-Null
                                Show-PodeWebToast -Message "$($WebEvent.Data.Value) started"
                                Sync-PodeWebTable -Id $ElementData.Parent.ID
                            }
                        )
                    }
                }
            }
        )
    }

    Add-PodeWebPage -Name 'Form' -ScriptBlock {
        New-PodeWebCard -Content @(
            New-PodeWebForm -Name 'Example' -ScriptBlock {
                $WebEvent.Data | Out-Default
            } -Content @(
                New-PodeWebTextbox -Name 'Name' -AutoComplete {
                    return @('billy', 'bobby', 'alice', 'john', 'sarah', 'matt', 'zack', 'henry')
                }
                New-PodeWebTextbox -Name 'Password' -Type Password -PrependIcon Lock
                New-PodeWebTextbox -Name 'Date' -Type Date
                New-PodeWebTextbox -Name 'Time' -Type Time
                New-PodeWebDateTime -Name 'DateTime' -NoLabels
                New-PodeWebCredential -Name 'Credentials' -NoLabels
                New-PodeWebCheckbox -Name 'Checkboxes' -Options @('Terms', 'Privacy') -AsSwitch
                New-PodeWebRadio -Name 'Radios' -Options @('S', 'M', 'L')
                New-PodeWebSelect -Name 'Role' -Options @('User', 'Admin', 'Operations') -Multiple
                New-PodeWebRange -Name 'Cores' -Value 30 -ShowValue
            )
        )
    }

    Add-PodeWebPage -Name 'Processes' -ScriptBlock {
        New-PodeWebContainer -Content @(
            New-PodeWebChart -Name 'Top Processes' -Type Bar -AutoRefresh -ScriptBlock {
                Get-Process |
                Sort-Object -Property CPU -Descending |
                Select-Object -First 10 |
                ConvertTo-PodeWebChartData -LabelProperty ProcessName -DatasetProperty CPU, Handles
            }
        )
    }
}