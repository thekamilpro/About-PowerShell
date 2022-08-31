Import-Module -Name Pode, Pode.Web
Import-Module -Name "$PSScriptRoot\scripts\password.ps1" -Force

Start-PodeServer {
    Add-PodeEndpoint -Address localhost -Port 8080 -Protocol Http

    New-PodeLoggingMethod -Terminal | Enable-PodeErrorLogging -Levels @("Error", "Warning")
    New-PodeLoggingMethod -Terminal | Enable-PodeRequestLogging

    Use-PodeWebTemplates -Title 'Active Directory Webapp' -Theme Dark

    $navDiv = New-PodeWebNavDivider
    $navPode = New-PodeWebNavLink -Name 'Pode' -Url 'https://badgerati.github.io/Pode/' -Icon 'help-circle' -NewTab
    $navPodeWeb = New-PodeWebNavLink -Name 'PodeWeb' -Url 'https://badgerati.github.io/Pode.Web/' -Icon 'help-circle' -NewTab
    $navYT = New-PodeWebNavLink -Name 'YouTube' -Url 'https://www.youtube.com/c/KamilPro' -Icon 'youtube' -NewTab
    $navGH = New-PodeWebNavLink -name 'GitHub' -Url 'https://github.com/kprocyszyn/About-PowerShell' -Icon 'github' -NewTab

    Set-PodeWebNavDefault -Items $navPode, $navDiv, $navPodeWeb, $navDiv, $navYT, $navDiv, $navGH


    Add-PodeWebPage -Name 'Generate Password' -ScriptBlock {
        New-PodeWebCard -Content @(
            New-PodeWebForm -Name 'Example' -ScriptBlock {
                
                $WebEvent.Data | Out-Default
                if (!$WebEvent.Data.Options)
                {
                    Show-PodeWebToast -Message "You must select at least one option" -Title "Error"
                }
                else
                {
                    New-Password -Data $WebEvent.Data | Out-Default
                }
                
            } -Content @(
                New-PodeWebRange -Name 'Length' -Min 12 -Max 100 -ShowValue -Value 30
                New-PodeWebCheckbox -Name 'Options' -Options @("uper", "lower", "numeric", "special") -DisplayOptions @("A-Z", "a-z", "0-9", "@#^&$")
            )
        )
    }

}