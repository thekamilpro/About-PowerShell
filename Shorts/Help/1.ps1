Clear-Host
function Get-CatFact
{
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