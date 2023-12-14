# Reset password without RDP access
# From https://evotec.xyz/how-to-change-your-own-expired-password-when-you-cant-login-to-rdp/
$userName = 'USERNAME'
[securestring] $oldPassword = Read-Host "Enter old password" -AsSecureString
[securestring] $newPassword = Read-Host "Enter new password" -AsSecureString
$domain = $ENV:USERDNSDOMAIN
$dllImport = @'
[DllImport("netapi32.dll", CharSet = CharSet.Unicode)]
public static extern bool NetUserChangePassword(string domain, string username, string oldpassword, string newpassword);
'@
$netApi32 = Add-Type -MemberDefinition $DllImport -Name 'NetApi32' -Namespace 'Win32' -PassThru
$context = [System.DirectoryServices.ActiveDirectory.DirectoryContext]::new([System.DirectoryServices.ActiveDirectory.DirectoryContextType]::Domain, $Domain)
$domainController = ([System.DirectoryServices.ActiveDirectory.DomainController]::FindOne($Context)).Name
$oldPasswordPlain = [System.Net.NetworkCredential]::new([string]::Empty, $oldPassword).Password
$newPasswordPlain = [System.Net.NetworkCredential]::new([string]::Empty, $newPassword).Password
$result = $netApi32::NetUserChangePassword($domainController, $userName, $oldPasswordPlain, $newPasswordPlain)
