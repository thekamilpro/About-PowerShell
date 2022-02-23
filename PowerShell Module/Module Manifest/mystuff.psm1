function Get-CatFact {
    Invoke-RestMethod https://catfact.ninja/fact
    Get-Quote
}

function Get-Quote {
    $quotes = Invoke-RestMethod https://type.fit/api/quotes
    $random = Get-Random -Minimum 0 -Maximum $quotes.Count
    return $quotes[$random]
}

function Get-Weather {

    Invoke-RestMethod https://wttr.in/

}