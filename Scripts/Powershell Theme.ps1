$currentDir = $PWD
Set-Location "$currentDir\Misc\SolarizedCLI\solarized-master"
regedit /s solarized-dark.reg
Invoke-Expression .\Update-StartMenu.ps1
Set-Location $currentDir


# $PowerShellFolder = "$([Environment]::GetFolderPath("MyDocuments"))\WindowsPowerShell"

# regedit /s ..\Misc\SolarizedCLI\solarized-master\solarized-dark.reg
# Copy-Item "$($PWD)\..\Misc\SolarizedCLI\*" -Destination $PowerShellFolder -Recurse -Force

# $currentDir = $PWD
# Set-Location $PowerShellFolder\solarized-master
# Invoke-Expression .\Update-StartMenu.ps1
# Set-Location $currentDir
