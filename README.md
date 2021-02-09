# Windows 10 Setup Script
This is my personal setup script for windows 10 because I setup too many windows machines. This installs a good majority of the programs I use frequently (Hopefully will add more with the release of the WinGet package manager) and setup all of my windows settings with a few exceptions.  

After running this script, I only need to login (not included in scripts for obvious reasons) and setup any sort of network specific shares/applications.

# Installation (Powershell)
## Manual Installation
`wget https://github.com/MCassimus/Windows-Script/archive/main.zip -UseBasicParsing -OutFile WindowsSetup.zip`  
`Expand-Archive WindowsSetup.zip`  
`rm WindowsSetup.zip`  
`& '.\WindowsSetup\Windows-Script-main\Setup Windows.ps1'`  

## Automatic Installation One-Liner 
*Coming soon*  

# Included Scripts & Tweaks
## Scripts
- Clean Start Menu ([Clean Start Menu.ps1](https://github.com/MCassimus/Windows-Script/blob/main/Scripts/Clean%20Start%20Menu.ps1))
	- Replaces folders in start menu with their program shortcut where applicable
	- Running the script in the parent directory adds this to the public profile and adds the directory to the user path environment variable for convenient use
- Install Chocolatey ([Install Chocolatey.ps1](https://github.com/MCassimus/Windows-Script/blob/main/Scripts/Install%20Chocolatey.ps1))
	- Installs the chocolatey package manager
	- Creates a scheduled task to update programs every day at 5:00 AM
		- This is only for programs installed via the choco command
- Install Packages ([Install Packages.ps1](https://github.com/MCassimus/Windows-Script/blob/main/Scripts/Install%20Packages.ps1))
	- Installs packages specified in [Misc/ChocolateyPackges.txt](https://github.com/MCassimus/Windows-Script/blob/main/Misc/ChocolateyPackages.txt)
	- Creates a shortcut to a few programs to shell:startup to launch with windows
- Windows Optimzations ([Optimzations.ps1](https://github.com/MCassimus/Windows-Script/blob/main/Scripts/Optimizations.ps1))
	- Disable wpad
	- Disable the sysmain service to preserve some system memory
	- Disable Automatic Disk Optimization (Disk Defrag)
		- I do not have any spinning drives anymore, and would rather not have excessive reads/writes to my SSDs
- Set Powershell Theme ([Powershell Theme.ps1](https://github.com/MCassimus/Windows-Script/blob/main/Scripts/Powershell%20Theme.ps1))
	- Clones [neilpa/cmd-colors-solarized](https://github.com/neilpa/cmd-colors-solarized) and installs dark theme for powershell
- Remove UWP/Windows Store Bloat ([Remove Bloat.ps1](https://github.com/MCassimus/Windows-Script/blob/main/Scripts/Remove%20Bloat.ps1))
- Uninstall Onedrive ([Remove Onedrive.ps1](https://github.com/MCassimus/Windows-Script/blob/main/Scripts/Remove%20Onedrive.ps1))
	- No, seriously Microsoft. I have enough storage that isn't formatted when I reinstall your operating system.
- Powerplan ([Set Power Plan.ps1](https://github.com/MCassimus/Windows-Script/blob/main/Scripts/Set%20Power%20Plan.ps1))
	- Imports my powerplan (stored at Misc/powerplan)
		- If you fork, you can use you own powerplan  
		`powercfg /list` (copy use the GUID with the asterisk next to it for the next command)  
		`powercfg /export {outfile} {plan GUID}`
	- Disable hibernation
- Windows Explorer Settings ([Set Power Plan.ps1](https://github.com/MCassimus/Windows-Script/blob/main/Scripts/Windows%20Explorer%20Settings.ps1))
	- Set Default View to This PC
	- Always show details with file operations
	- Disable recent&frequent file/folder tracking
	- Show file extensions
	- Remove folders I dont use (almost all others are commented for customization)
		- 3D Objects
		- Music
		- Pictures
		- Videos
	- Hide other folders under user profile (C:\Users\{username}\)
		- Favorites
		- Saved Games
		- Searches
		- Contacts
		- Links
- Add & Remove Windows Features ([Windows Features.ps1](https://github.com/MCassimus/Windows-Script/blob/main/Scripts/Windows%20Features.ps1))
	- I explicitly list all of them just because (compare to defaults - add to TODO?)
- Adjust Windows Privacy Settings ([Windows Privacy Settings.ps1](https://github.com/MCassimus/Windows-Script/blob/main/Scripts/Windows%20Privacy%20Settings.ps1)) ***PLEASE DO NOT USE THIS IN A WORK ENVIROMENT WITHOUT THOROUGH REVIEW***
	- Run O&O Shutup with recommended settings
	- Disable bing search results from start menu/taskbar search
	- Disable settings that let apps use advertising ID to customize advertising
	- Disable Windows Smart Screen
	- Disable Location Permissions
	- Disable Wifi Sense Hotspot Sharing
	- Disable app activity tracking
	- There is also a whole mess in this script I need to go through (and is another reason for the bolded note for this one)
- Apply Windows Settings ([Windows Settings.ps1](https://github.com/MCassimus/Windows-Script/blob/main/Scripts/Windows%20Settings.ps1))
	- Set timezone to UTC-6 / CST  
	*Customize with yours listed in the output `Get-TimeZone -ListAvailable`*
	- Disable UAC (User Account Control)
		- **Don't** be a dumb user and download pc components when your system is bursting into flames and crying for professional help. 
	- Enable numlock after boot
	- Default to an expanded view of task manager
	- Remove edge shortcut from desktop (all profiles)
	- Windows Settings 
		- System
			- Storage
				- Disable storage sense
		- Personalization
			- Colors
				- Set dark theme
			- Start Menu
				- Dont show recently added apps
				- Dont show frequently used programs or documents
			- Taskbar
				- Hide the Task View buttom
				- Hide the Windows Search bar
				- Always show windows titles in taskbar (no hiding labels)
				- Remove the people icon
		- Accessibility
			- Prt Sc opens Snip & Sketch
			- Underline access keys when holding Alt
			- Sticky Keys disabled
			- Toggle Keys disabled
			- Filter Keys disabled
- Freeze Windows Updates ([Windows Updates.ps1](https://github.com/MCassimus/Windows-Script/blob/main/Scripts/Windows%20Updates.ps1))
	- Only get driver updates. Reinstallations happen frequently enough to grab the latest update (if I choose) before freezing again. 
		- Some of my custom images include update ... and I do not update further if I do not have a reason to

## Tweaks (Registry)
- [Remove Shortcut Text](https://github.com/MCassimus/Windows-Script/blob/main/Registry%20Keys/Remove%20Shortcut%20Text.reg)
	- Remove the "- Shortcut" post-fix from the Send to (Desktop) context-menu option
- [Internet Speed Fix](https://github.com/MCassimus/Windows-Script/blob/main/Registry%20Keys/Internet%20Speed%20Fix.reg)
	- Add registry keys to remove traffic priorities to connection checks, windows update, etc. 

# To Do
- GUI for script
	- Maybe create a program to act like the settings app for ease of use and automatically write the .reg file to import. For the apps part, add option to create a shell:startup or shell:common startup shortcut
- create laptop/desktop versions
- Convert scripts into .reg files where applicable (merges seem to be significantly faster)
- Compare dism features to default so not every single package is listed in the script
- Context menu edits
	- Powershell here always show (admin option available?)
	- Remove some options that arent used?
	- clean shell:sendto
- Customize start menu tile layout (something with xml I think is how this is done?)
	- I like everything unpinned
- disable all things for startup programs
	- blacklist some apps such as yubico authenticator
- Clean Start Menu script automation
	- task schedule? (every restart and/or login?)
	- can I do this after a program is installed?
- Disable unnecessary services (should also document their purpose in comments just in case)
- Task manager
	- Default tab set to performance
	- Show graphs
	- Show logical processors on CPU tab
- Windows explorer regedits
	- View
		- show full path in title bar
		- diable hiding of empty drives
	- Search
		- Dont use the index when searching in file folders
		- When searching non-indexed locations
			- dont include system directories
			- include compressed/zipped folders
	- Remove pictures pin from quick access
	- Pin windows explorer ribbon to always be open
- Complete regedits for windows settings
	- System
		- Disable Shared Experiences
		- Enable clipboard history
		- Remote Desktop (disable laptop/enable desktop)
	- Personalization
		- Auto choose accent color
		- taskbar
			- create list of enabled/disabled system icons
				- clock - on
				- volume - on
				- network - on
				- power - on (when applicable)
				- input indicator - off
				- location - off
				- action center - off
				- touch keyboard - off
				- windows ink workspace - off
				- touchpad - off
				- microphone - off
				- meet now - off
			- show taskbar on multiple displays
				- show window on taskbar where the window is open
	- Apps 
		- Default apps
			- Web - Google Chrome
			- Email - Outlook
			- .txt - Sublime Text 3
			- Anything associated with programming - VS code
	- Gaming 
		- enable xbox game bar opens with xbox button 
		- disable Game mode
	- Search
		- Permissions & History
			- disable SafeSearch
			- Cloud content search
				- microsoft account - off
				- work of school account - off
			- disable search history on this device
	- Privacy
		- General
			- disable Websites provide locally relevant content
			- disable windows track app launches
			- disable suggested content in settings app
		- Speech
			- turn off speech recognition
		- Inking and Typing personalization
			- disable completely
		- Location
			- disable app access
		- Camera
			- disable app access
		- Voice Activation
			- disable app access
		- Notifications
			- disable app access
		- Contacts
			- disable app access
		- Calandar
			- disable app access
		- Phone Calls
			- disable app access
		- Call History
			- disable app access
		- Email
			- disable app access
		- Tasks
			- disable app access
		- Messaging
			- disable app access
		- Radios
			- disable app access
		- Other Devices
			- disable app access
		- App Diagnostics
			- disable app access
		- Videos
			- disable app access
	- Updates & Security
		- set active hours to 8:00AM to 5:00PM
		- dont run recommended troubleshooting
		- find my device (enable laptops/disable desktops)