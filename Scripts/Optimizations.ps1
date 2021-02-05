# Disable WPAD 
# https://docs.microsoft.com/en-us/security-updates/securitybulletins/2016/ms16-077#workarounds
Add-Content "c:\windows\system32\drivers\etc\hosts" "        255.255.255.255  wpad."


#disable sysmain to keep some more ram
Write-Host "Stopping and disabling Superfetch service..."
Stop-Service "SysMain" -WarningAction SilentlyContinue
Set-Service "SysMain" -StartupType Disabled

#disable disk defrag/optimization for SSDs(I dont own a spinning drive anymore)
Write-Host "Disabling scheduled disk defrag"
schtasks /Delete /TN "Microsoft\Windows\Defrag\ScheduledDefrag" /F
Stop-Service "defragsvc" -WarningAction SilentlyContinue
Set-Service "defragsvc" -StartupType Disabled