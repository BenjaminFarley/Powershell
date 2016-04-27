<#
.SYNOPSIS
    Removes builtin apps and Microsoft Edge from Windows 10
    
.DESCRIPTION
    Queries and removes specified Builtin Apps if they are installed, then deletes Edge from Windows 10
    
    This Script requires administrator privileges.
    
    You can run this script from Command prompt using the following:

        powershell.exe -ExecutionPolicy Unrestricted -NoLogo -NoProfile -Command "& '.\RemoveDefaultApps.ps1'"

    This script will not remove the tiles from the start menu on the account that this script is run.
    You will also still have some of the pending apps that need to be un-pinned on new user accounts.

    This script might require additional editing if you need additional apps to be removed. Run the following
    command for a list of installed apps and add the app name into the $AppsForRemoval list:

        Get-AppXPackage | Select Name | Sort Name
#>


$AppsForRemoval='Microsoft.3DBuilder', 'Microsoft.BingFinance', 'Microsoft.BingNews', 'Microsoft.BingSports', 
'Microsoft.BingWeather', 'Microsoft.ConnectivityStore', 'Microsoft.Getstarted', 'Microsoft.Messaging', 
'Microsoft.MicrosoftOfficeHub', 'Microsoft.MicrosoftSolitaireCollection', 'Microsoft.Office.OneNote', 
'Microsoft.Office.Sway', 'Microsoft.People', 'Microsoft.SkypeApp', 'Microsoft.Windows.ParentalControls', 
'Microsoft.Windows.Photos', 'Microsoft.WindowsAlarms', 'Microsoft.WindowsCamera', 'microsoft.windowscommunicationsapps', 
'Microsoft.WindowsMaps', 'Microsoft.WindowsSoundRecorder', 'Microsoft.WindowsStore', 'Microsoft.XboxApp', 
'Microsoft.XboxGameCallableUI', 'Microsoft.XboxIdentityProvider', 'Microsoft.ZuneMusic', 'Microsoft.ZuneVideo'

Get-AppxProvisionedPackage -Online | Where-Object DisplayName -In $AppsForRemoval |
Remove-ProvisionedAppxPackage -Online | Out-Null

Get-AppxPackage -AllUsers | Where-Object Name -In $AppsForRemoval |
Remove-AppxPackage | Out-Null

# Remove Edge

$Directory = "C:\Windows\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe"
$Acl = Get-Acl $Directory
$fsar1 = New-Object System.Security.AccessControl.FileSystemAccessRule("ALL APPLICATION PACKAGES","Read","Allow")
$fsar2 = New-Object System.Security.AccessControl.FileSystemAccessRule("CREATOR OWNER","Read","Allow")
$fsar3 = New-Object System.Security.AccessControl.FileSystemAccessRule("SYSTEM","Read","Allow")
$fsar4 = New-Object System.Security.AccessControl.FileSystemAccessRule("Administrators","FullControl","Allow")
$fsar5 = New-Object System.Security.AccessControl.FileSystemAccessRule("Users","Read","Allow")
$Acl.SetAccessRule($fsar1)
Set-Acl $Directory $Acl
$Acl.SetAccessRule($fsar2)
Set-Acl $Directory $Acl
$Acl.SetAccessRule($fsar3)
Set-Acl $Directory $Acl
$Acl.SetAccessRule($fsar4)
Set-Acl $Directory $Acl
$Acl.SetAccessRule($fsar5)
Set-Acl $Directory $Acl

Remove-Item "C:\Windows\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\MicrosoftEdge.exe" | Out-Null
Remove-Item "C:\Windows\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\MicrosoftEdgeCP.exe" | Out-Null
