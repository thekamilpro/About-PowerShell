#Investigating errors
Invoke-RestMethod -Uri qazedc.fds

#Only PowerShell v7 and newer
Get-Error 

$Error[0].InvocationInfo
$Error[0].Exception
$Error[0].Exception.Message
$Error[0].Exception.StackTrace

#This line is useful for typed exceptions
$Error[0].exception.GetType().FullName