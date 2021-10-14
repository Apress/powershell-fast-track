$collection=@() #array to collect report data
$data = get-content .\users.txt #read samaccountname from text file 

$data | foreach-object{
  $coll = "" | Select Name,identity,WindowsEmailAddress,Database,ProhibitSendQuota,ProhibitSendReceiveQuota,IssueWarningQuota,employeeid, l,C  #values needed in report
  write-host "processig.............$_"
  
  $getmbx = get-mailbox -identity $_
  $getaduser = get-aduser -identity $_ -properties employeeid, l,C
  
  $coll.Name = $getmbx.Name
  $coll.identity = $getmbx.identity
  $coll.WindowsEmailAddress = $getmbx.WindowsEmailAddress
  $coll.Database= $getmbx.Database
  $coll.ProhibitSendQuota = $getmbx.ProhibitSendQuota
  $coll.ProhibitSendReceiveQuota = $getmbx.ProhibitSendReceiveQuota
  $coll.IssueWarningQuota = $getmbx.IssueWarningQuota
  $coll.employeeid = $getaduser.employeeid #note difference here
  $coll.l = $getaduser.l
  $coll.c = $getaduser.c

  $collection+=$coll #add the collected values to the collecttion array
}

#now export to CSV file
$collection | Export-Csv .\report.csv -NoTypeInformation