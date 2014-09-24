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

if ([System.IO.File]::Exists("$mydocs\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"))
{
  if ([System.IO.File]::Exists("$mydocs\WindowsPowerShell\Microsoft.PowerShell_profile.ps1.old"))
  {
    [System.IO.File]::Delete("$mydocs\WindowsPowerShell\Microsoft.PowerShell_profile.ps1.old")
  }

  [System.IO.File]::Move("$mydocs\WindowsPowerShell\Microsoft.PowerShell_profile.ps1", "$mydocs\WindowsPowerShell\Microsoft.PowerShell_profile.ps1.old")
}

Download-File -url "https://github.com/worldspawn/shelllove/blob/master/scripts/PowershellProfile.ps1" -file "$mydocs\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
