Import-Module -Name Pode, Pode.Web
Import-Module -Name "$PSScriptRoot\scripts\password.ps1" -Force

Start-PodeServer {
    Add-PodeEndpoint -Address localhost -Port 8080 -Protocol Http

    New-PodeLoggingMethod -Terminal | Enable-PodeErrorLogging -Levels @("Error", "Warning")
    New-PodeLoggingMethod -Terminal | Enable-PodeRequestLogging

    Use-PodeWebTemplates -Title 'Passwords webapp' -Theme Dark

    $navDiv = New-PodeWebNavDivider
    $navPode = New-PodeWebNavLink -Name 'Pode' -Url 'https://badgerati.github.io/Pode/' -Icon 'server' -NewTab
    $navPodeWeb = New-PodeWebNavLink -Name 'PodeWeb' -Url 'https://badgerati.github.io/Pode.Web/' -Icon 'web-check' -NewTab
    $navYT = New-PodeWebNavLink -Name 'YouTube' -Url 'https://www.youtube.com/c/KamilPro' -Icon 'youtube' -NewTab
    $navGH = New-PodeWebNavLink -name 'GitHub' -Url 'https://github.com/kprocyszyn/About-PowerShell' -Icon 'github' -NewTab
    $navPwpush = New-PodeWebNavLink -name 'PwPush' -Url 'https://pwpush.com/' -Icon 'lock-check' -NewTab

    Set-PodeWebNavDefault -Items $navPode, $navDiv, $navPodeWeb, $navDiv, $navYT, $navDiv, $navGH, $navDiv, $navPwpush


    Add-PodeWebPage -Name 'Generate Password' -NoTitle -ScriptBlock {
        New-PodeWebContainer -Content @(
            New-PodeWebForm -Name 'generatepassword' -SubmitText "Generate" -ShowReset -ScriptBlock {
                
                #$WebEvent.Data | Out-Default
                if (!$WebEvent.Data.Options)
                {
                    Show-PodeWebToast -Message "You must select at least one option" -Title "Error"
                }
                else
                {
                    $np = New-Password -Data $WebEvent.Data
                    Update-PodeWebTextbox -Value $np -Name "Password"

                    if ($WebEvent.Data.Push -eq $true)
                    {
                        $link = Submit-Password -text $np
                        Update-PodeWebTextbox -Value $link -Name "Password link"
                    }
                    else
                    {
                        Update-PodeWebTextbox -Value "" -Name "Password link"
                    }
                }
                
            } -Content @(
                New-PodeWebRange -Name 'Length' -Min 12 -Max 100 -ShowValue -Value 30
                New-PodeWebCheckbox -Name 'Options' -Options @("uper", "lower", "numeric", "special") -DisplayOptions @("A-Z", "a-z", "0-9", "@#^&$")
                New-PodeWebCheckbox -Name "Push" -AsSwitch
                New-PodeWebTextbox -Name "Password"
                New-PodeWebTextbox -Name "Password link" -ReadOnly
            )
        )
    }

}