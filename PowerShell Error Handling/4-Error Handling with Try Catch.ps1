#Let's revert to default
$ErrorActionPreference = 'Continue'

#Finally works always
function Start-Work
{
    param (
        [switch]$Die
    )

    Write-Host "Happily working" -ForegroundColor Green
    if ($Die.IsPresent)
    {
        Throw "Aaaargh meeting has started"
    }

    return "Job done"
}

#Without try catch there's not much we can do - script crashes
#Start-Work -Die

#Try/Catch
try
{
    Start-Work -Die
}
catch
{
    Write-Host "Well that doesn't look good..."
    Write-Host $_
    
    #Providing Throw without any comment rethrows the error
    #Throw
}

Write-Host "This is the end"
