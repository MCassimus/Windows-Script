# #Run scripts from the directory
# $scripts = Get-ChildItem -Path "Scripts" -Name
# $scriptsIndex = 1

# Write-Host "Running setup scripts"
# Set-Location -Path "Scripts"
# foreach ($script in $scripts)
# {
# 	Write-Host "($scriptsIndex/$($scripts.Count)) Running $script"
# 	powershell -File $script
# 	$scriptsIndex++
# }
# Set-Location -Path ".."
# Write-Host "Ran all scripts"

Write-Host "Running setup scripts"
& '.\Scripts\Optimizations.ps1'
& '.\Scripts\Remove Bloat.ps1'
& '.\Scripts\Remove Onedrive.ps1'
& '.\Scripts\Set Power Plan.ps1'
& '.\Scripts\Windows Privacy Settings.ps1'
& '.\Scripts\Windows Settings.ps1'
& '.\Scripts\Windows Updates.ps1'
& '.\Scripts\Windows Explorer Settings.ps1'
& '.\Scripts\Windows Features.ps1'
& '.\Scripts\Powershell Theme.ps1'
& '.\Scripts\Install Chocolatey.ps1'
& '.\Scripts\Install Packages.ps1'
& '.\Scripts\Install Office.ps1'
& '.\Scripts\Clean Start Menu.ps1'
Write-Host "Ran all scripts"

#Import registry keys from the directory
$regkeys = Get-ChildItem -Path "Registry Keys" -Name
$regIndex = 1

Write-Host "Importing registry keys"
foreach ($keys in $regkeys)
{
	Write-Host "($regIndex/$($regkeys.Count)) Importing $keys"
	regedit /s "Registry Keys/$keys"
	$regIndex++
}
Write-Host "Completed import of registry keys"


#Create script folder and add to system path
New-Item -ItemType directory "C:\Users\Public\Documents\WindowsPowerShell\Scripts" -Force
$path = [System.Environment]::GetEnvironmentVariable('Path','machine')
$path += ";C:\Users\Public\Documents\WindowsPowerShell\Scripts"
[System.Environment]::SetEnvironmentVariable("Path", $path, "Machine")

#Copy scripts to folder that will be available to the user
Copy-Item "Scripts\Clean Start Menu.ps1" "C:\Users\Public\Documents\WindowsPowerShell\Scripts\CleanStartMenu.ps1" -Force