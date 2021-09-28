
<#PSScriptInfo
.VERSION 1.0.0
.GUID f5228c81-d25c-4984-bb0c-e64576487b3e
.AUTHOR Kamil Procyszyn
.COPYRIGHT Kamil Procyszyn
.PROJECTURI https://github.com/kprocyszyn/About-PowerShell
.RELEASENOTES 2021 October
.DESCRIPTION
Link to the video:
Documentation:
#>

<#
About PsCustomObject:

#>

# Creating custom object:
$obj = [PSCustomObject]@{
    Name = "Mr Fiber"
    Species = "Domestic cat"
    Type = "Tabby cat"
}
$obj