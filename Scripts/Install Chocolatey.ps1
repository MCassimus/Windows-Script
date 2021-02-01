Write-Host "Installing Chocolatey"
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco install chocolatey-core.extension -y

Write-Host "Intsalled chocolatey, setting up automatic updates"
# See if choco.exe is available. If not, stop execution
$chocoCmd = Get-Command –Name 'choco' –ErrorAction SilentlyContinue –WarningAction SilentlyContinue | Select-Object –ExpandProperty Source
if ($chocoCmd -eq $null) { break }

# Settings for the scheduled task
$taskAction = New-ScheduledTaskAction –Execute $chocoCmd –Argument 'upgrade all -y'
$taskTrigger = New-ScheduledTaskTrigger -Daily -At 5am
$taskUserPrincipal = New-ScheduledTaskPrincipal –UserId 'SYSTEM'
$taskSettings = New-ScheduledTaskSettingsSet –Compatibility Win8

# Set up the task, and register it
$task = New-ScheduledTask –Action $taskAction –Principal $taskUserPrincipal –Trigger $taskTrigger –Settings $taskSettings
Register-ScheduledTask –TaskName 'Run a Choco Upgrade All at Startup' –InputObject $task –Force

#Accept installs globally
choco feature enable -n allowGlobalConfirmation

Write-Host "Done Installing Chocolatey"