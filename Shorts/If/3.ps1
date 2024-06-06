Clear-Host
function Get-RandomDay
{
    $random = [System.Random]::new()
    $date = [datetime]::new(2024, 1, 1)
    $range = ([datetime]::Today - $date).Days
    $output = $date.AddDays($random.Next($range))
    return $output.DayOfWeek
}

$day = Get-RandomDay
Write-Host "Random day: $day"
if ($day -in @('Monday', 'Tuesday','Wednesday', 'Thursday'))
{
    Write-Host "Work Work"
}
elseif ($day -eq 'Friday') 
{
   Write-Host "It's practically a weekend"
}
else
{
    Write-Host "Weekend!"
}