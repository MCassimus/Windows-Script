#disable bing search results from start menu search
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search -Name BingSearchEnabled -Type DWord -Value 0

#disable letting apps use advertising id
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo -Name Enabled -Type DWord -Value 0

#disable Smart screen
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost -Name EnableWebContentEvaluation -Type DWord =Value 0

#Wifi sense hotspot sharing
Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\PolicyManager\default\Wifi\AllowWiFiHotSpotReporting -Name value -Type DWord -Value 0
Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\PolicyManager\default\Wifi\AllowAutoConnectToWiFiSenseHotspots -Name value -Type DWord -Value 0

#location tracking disable
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -Name SensorPermissionState -Type DWord -Value 0
Set-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration -Name Status -Type DWord -Value 0

#disable activity tracking
@('EnableActivityFeed', 'PublishUserActivities', 'UploadUserActivities') | ForEach-Object {
	Set-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\System -Name $_ -Type Dword -Value 0
}