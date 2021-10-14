Import-Module vsadmin

$log = Write-Log -Name "log_file" -folder logs -Ext log

Write-Log -Message "Information..........Script" -path $log  #default  will log as information
Write-Log -Message "warning.........Message" -path $log -Severity Warning #you can display warning using the severity
Write-Log -Message "error.........Error" -path $log -Severity error #you can display error using the severity