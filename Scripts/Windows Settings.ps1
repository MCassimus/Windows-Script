#Set timezone
Set-TimeZone -Id "Central Standard Time"

#disable uac
Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name EnableLUA -Value 0

#disable sticky keys prompt
Set-ItemProperty -Path 'HKCU:\Control Panel\Accessibility\StickyKeys' -Name Flags -Type String -Value "506"
#disable toggle keys prompt
Set-ItemProperty -Path 'HKCU:\Control Panel\Accessibility\ToggleKeys' -Name Flags -Type String -Value "58"
#disable filter keys
Set-ItemProperty -Path 'HKCU:\Control Panel\Accessibility\Keyboard Response' -Name Flags -Type String -Value "122"
#underline access keys enable
Set-ItemProperty -Path 'HKCU:\Control Panel\Accessibility\Keyboard Preference' -Name On -Type String -Value 1
#PrtScr for snip and sketch
Set-ItemProperty -Path 'HKCU:\Control Panel\Keyboard' -Name PrintScreenKeyForSnippingEnabled -Type DWord -Value 1

#hide taskview
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name ShowTaskViewButton -Type DWord -Value 0

#hide search bar
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search -Name SearchboxTaskbarMode -Type DWord -Value 0

#dont show recently started programs or documents
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name Start_TrackDocs -Type DWord -Value 0
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name Start_TrackProgs -Type DWord -Value 0

#dont show recently added apps in start menu
If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer")) {
	New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" | Out-Null
}
Set-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer -Name HideRecentlyAddedApps -Value 1

#helpful site: https://ss64.com/nt/syntax-reghacks.html
#Show titles in taskbar
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name TaskbarGlomLevel -Type DWord -Value 2

#remove people icon
Write-Host "Hiding People icon..."
If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People")) {
	New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" | Out-Null
}
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name "PeopleBand" -Type DWord -Value 0

#enable numlock after boot
Write-Host "Enabling NumLock after startup..."
If (!(Test-Path "HKU:")) {
	New-PSDrive -Name HKU -PSProvider Registry -Root HKEY_USERS | Out-Null
}
Set-ItemProperty -Path "HKU:\.DEFAULT\Control Panel\Keyboard" -Name "InitialKeyboardIndicators" -Type DWord -Value 2147483650
Add-Type -AssemblyName System.Windows.Forms
If (!([System.Windows.Forms.Control]::IsKeyLocked('NumLock'))) {
	$wsh = New-Object -ComObject WScript.Shell
	$wsh.SendKeys('{NUMLOCK}')
}

#open full view of task manager
Write-Host "Showing task manager details..."
$taskmgr = Start-Process -WindowStyle Hidden -FilePath taskmgr.exe -PassThru
Do {
	Start-Sleep -Milliseconds 100
$preferences = Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\TaskManager" -Name "Preferences" -ErrorAction SilentlyContinue
} Until ($preferences)
Stop-Process $taskmgr
$preferences.Preferences[28] = 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\TaskManager" -Name "Preferences" -Type Binary -Value $preferences.Preferences

#storage sense disable
 Write-Host "Disabling Storage Sense..."
Remove-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Recurse -ErrorAction SilentlyContinue

#set theme to dark mode
Write-Host "Enabling Dark Mode"
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0

#remove edge shortcut from desktop
Remove-Item -Force -Path "C:\Users\Public\Desktop\Microsoft Edge.lnk"