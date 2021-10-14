#Microsoft Exchange
#Clean Database so that mailboxes appear in disconnected state
Get-MailboxServer | Get-MailboxDatabase | Clean-MailboxDatabase 

##########################################################################
#Find Disconnected Mailboxes
Get-ExchangeServer | Where-Object {$_.IsMailboxServer -eq $true} | ForEach-Object { Get-MailboxStatistics -Server $_.Name | Where-Object {$_.DisconnectDate -notlike ''}} 

##########################################################################
#Extract Message accept from
Get-distributiongroup "dl name" | foreach { $_.AcceptMessagesonlyFrom} | add-content  "c:/output/abc.txt" 

##########################################################################
#Active Sync Stats
Get-CASMailbox -ResultSize unlimited | where {$_.ActiveSyncEnabled -eq "true"} | ForEach-Object {Get-ActiveSyncDeviceStatistics -Mailbox:$_.identity} | select Devicetype, DeviceID,DeviceUserAgent, FirstSyncTime, LastSuccessSync, Identity, DeviceModel, DeviceFriendlyName, DeviceOS | Export-Csv c:\activesync.csv 

##########################################################################
#Message Tracking
Get-transportserver | Get-MessageTrackingLog -Start "03/09/2015 00:00:00 AM" -End "03/09/2015 11:59:59 PM" -sender  "vikas@lab.com" -resultsize unlimited  | select Timestamp,clientip,ClientHostname,ServerIp,ServerHostname,sender,EventId,MessageSubject, TotalBytes , SourceContext,ConnectorId,Source , InternalMessageId , MessageId ,@{Name="Recipents";Expression={$_.recipients}} | export-csv c:\track.csv 


##########################################################################
#Search mailbox / Delete Messages
#Searchonly
import-csv c:\tmp\messagesubject.csv | foreach {Search-Mailbox $_.alias -SearchQuery subject:"Test SUbject" -TargetMailbox "Exmontest" -TargetFolder "Logs" -LogOnly -LogLevel Full} >c:\tmp\output.txt 

##########################################################################
#Delete

import-csv c:\tmp\messagesubject.csv | foreach {Search-Mailbox $_.alias -SearchQuery subject:"Test Schedule" -DeleteContent -force} >c:\tmp\output.txt 

##########################################################################
#Delete & log

import-csv c:\tmp\messagesubject.csv | foreach {Search-Mailbox $_.alias  -SearchQuery Subject:"test Story",Received:>'5/23/2018'  -TargetMailbox "Exmontest" -TargetFolder "Logs"  -deletecontent -force} >c:\tmp\testlog-23-29-left.txt 

##########################################################################
#Exchange Quota Report

#format Date
$date = get-date -format d
$date = $date.ToString().Replace("/", "-")
$output = ".\" + "QuotaReport_" + $date + "_.csv"

Collection = @()
Get-Mailbox -ResultSize Unlimited | foreach-object{
$st = get-mailboxstatistics $_.identity
$TotalSize = $st.TotalItemSize.Value.ToMB()
$user = get-user $_.identity
$mbxr = "" | select DisplayName,Alias,RecipientType,TotalItemSizeinMB, QuotaStatus,
UseDatabaseQuotaDefaults,IssueWarningQuota,ProhibitSendQuota,ProhibitSendReceiveQuota, 
Itemcount, Email,ServerName,Company,Hidden, OrganizationalUnit,
RecipientTypeDetails,UserAccountControl,Exchangeversion
 
$mbxr.DisplayName = $_.DisplayName
$mbxr.Alias = $_.Alias
$mbxr.RecipientType = $user.RecipientType 
$mbxr.TotalItemSizeinMB = $TotalSize
$mbxr.QuotaStatus = $st.StorageLimitStatus
$mbxr.UseDatabaseQuotaDefaults = $_.UseDatabaseQuotaDefaults
$mbxr.IssueWarningQuota = $_.IssueWarningQuota.Value
$mbxr.ProhibitSendQuota = $_.ProhibitSendQuota.Value
$mbxr.ProhibitSendReceiveQuota = $_.ProhibitSendReceiveQuota.Value
$mbxr.Itemcount = $st.Itemcount
$mbxr.Email = $_.PrimarySmtpAddress
$mbxr.ServerName = $st.ServerName
$mbxr.Company = $user.Company
$mbxr.Hidden = $_.HiddenFromAddressListsEnabled
$mbxr.RecipientTypeDetails = $_.RecipientTypeDetails
$mbxr.OrganizationalUnit = $_.OrganizationalUnit
$mbxr.UserAccountControl = $_.UserAccountControl
$mbxr.ExchangeVersion= $_.ExchangeVersion
$Collection += $mbxr
}
 #export the collection to csv , define the $output path accordingly
$Collection | export-csv $output

########################################################################## 
##########################################################################Set Quota
#1GB MailBox Limit (Must have the $false included):
set-mailbox testmailbox -UseDatabaseQuotaDefaults $false -IssueWarningQuota 997376KB -ProhibitSendQuota 1048576KB -ProhibitSendReceiveQuota 4194304KB

##########################################################################
#2GB MailBox Limit (Must have the $false included):
set-mailbox "testmailbox" -UseDatabaseQuotaDefaults $false -IssueWarningQuota 1.75GB -ProhibitSendQuota 2GB -ProhibitSendReceiveQuota 4GB

##########################################################################
#3GB MailBox Limit (Must have the $false included):
set-mailbox "testmailbox" -UseDatabaseQuotaDefaults $false -IssueWarningQuota 2.75GB -ProhibitSendQuota 3GB -ProhibitSendReceiveQuota 5GB
##########################################################################