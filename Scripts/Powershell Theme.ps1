$PowerShellFolder = "$([Environment]::GetFolderPath("MyDocuments"))\WindowsPowerShell"

regedit /s ..\Misc\SolarizedCLI\solarized-master\solarized-dark.reg
Copy-Item "$($PWD)\..\Misc\SolarizedCLI\*" -Destination $PowerShellFolder -Recurse -Force

$currentDir = $PWD
Set-Location $PowerShellFolder\solarized-master
Invoke-Expression .\Update-StartMenu.ps1
Set-Location $currentDir
