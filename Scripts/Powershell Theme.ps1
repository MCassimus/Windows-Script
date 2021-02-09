wget https://github.com/neilpa/cmd-colors-solarized/archive/master.zip -UseBasicParsing -OutFile SolarizedCLI.zip
Expand-Archive SolarizedCLI.zip 
rm SolarizedCLI.zip
Set-Location -Path "SolarizedCLI\cmd-colors-solarized-master"
regedit /s solarized-dark.reg
.\Update-StartMenu.ps1
Set-Location -Path "..\.."
rm -recurse SolarizedCLI