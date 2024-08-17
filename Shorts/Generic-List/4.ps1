Clear-Host
Write-Host "Array vs List when adding"
$array = @()
$list = [System.Collections.Generic.List[string]]::new()

$listTime = Measure-Command {
    foreach ($i in 1..100000)
    {
        $list.Add("Hi $i")
    }
}

Write-Host "List seconds: $($listTime.TotalSeconds)"

$arrayTime = Measure-Command {
    foreach ($i in 1..100000)
    {
        $array += ("Hi $i")
    }
}

Write-Host "Array seconds: $($arrayTime.TotalSeconds)"