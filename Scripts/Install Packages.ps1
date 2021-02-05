$chocoCmd = Get-Command –Name 'choco' –ErrorAction SilentlyContinue –WarningAction SilentlyContinue | Select-Object –ExpandProperty Source
if ($chocoCmd -eq $null) 
{ 
	Write-Host "Chocolatey not found - Adding before packages are installed"
	Invoke-Command -FilePath "Install Chocolatey.ps1" 
}

[string[]]$ChocoPackages = Get-Content -Path $PWD\..\Misc\ChocolateyPackages.txt

$index = 1
foreach($pkg in $ChocoPackages)
{
	Write-Host "($index / $($ChocoPackages.Count)) Installing package $pkg"
	choco install $pkg -y
	$index++
}


#Create startup shortcuts for installed apps
Copy-Item "$([System.Environment]::GetEnvironmentVariable('APPDATA','process'))\Microsoft\Windows\Start Menu\Programs\Yubico\Yubico Authenticator.lnk" -Destination "$userStartPath\Yubico Authenticator.lnk"
$userStartPath = "$([System.Environment]::GetEnvironmentVariable('APPDATA','process'))\Microsoft\Windows\Start Menu\Programs\Startup"
../Misc/CreateShortcut.ps1 "wallcat" "$userStartPath\Wallcat.lnk"
