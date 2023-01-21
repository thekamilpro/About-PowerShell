$link = "https://download-installer.cdn.mozilla.net/pub/firefox/releases/107.0/win64/en-GB/Firefox%20Setup%20107.0.exe"

$tempFolder = [System.IO.Path]::GetTempPath()
$destination = "$tempFolder/firefox.exe"

#Invoke Web Request
#If the downloads runs slow (e.g. Windows PowerShell), change progress preference 
#$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri $link -OutFile  $destination

#Using Invoke-RestMethod, essentialy it's the same
Invoke-RestMethod -Uri $link -OutFile $destination

#Using class
$client = [System.Net.WebClient]::new()
$client.DownloadFile($link, $destination)

#as above, but one line
([System.Net.WebClient]::new()).DownloadFile($link, $destination)

#Windows Only - Bits Transfer
Start-BitsTransfer -Source $link -Destination $destination