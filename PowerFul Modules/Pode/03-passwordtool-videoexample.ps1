Import-Module -name pode, pode.web
Import-Module -name "$PSScriptRoot\scripts\password.ps1" -force

Start-PodeServer {

    Add-PodeEndpoint -Address 0.0.0.0 -Port 8080 -Protocol http -Force

    New-PodeLoggingMethod -Terminal | Enable-PodeErrorLogging -Levels @("Error", "Warning")

    Use-PodeWebTemplates -Title "Passwords webapp" -Theme Dark

    $navDiv = New-PodeWebNavDivider
    $navPode = New-PodeWebNavLink -Name 'Pode' -Url 'https://badgerati.github.io/Pode/' -Icon 'server' -NewTab
    $navPodeWeb = New-PodeWebNavLink -Name 'PodeWeb' -Url 'https://badgerati.github.io/Pode.Web/' -Icon 'web-check' -NewTab
    $navYT = New-PodeWebNavLink -Name 'YouTube' -Url 'https://www.youtube.com/c/KamilPro' -Icon 'youtube' -NewTab
    $navGH = New-PodeWebNavLink -name 'GitHub' -Url 'https://github.com/kprocyszyn/About-PowerShell' -Icon 'github' -NewTab
    $navPwpush = New-PodeWebNavLink -name 'PwPush' -Url 'https://pwpush.com/' -Icon 'lock-check' -NewTab

    Set-PodeWebNavDefault -Items $navPode, $navDiv, $navPodeWeb, $navDiv, $navYT, $navDiv, $navGH, $navDiv, $navPwpush

    Add-PodeWebPage -Name "Password management" -NoTitle -ScriptBlock {

        New-PodeWebContainer -Content @(
            New-PodeWebForm -Name "passwordform" -SubmitText "Generate Password" -ShowReset -ResetText "Reset form"  -Content @(

                New-PodeWebRange -Name "Length" -Min 12 -Max 100 -ShowValue -Value 30
                New-PodeWebCheckbox -Name "Options" -Options @("upper", "lower", "numeric", "special") -DisplayOptions @("A-Z", "a-z", "0-9", "&^@")
                New-PodeWebTextbox -Name "secret" -DisplayName "Password"
                New-PodeWebTextbox -Name "Password Link" -ReadOnly
                New-PodeWebButton -Name "Push password" -CssStyle @{"margin-bottom" = "0rem"} -ScriptBlock {

                    if ([string]::IsNullOrEmpty($WebEvent.Data.secret))
                    {
                        Show-PodeWebToast "Password field cannot be empty" -Title "Error"
                        return
                    }
                    $link = Submit-Password -text $WebEvent.Data.secret
                    $link | Out-Default
                    Update-PodeWebTextbox -Name "Password Link" -Value $link

                }
               
            ) -ScriptBlock {

                $WebEvent.Data | Out-Default

                if (!$WebEvent.Data.Options)
                {
                    Show-PodeWebToast -Message "You must select an option" -Title "Error"
                }
                else
                {
                    $np = New-Password -Data $WebEvent.Data
                    Update-PodeWebTextBox -Value $np -Name "secret"
                }
            }
        )
    }
}