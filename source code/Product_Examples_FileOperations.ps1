#Remove Header Line from CSV
#Method1
Get-Content .\abc.csv | select -skip 1 | Set-Content .\abc1.csv 

##################################################################
#Method2

$a = import .\abc.csv
$a |ForEach-Object{
  $Con_string = $null
  $Con_string = $_.ID, $_.GrpName -join ','
  Write-Host $Con_string
  Add-Content .\abc6.csv $Con_string
} 

##################################################################

#Method3 (avoid CRLF)
$text = [System.IO.File]::ReadAllText("$pwd\file.csv") -replace '^[^\r\n]*\r?\n'
[System.IO.File]::WriteAllText("$pwd\newFile.csv", $text)

##################################################################
#Method4 (avoid CRLF)
$file = Get-Item .\example_test.csv
$reader = $file.OpenText()
# discard the first line
$null = $reader.ReadLine()
# Write the rest of the text to the new file
[System.IO.File]::WriteAllText("$pwd\newFile.csv", $reader.ReadToEnd())
$reader.Close() 

##################################################################
#Add Header Line to Text File

$filep = "c:\file.txt"

$getNetworkID = Get-Content $filep | where { $_ -ne "" }
@("Employeeid") +  $getNetworkID | Set-Content  $filep -Force #add emplyeeidheader 

##################################################################

