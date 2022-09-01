function New-Password
{
    param(
        [hashtable]$Data
    )

    $params = @{
        Length  = $Data.Length
        upper   = 0
        lower   = 0
        numeric = 0
        special = 0
    }

    if ($Data.Options)
    {
        $options = $data.Options.Split(',')

        if ($options.Contains('upper'))
        {
            $params.upper = 1
        }

        if ($options.Contains('lower'))
        {
            $params.lower = 1
        }

        if ($options.Contains('numeric'))
        {
            $params.numeric = 1
        }

        if ($options.Contains('special'))
        {
            $params.special = 1
        }
    }
    
    return Get-RandomPassword @params
}
function Get-RandomPassword
{
    #Script by: https://arminreiter.com/2021/07/3-ways-to-generate-passwords-in-powershell/
    param (
        [Parameter(Mandatory)]
        [ValidateRange(12, [int]::MaxValue)]
        [int] $length,
        [int] $upper = 0,
        [int] $lower = 0,
        [int] $numeric = 0,
        [int] $special = 0
    )
    if ($upper + $lower + $numeric + $special -gt $length)
    {
        throw "number of upper/lower/numeric/special char must be lower or equal to length"
    }
    $uCharSet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    $lCharSet = "abcdefghijklmnopqrstuvwxyz"
    $nCharSet = "0123456789"
    $sCharSet = "/*-+,!?=()@;:._"
    $charSet = ""
    if ($upper -gt 0) { $charSet += $uCharSet }
    if ($lower -gt 0) { $charSet += $lCharSet }
    if ($numeric -gt 0) { $charSet += $nCharSet }
    if ($special -gt 0) { $charSet += $sCharSet }
    
    $charSet = $charSet.ToCharArray()
    $rng = New-Object System.Security.Cryptography.RNGCryptoServiceProvider
    $bytes = New-Object byte[]($length)
    $rng.GetBytes($bytes)
 
    $result = New-Object char[]($length)
    for ($i = 0 ; $i -lt $length ; $i++)
    {
        $result[$i] = $charSet[$bytes[$i] % $charSet.Length]
    }
    $password = (-join $result)
    $valid = $true
    if ($upper -gt ($password.ToCharArray() | Where-Object { $_ -cin $uCharSet.ToCharArray() }).Count) { $valid = $false }
    if ($lower -gt ($password.ToCharArray() | Where-Object { $_ -cin $lCharSet.ToCharArray() }).Count) { $valid = $false }
    if ($numeric -gt ($password.ToCharArray() | Where-Object { $_ -cin $nCharSet.ToCharArray() }).Count) { $valid = $false }
    if ($special -gt ($password.ToCharArray() | Where-Object { $_ -cin $sCharSet.ToCharArray() }).Count) { $valid = $false }
 
    if (!$valid)
    {
        $password = Get-RandomPassword $length $upper $lower $numeric $special
    }
    return $password
}

function Submit-Password
{
    param ([string]$text)
    
    $url = "https://pwpush.com/p.json"
    $body = @{
        password = @{
            "payload" = $text
            "expire_after_days" = "2"
            "expire_after_views" = "10"
            "note" = ""
            "retrieval_step" = "true"
            "deletable_by_viewer" = "false"
        }
    } | ConvertTo-Json

    $response = Invoke-RestMethod -Method Post -Uri $url -Body $body -ContentType "application/json"
    return "https://pwpush.com/p/$($response.url_token)" 
}