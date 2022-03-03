function Get-CatFact {
    $result = Invoke-IRequest -Uri https://catfact.ninja/fact -ContentOnly | ConvertFrom-Json
    return $result.fact
}