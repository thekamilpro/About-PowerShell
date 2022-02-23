function Get-Quote {
    $quotes = Invoke-RestMethod https://type.fit/api/quotes
    $random = Get-Random -Minimum 0 -Maximum $quotes.Count
    return $quotes[$random]
}