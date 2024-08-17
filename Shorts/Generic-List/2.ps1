Clear-Host
Write-Host "Add items to list"
$list = [System.Collections.Generic.List[int]]::new()
$list.Add(5)
$list.Add(9)
Write-Host "Count: $($list.Count) First: $($list[0])"

Write-Host "This will fail"
$list.Add("Hi!")