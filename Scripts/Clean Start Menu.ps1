$userStartPath = "$([System.Environment]::GetEnvironmentVariable('APPDATA','process'))\Microsoft\Windows\Start Menu\Programs"
	$commonStartPath = "$([System.Environment]::GetEnvironmentVariable('windir','machine'))\..\ProgramData\Microsoft\Windows\Start Menu\Programs"
	$userFolders = Get-ChildItem $userStartPath -Directory -Name
	$commonFolders = Get-ChildItem $commonStartPath -Directory -Name

	#Folders that will be ignored when cleaning the start menu
	$exemptFolders = $(
		"Accessibility"
		"Accessories"
		"Administrative Tools"
		"Maintenance"
		"Startup"
		"StartUp"
		"System Tools"
		"Windows Accessories"
		"Windows Administrative Tools"
		"Windows Ease of Access"
		"Windows PowerShell"
		"Windows System"
	)

	#Special removes
	$specialRemoves = @(
		"7-Zip Help.lnk"
		"CCleaner Homepage.url"
		"Microsoft Expression Blend SDK"
		"Office Language Preferences.lnk"
		"Microsoft Silverlight.lnk"
		"Steam Support Center.url"
		"Uninstall Zoom.lnk"
	)

	#remove the junk shortcuts from the menu
	foreach($dir in $userFolders)
	{
		$currentPath = "$userStartPath\$dir"
		$items = Get-ChildItem $currentPath -Name

		foreach($item in $items)
		{
			if($specialRemoves.Contains($item))
			{
				Remove-Item -Recurse "$currentPath\$item"
			}
		}
	}

	#remove the junk shortcuts from the menu
	foreach($dir in $commonFolders)
	{
		$currentPath = "$commonStartPath\$dir"
		$items = Get-ChildItem $currentPath -Name

		foreach($item in $items)
		{
			if($specialRemoves.Contains($item))
			{
				Remove-Item -Recurse "$currentPath\$item" 
			}
		}
	}


	#Clean the user's start folder
	foreach($dir in $userFolders)
	{
		if(!$exemptFolders.Contains($dir))
		{
			$currentFolder = "$userStartPath\$dir"
			
			if($(Get-ChildItem $currentFolder).Count -eq 0)
			{
				Remove-Item $currentFolder
			}
			elseif ($(Get-ChildItem $currentFolder).Count -eq 1)
			{
				Move-Item -Path "$currentFolder\$(Get-ChildItem $currentFolder -name)" -Destination "$userStartPath\$(Get-ChildItem $currentFolder -name)"
				Remove-Item $currentFolder
			}
		}
	}




	#Clean the common start menu
	foreach($dir in $commonFolders)
	{
		
		if(!$exemptFolders.Contains($dir))
		{
			$currentFolder = "$commonStartPath\$dir"

			if($(Get-ChildItem $currentFolder).Count -eq 0)
			{
				Remove-Item $currentFolder
			}
			elseif ($(Get-ChildItem $currentFolder).Count -eq 1)
			{
				Move-Item -Path "$currentFolder\$(Get-ChildItem $currentFolder -name)" -Destination "$userStartPath\$(Get-ChildItem $currentFolder -name)"
				Remove-Item $currentFolder
			}	
		}
	}