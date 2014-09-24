function Download-File {
param (
  [string]$url,
  [string]$file
 )
  Write-Host "Downloading $url to $file"
  $downloader = new-object System.Net.WebClient
  $downloader.Proxy.Credentials=[System.Net.CredentialCache]::DefaultNetworkCredentials;
  $downloader.DownloadFile($url, $file)
}

$mydocs = [Environment]::GetFolderPath("mydocuments")
Download-File "https://git.kiandra.com.au/sam-critchley/shelllove/raw/master/scripts/PowershellProfile.ps1", "$mydocs\WindowsPowerShell"
