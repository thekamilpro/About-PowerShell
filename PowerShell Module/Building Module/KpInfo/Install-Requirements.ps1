$modules = @("ModuleBuilder")
foreach ($m in $modules) {

    try {
        Get-InstalledModule -Name $m -ErrorAction stop
    } catch {
        Write-Host "Installing $m"
        Install-Module -Name $m -Force
    }
}