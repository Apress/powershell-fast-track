If ((Get-PSSnapin | where {$_.Name -match "Exchange.Management"}) -eq $null)
{
	Add-PSSnapin Microsoft.Exchange.Management.PowerShell.Admin
} 
