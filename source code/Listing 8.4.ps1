$report = $reportpath
Clear-Content $report
###############################HTml Report Content############################
Add-Content $report "<html>" 
Add-Content $report "<head>" 
Add-Content $report "<meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'>" 
Add-Content $report '<title>Exchange Status Report</title>' 
add-content $report '<STYLE TYPE="text/css">' 
add-content $report  "<!--" 
add-content $report  "td {" 
add-content $report  "font-family: Tahoma;" 
add-content $report  "font-size: 11px;" 
add-content $report  "border-top: 1px solid #999999;" 
add-content $report  "border-right: 1px solid #999999;" 
add-content $report  "border-bottom: 1px solid #999999;" 
add-content $report  "border-left: 1px solid #999999;" 
add-content $report  "padding-top: 0px;" 
add-content $report  "padding-right: 0px;" 
add-content $report  "padding-bottom: 0px;" 
add-content $report  "padding-left: 0px;" 
add-content $report  "}" 
add-content $report  "body {" 
add-content $report  "margin-left: 5px;" 
add-content $report  "margin-top: 5px;" 
add-content $report  "margin-right: 0px;" 
add-content $report  "margin-bottom: 10px;" 
add-content $report  "" 
add-content $report  "table {" 
add-content $report  "border: thin solid #000000;" 
add-content $report  "}" 
add-content $report  "-->" 
add-content $report  "</style>" 
Add-Content $report "</head>" 
Add-Content $report "<body>" 
add-content $report  "<table width='100%'>" 
add-content $report  "<tr bgcolor='Lavender'>" 
add-content $report  "<td colspan='7' height='25' align='center'>" 
add-content $report  "<font face='tahoma' color='#003399' size='4'><strong>DAG Active Manager</strong></font>" 
add-content $report  "</td>" 
add-content $report  "</tr>" 
add-content $report  "</table>" 
add-content $report  "<table width='100%'>" 
Add-Content $report  "<tr bgcolor='IndianRed'>" 
Add-Content $report  "<td width='10%' align='center'><B>Identity</B></td>" 
Add-Content $report  "<td width='5%' align='center'><B>PrimaryActiveManager</B></td>" 
Add-Content $report  "<td width='20%' align='center'><B>OperationalMachines</B></td>" 
Add-Content $report "</tr>" 
##############################Report Template##################################
add-content $report  "<tr bgcolor='Lavender'>" 
add-content $report  "<td colspan='7' height='25' align='center'>" 
add-content $report  "<font face='tahoma' color='#003399' size='4'><strong>DAG Database Backup Status</strong></font>" 
add-content $report  "</td>" 
add-content $report  "</tr>"
add-content $report  "</tr>" 
add-content $report  "</table>" 
add-content $report  "<table width='100%'>" 
Add-Content $report "<tr bgcolor='IndianRed'>"
Add-Content $report  "<td width='10%' align='center'><B>Database</B></td>" 
Add-Content $report  "<td width='5%' align='center'><B>BackupInProgress</B></td>" 
Add-Content $report  "<td width='10%' align='center'><B>SnapshotLastFullBackup</B></td>" 
Add-Content $report  "<td width='5%' align='center'><B>SnapshotLastCopyBackup</B></td>" 
Add-Content $report  "<td width='10%' align='center'><B>LastFullBackup</B></td>" 
Add-Content $report  "<td width='5%' align='center'><B>RetainDeletedItemsUntilBackup</B></td>"
 
$dbst= Get-MailboxDatabase | where{$_.MasterType -like "DatabaseAvailabilityGroup"}

$dbst | foreach{$st=Get-MailboxDatabase $_ -status
  $dbname =  $st.Name
  $dbbkprg = $st.BackupInProgress
  $dbsnpl = $st.SnapshotLastFullBackup
  $dbsnplc= $st.SnapshotLastCopyBackup
  $dblfb = $st.LastFullBackup
  $dbrd = $st.RetainDeletedItemsUntilBackup
    Add-Content $report "<tr>" 
    Add-Content $report "<td bgcolor= 'GainsBoro' align=center>  <B>$dbname</B></td>" 
          Add-Content $report "<td bgcolor= 'GainsBoro' align=center>  <B>$dbbkprg</B></td>" 
    Add-Content $report "<td bgcolor= 'GainsBoro' align=center>  <B>$dbsnpl</B></td>" 
          Add-Content $report "<td bgcolor= 'GainsBoro' align=center>  <B>$dbsnplc</B></td>" 
  if($dblfb -lt $hrs)
  {
    Add-Content $report "<td bgcolor= 'Red' align=center>  <B>$dblfb</B></td>"
  }
  else
  {
      Add-Content $report "<td bgcolor= 'Aquamarine' align=center>  <B>$dblfb</B></td>"  
  }    	

    Add-Content $report "<td bgcolor= 'GainsBoro' align=center>  <B>$dbrd</B></td>" 
    Add-Content $report "</tr>" 


}

######################################################################################
Add-content $report  "</table>" 
Add-Content $report "</body>" 
Add-Content $report "</html>"
