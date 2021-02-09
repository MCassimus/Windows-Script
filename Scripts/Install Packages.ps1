[string[]]$ChocoPackages = Get-Content -Path $PWD\..\Misc\ChocolateyPackages.txt

$index = 1
foreach($pkg in $ChocoPackages)
{
	Write-Host "($index / $($ChocoPackages.Count)) Installing package $pkg"
	choco install $pkg -y
	$index++
}

#Create startup shortcuts for installed apps
Copy-Item "$([System.Environment]::GetEnvironmentVariable('windir','machine'))\..\ProgramData\Microsoft\Windows\Start Menu\Programs\Yubico Authenticator\Yubico Authenticator.lnk" -Destination "$userStartPath\Yubico Authenticator.lnk"
$userStartPath = "$([System.Environment]::GetEnvironmentVariable('APPDATA','process'))\Microsoft\Windows\Start Menu\Programs\Startup"
../Misc/CreateShortcut.ps1 "wallcat" "$userStartPath\Wallcat.lnk"
