function Get-Weather {
    Invoke-IRequest -Uri https://wttr.in/ -ContentOnly
}