Exchange 2010:
If ((Get-PSSnapin | Where-Object { $_.Name -match "Microsoft.Exchange.Management.PowerShell.E2010" }) -eq $null) {
    Add-PSSnapin Microsoft.Exchange.Management.PowerShell.E2010
}
 