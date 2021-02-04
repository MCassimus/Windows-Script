$chocoCmd = Get-Command –Name 'choco' –ErrorAction SilentlyContinue –WarningAction SilentlyContinue | Select-Object –ExpandProperty Source
if ($chocoCmd -eq $null) { Invoke-Command -FilePath "Install Chocolatey.ps1" }

[string[]]$ChocoPackages = Get-Content -Path $PWD\..\Misc\ChocolateyPackages.txt

$index = 1
foreach($pkg in $ChocoPackages)
{
	Write-Host "($index / $($ChocoPackages.Count)) Installing package $pkg"
	choco install $pkg -y
	$index++
}