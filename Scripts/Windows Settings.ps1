#Set timezone
Set-TimeZone -Id "Central Standard Time"

#disable uac
Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name EnableLUA -Value 0

#disable sticky keys prompt
Set-ItemProperty -Path 'HKCU:\Control Panel\Accessibility\StickyKeys' -Name Flags -Type String -Value "506"

#hide taskview
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name ShowTaskViewButton -Type DWord -Value 0

#hide search bar
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search -Name SearchboxTaskbarMode -Type DWord -Value 0

#Show titles in taskbar
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name TaskbarGlomLevel -Type DWord -Value 1