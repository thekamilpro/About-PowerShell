function Invoke-Request {
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 1)]
        [uri]$Uri,

        [switch]$ContentOnly
    )

    $params = @{
        UseBasicParsing = $true
        Uri = $Uri
        Verbose = $Verbose.IsPresent
    }

    $result = Invoke-WebRequest @params
    if ($ContentOnly.IsPresent) {
        return $result.Content
    } else {
        return $result
    }
}