try 
{
    Get-Command -Name git -CommandType Application -ErrorAction Stop
}
catch
{
    Throw "No git, everything fails"
}

#Not all native applications would return error
try 
{
    git --thiscommanddoesntexist
}
catch
{
    Throw "Git has failed"
}
# That's why we have last exit code
$LASTEXITCODE

git --version
$LASTEXITCODE

git --thiscommanddoesntexist
if ($LASTEXITCODE -ne 0) 
{
Throw "Git has failed"