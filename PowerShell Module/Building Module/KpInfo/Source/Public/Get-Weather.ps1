function Get-Weather {
    Invoke-Request -Uri https://wttr.in/ -ContentOnly
}