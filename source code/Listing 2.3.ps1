$Dname = ((get-date).AddDays(0).toString('yyyyMMdd')) #date manipulation  
$dirName = "ConfigBackup_$Dname"  #prefix for the folder

New-Item -Path c:\temp -Name $dirName -ItemType directory #creating folder
