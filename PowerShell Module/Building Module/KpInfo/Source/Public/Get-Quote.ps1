function Get-Quote {
    $quotes = Invoke-IRequest -Uri https://type.fit/api/quotes -ContentOnly | ConvertFrom-Json
    $random = Get-Random -Minimum 0 -Maximum $quotes.Count
    return $quotes[$random]
}