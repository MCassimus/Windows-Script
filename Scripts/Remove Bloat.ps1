$Bloatware = @(

	#Unnecessary Windows 10 AppX Apps
	"Microsoft.3DBuilder"
	"Microsoft.AppConnector"
	"Microsoft.BingFinance"
	"Microsoft.BingNews"
	"Microsoft.BingSports"
	"Microsoft.BingTranslator"
	"Microsoft.BingWeather"
	"Microsoft.GetHelp"
	"Microsoft.Getstarted"
	"Microsoft.Messaging"
	"Microsoft.Microsoft3DViewer"
	"Microsoft.MicrosoftOfficeHub"
	"Microsoft.MicrosoftSolitaireCollection"
	"Microsoft.MixedReality.Portal"
	"Microsoft.NetworkSpeedTest"
	"Microsoft.News"
	"Microsoft.Office.Lens"
	"Microsoft.Office.OneNote"
	"Microsoft.Office.Sway"
	"Microsoft.OneConnect"
	"Microsoft.People"
	"Microsoft.Print3D"
	"Microsoft.SkypeApp"
	"Microsoft.StorePurchaseApp"
	"Microsoft.Wallet"
	"Microsoft.Whiteboard"
	"Microsoft.WindowsAlarms"
	"microsoft.windowscommunicationsapps"
	"Microsoft.WindowsFeedbackHub"
	"Microsoft.WindowsMaps"
	"Microsoft.WindowsSoundRecorder"
	"Microsoft.ZuneMusic"
	"Microsoft.ZuneVideo"

	#Sponsored Windows 10 AppX Apps
	#Add sponsored/featured apps to remove in the "*AppName*" format
	"*EclipseManager*"
	"*ActiproSoftwareLLC*"
	"*AdobeSystemsIncorporated.AdobePhotoshopExpress*"
	"*Duolingo-LearnLanguagesforFree*"
	"*PandoraMediaInc*"
	"*CandyCrush*"
	"*BubbleWitch3Saga*"
	"*Wunderlist*"
	"*Flipboard*"
	"*Twitter*"
	"*Facebook*"
	"*Royal Revolt*"
	"*Sway*"
	"*Speed Test*"
	"*Dolby*"
	"*Viber*"
	"*ACGMediaPlayer*"
	"*Netflix*"
	"*OneCalendar*"
	"*LinkedInforWindows*"
	"*HiddenCityMysteryofShadows*"
	"*Hulu*"
	"*HiddenCity*"
	"*AdobePhotoshopExpress*"
				
	#Optional: Typically not removed but you can if you need to for some reason
	#"*Microsoft.Advertising.Xaml_10.1712.5.0_x64__8wekyb3d8bbwe*"
	#"*Microsoft.Advertising.Xaml_10.1712.5.0_x86__8wekyb3d8bbwe*"
	"*Microsoft.BingWeather*"
	"*Microsoft.MSPaint*"
	"*Microsoft.MicrosoftStickyNotes*"
	#"*Microsoft.Windows.Photos*"
	#"*Microsoft.WindowsCalculator*"
	#"*Microsoft.WindowsStore*"
)

$index = 1
foreach ($Bloat in $Bloatware) {
	Get-AppxPackage -Name $Bloat| Remove-AppxPackage
	Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like $Bloat | Remove-AppxProvisionedPackage -Online
	Write-Host "($index/$($Bloatware.Count)) Trying to remove $Bloat."
	$index++
}