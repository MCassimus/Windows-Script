

[string[]]$ChocoPackages = Get-Content -Path $PWD\..\Misc\ChocolateyPackages.txt

$index = 1
foreach($pkg in $ChocoPackages)
{
	Write-Host "($index / $($ChocoPackages.Count)) Installing package $pkg"
	choco install $pkg -y
	$index++
}