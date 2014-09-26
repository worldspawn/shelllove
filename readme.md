## Install

```@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/worldspawn/shelllove/master/install.ps1'))"```

### Nice to do

- detect latest version of vs, make vs shortcut use that
- detect octotools version instead of full hard coded path
- detect latest winsdk
- fix https credential cache
- maybe some octopus integration, wrap octo.exe to deploy release for example
  - create a .octo file that describes config points (project name, environment name(s)) to assist the wrapper
  - api key can't go in the config file. but perhaps the name of the environment variable that is hodling the key could
