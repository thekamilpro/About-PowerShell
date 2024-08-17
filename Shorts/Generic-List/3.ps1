Clear-Host
Write-Host "Update items in the list"
$list = [System.Collections.Generic.List[int]]::new()
$list.Add(5)
$list.Add(9)
Write-Host "Item: $($list[1])"
$list[1] = 128
Write-Host "Item: $($list[1])"