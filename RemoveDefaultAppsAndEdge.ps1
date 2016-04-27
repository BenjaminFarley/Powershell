## NOTE: This script will not remove the tiles from the start menu on the account
## that this script is run.
## You will also still have some of the pending apps that need to be un-pinned on new user accounts

## Add any applications "DisplayName" that you would like to remove into this list.
$AppsForRemoval='Microsoft.3DBuilder', 'Microsoft.BingFinance', 'Microsoft.BingNews', 'Microsoft.BingSports', 
'Microsoft.BingWeather', 'Microsoft.ConnectivityStore', 'Microsoft.Getstarted', 'Microsoft.Messaging', 
'Microsoft.MicrosoftOfficeHub', 'Microsoft.MicrosoftSolitaireCollection', 'Microsoft.Office.OneNote', 
'Microsoft.Office.Sway', 'Microsoft.People', 'Microsoft.SkypeApp', 'Microsoft.Windows.ParentalControls', 
'Microsoft.Windows.Photos', 'Microsoft.WindowsAlarms', 'Microsoft.WindowsCamera', 'microsoft.windowscommunicationsapps', 
'Microsoft.WindowsMaps', 'Microsoft.WindowsSoundRecorder', 'Microsoft.WindowsStore', 'Microsoft.XboxApp', 
'Microsoft.XboxGameCallableUI', 'Microsoft.XboxIdentityProvider', 'Microsoft.ZuneMusic', 'Microsoft.ZuneVideo'

#Remove from Image
Get-AppxProvisionedPackage -Online | Where-Object DisplayName -In $AppsForRemoval |
Remove-ProvisionedAppxPackage -Online | Out-Null

#Remove from Users
Get-AppxPackage -AllUsers | Where-Object Name -In $AppsForRemoval |
Remove-AppxPackage | Out-Null


## Comment this secton of code if you do not want to remove Edge.
## You can "re-install" edge by adding back in the two .exe files
## from a standard build of Windows 10

$Directory = "C:\Windows\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe"
$Acl = Get-Acl $Directory
$Ar1 = New-Object System.Security.AccessControl.FileSystemAccessRule("ALL APPLICATION PACKAGES","Read","Allow")
$Ar2 = New-Object System.Security.AccessControl.FileSystemAccessRule("CREATOR OWNER","Read","Allow")
$Ar3 = New-Object System.Security.AccessControl.FileSystemAccessRule("SYSTEM","Read","Allow")
$Ar4 = New-Object System.Security.AccessControl.FileSystemAccessRule("Administrators","FullControl","Allow")
$Ar5 = New-Object System.Security.AccessControl.FileSystemAccessRule("Users","Read","Allow")
$Ar6 = New-Object System.Security.AccessControl.FileSystemAccessRule("TrustedInstaller","Read","Allow")
$Acl.SetAccessRule($Ar1)
Set-Acl $Directory $Acl
$Acl.SetAccessRule($Ar2)
Set-Acl $Directory $Acl
$Acl.SetAccessRule($Ar3)
Set-Acl $Directory $Acl
$Acl.SetAccessRule($Ar4)
Set-Acl $Directory $Acl
$Acl.SetAccessRule($Ar5)
Set-Acl $Directory $Acl

Remove-Item "C:\Windows\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\MicrosoftEdge.exe"
Remove-Item "C:\Windows\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\MicrosoftEdgeCP.exe"
