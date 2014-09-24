. (Resolve-Path "$env:LOCALAPPDATA\GitHub\shell.ps1")
#. (Resolve-Path "$env:github_posh_git\install.ps1")
# Load posh-git example profile
. "$env:github_posh_git\profile.example.ps1"

#add sdk to path
$winsdkpath = "$env:PROGRAMFILES\Microsoft SDKs\Windows\v6.0A\bin"
#octotools baby yeh!
$octotoolspath = "$env:HOME\Tools\OctopusTools.2.5.4.35"
$env:Path = "$env:Path;$winsdkpath;$octotoolspath"

$devenv = "${Env:ProgramFiles(x86)}\Microsoft Visual Studio 12.0\Common7\IDE\devenv.exe"
$sourcePath = "$env:HomeDrive$env:HomePath\Source"

function vs {
. "$devenv" @args
}

function go {
  param([string]$location = "source")
  switch ($location) {
    "source" { cd ~/Source }
  }

  if ($location.StartsWith("p:")){
    $project = $location.SubString(2)
    cd ~/Source/$project
  }
}

$Completion_GoProject = {
  param($commandName, $parameterName, $wordToComplete, $commandAst)

  if ($commandName -ne "go"){
    return $null
  }

  if ($wordToComplete.StartsWith("p:", 1) -ne $true){
    return $null
  }

  $startsWith = $wordToComplete.Substring(2)

  $x = Get-ChildItem $sourcePath | ?{ $_.PSIsContainer -and ($startsWith.Length -eq 0 -or $_.Name.StartsWith($startsWith))} |
  ForEach-Object {
    New-Object System.Management.Automation.CompletionResult ('{0}{1}' -f $wordToComplete, $_.Name.Substring($startsWith.Length)), $_.Name, 'ParameterValue', ('{0} ({1})' -f "Part1", "Part2")
  }

  return $x
}

if (-not $global:options) { $global:options = @{CustomArgumentCompleters = @{};NativeArgumentCompleters = @{}}}
$global:options['CustomArgumentCompleters']['location'] = $Completion_GoProject

$function:tabexpansion2 = $function:tabexpansion2 -replace 'End\r\n{','End { if ($null -ne $options) { $options += $global:options} else {$options = $global:options}'
