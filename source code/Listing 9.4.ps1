$importallonedrivesites = import-csv "c:\importonedrives.csv" # onedrive file with other attributes
$importspofile = import-csv "c:\users.csv" #users email addresses

$change = Compare-Object -ReferenceObject $importallonedrivesites   -DifferenceObject $importspofile -Property owner -IncludeEqual -PassThru  #owner is the column name for users email addreses
            
$change | where{$_.SideIndicator -eq "==" -or $_.SideIndicator -eq "=>"} |
select Owner, Title, url, StorageUsageCurrent, StorageQuota, StorageQuotaWarningLevel |
          
Export-Csv "c:\newfile.csv" -NoTypeInformation 

