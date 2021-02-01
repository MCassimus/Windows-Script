#Invoke-Expression "Scripts/$(Get-ChildItem -Path "Scripts" -Name)"
#Run scripts from the directory
$scripts = Get-ChildItem -Path "Scripts" -Name
$scriptsIndex = 1

Write-Host "Running setup scripts"
Set-Location -Path "Scripts"
foreach ($script in $scripts)
{
	Write-Host "($scriptsIndex/$($scripts.Count)) Running $script"
	powershell -File $script
	$scriptsIndex++
}
Set-Location -Path ".."
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