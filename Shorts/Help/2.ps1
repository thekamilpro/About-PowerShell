Clear-Host
function Get-CatFact
{
    <#
        .Synopsis
            Gets a random cat fact from the cat fact API.
        .Description
            Function allows to retrieve a random fact about cats of specific one based on ID.
        .PARAMETER Random
            Gets a random cat fact from the cat fact API.
        .PARAMETER ID
            Retrieve specific cat fact 
         .Example
            Get-CatFact
            Retrieves a random fact (same as with -Random switch)
         .EXAMPLE
            Get-CatFact -ID 5c72dbd851021f001415f010
            Retrieves a specific fact
         .LINK
           Documentation: https://alexwohlbruck.github.io/cat-facts/docs/
        .NOTES
           Free PowerShell course and ebook - kamilpro.com
    #>
    [CmdletBinding(DefaultParameterSetName = "byRandom")]
    param(
        [Parameter(ParameterSetName = "byRandom")]
        [switch]$Random,

        [Parameter(Mandatory, ParameterSetName = "byId")]
        [string]$ID
    )
    $url = if ($PSCmdlet.ParameterSetName -eq "byRandom") 
    {
        "https://cat-fact.herokuapp.com/facts/random"
    }
    else 
    {
        "https://cat-fact.herokuapp.com/facts/$id"
    }
    $response = Invoke-RestMethod -Uri $url
    return $response 
}
help Get-CatFact -Full