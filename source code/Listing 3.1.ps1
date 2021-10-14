$data = import-csv c:\temp\samplecsv.csv    #Import CSV in variable data

foreach ($i in $data) {
Write-host  $i.user -foregroundcolor green #printing column user
Write-host  $i.email -foregroundcolor blue #printing column email
Write-host  $i.title -foregroundcolor magenta #printing column title
         }
