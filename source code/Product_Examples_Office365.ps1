##################Exchange Modern Online##################
Function LaunchEOL {
  
  [CmdletBinding()]
  param
  (
    [Parameter(Mandatory = $false)]
    $Credential
  )
  Import-Module ExchangeOnlineManagement -Prefix "EOL" 
  Connect-ExchangeOnline -Prefix "EOL" -Credential $Credential -ShowBanner:$false
}
	

Function RemoveEOL {
  Disconnect-ExchangeOnline -Confirm:$false
}
  
#############Skype Online#####################################
function LaunchSOL
{
  param
  (
    [Parameter(Mandatory = $true)]
    $Domain,
    [Parameter(Mandatory = $false)]
    $Credential
  )
  Write-Host -Object "Enter Skype Online Credentials" -ForegroundColor Green
  $dommicrosoft = $domain + ".onmicrosoft.com"
  $CSSession = New-CsOnlineSession -Credential $Credential -OverrideAdminDomain $dommicrosoft 
  Import-Module (Import-PSSession -Session $CSSession -AllowClobber) -Prefix SOL  -Global
} #Function LaunchSOL

Function RemoveSOL
{
  $Session = Get-PSSession | Where-Object -FilterScript { $_.ComputerName -like "*.online.lync.com" }
  Remove-PSSession $Session
} #Function RemoveSOL

############Sharepoint Online###############################
function LaunchSPO
{
  param
  (
    [Parameter(Mandatory = $true)]
    $orgName,
    [Parameter(Mandatory = $false)]
    $Credential
  )
  Write-Host "Enter Sharepoint Online Credentials" -ForegroundColor Green
  Connect-SPOService -Url "https://$orgName-admin.sharepoint.com" -Credential $Credential
} #LaunchSPO

Function RemoveSPO
{
  disconnect-sposervice
} #RemoveSPO

####Secuirty and Compliance#####################################
Function LaunchCOL {
  [CmdletBinding()]
  param
  (
    [Parameter(Mandatory = $false)]
    $Credential
  )
  Import-Module ExchangeOnlineManagement
  Connect-IPPSSession -Credential $Credential
  $s=Get-PSSession | where {$_.ComputerName -like "*compliance.protection.outlook.com"}
  Import-Module (Import-PSSession -Session $s  -AllowClobber) -Prefix col -Global
}

Function RemoveCOL {
  Disconnect-ExchangeOnline -Confirm:$false
} 
  
###############################Msonline#########################
function LaunchMSOL {

  [CmdletBinding()]
  param
  (
    [Parameter(Mandatory = $false)]
    $Credential
  )
  import-module msonline
  Write-Host "Enter MS Online Credentials" -ForegroundColor Green
  Connect-MsolService -Credential $Credential
}
	
Function RemoveMSOL {
		
  Write-host "Close Powershell Window - No disconnect available" -ForegroundColor yellow
}
################################################################### 

#Exchange Online Mailbox Report

Get-EOLMailbox -ResultSize unlimited | Select Name,RecipientTypeDetails,PrimarySMTPAddress,UserPrincipalName,litigationholdenabled,LitigationHoldDuration,
PersistedCapabilities,RetentionHoldEnabled,RetentionPolicy,RetainDeletedItemsFor,ArchiveName,Archivestatus,ProhibitSendQuota,ProhibitSendReceiveQuota,
MaxSendSize,MaxReceiveSize,AuditEnabled | export-csv c:\auditmbx.csv -notypeinfo 

#########################large teanant more than 50000############################

$allmbx=Invoke-Command -Session (Get-PSSession | Where-Object{$_.computerName -eq "outlook.office365.com"}) -scriptblock {Get-Mailbox -ResultSize unlimited | 
Select-object Name,RecipientTypeDetails, PrimarySMTPaddress,UserPrincipalname,AuditEnabled,litigationholdenabled,LitigationHoldDuration,PersistedCapabilities,
RetentionHoldEnabled,RetentionPolicy,RetainDeletedItemsFor,ArchiveName,Archivestatus,ArchiveGuid,ProhibitSendQuota,ProhibitSendReceiveQuota,MaxSendSize,MaxReceiveSize,
WhenMailboxCreated,WhenCreated,HiddenFromAddressListsEnabled }

$allmbx | export-csv c:\data\auditmbx.csv -notypeinfo


################################################################### 
#Exchange Online Message Tracking

$index = 1
while ($index -le 1001)
{
Get-EOLMessageTrace -SenderAddress "VikasS@techWizard.cloud" -StartDate 09/20/2019 -EndDate 09/25/2019 -PageSize 5000 -Page $index | export-csv c:\messagetracking.csv -Append
$index ++
sleep 5
}

###################################################################
#Searching Unified Log

Search-EOLUnifiedAuditLog -StartDate 1/8/2019 -EndDate 4/7/2019 -RecordType MicrosoftTeams -UserIds VikasS@sycloudpro.com  -ResultSize:5000 |export-csv c:\VikasS.csv -notypeinfo 

###################################################################
#extracting Exchange mailbox audit activity

Search-EOLUnifiedAuditLog -StartDate 10/24/2019 -EndDate 10/25/2019 -UserIds VikasS@syscloudpro.com -recordtype "ExchangeItemGroup","ExchangeItem","ExchangeAggregatedOperation" -ResultSize:5000 |export-csv c:\VikasS.csv -notypeinfo 

###################################################################
#Adding or Removing Role member audit

Search-EOLUnifiedAuditLog -StartDate 4/16/2019 -EndDate 7/15/2019 -UserIds VikasS@syscloudpro.com -operations "Add role member to role" -ResultSize:5000 |export-csv c:\VikasS.csv -notypeinfo 

####################################################################