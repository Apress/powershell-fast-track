If ((Get-PSSnapin | where {$_.Name -match "Quest.ActiveRoles"}) -eq $null)  
{  
    Add-PSSnapin Quest.ActiveRoles.ADManagement  
}  
