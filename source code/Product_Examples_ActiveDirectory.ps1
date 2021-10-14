#Export Group members 
#Using Quest
Get-QADGroupMember "group Name" | select Name, Type | Export-Csv .\members.csv 

###########################################################################
#Using AD Module
Get-ADGroup -identity "group Name"  -Properties member | Select-Object -ExpandProperty member | Get-ADUser -Properties DisplayName,Samaccountname,mail,employeeid | export-csv c:\exportgroup.csv -notypeinfo 

###########################################################################
#Set values for Ad attributes
#Using Quest
Set-QADUser -identity samaccountname -ObjectAttributes @{extensionattribute10 = "IntuneCommCompleted"} 

###########################################################################
#Using AD Module
Set-ADUser -identity samaccountanme -replace @{"extensionattribute10" = "IntuneCommCompleted"} 

###########################################################################
#Export Active Directory attributes
# call excel for writing the results
$objExcel = new-object -comobject excel.application 
$workbook = $objExcel.Workbooks.Add()
$worksheet=$workbook.ActiveSheet 
$objExcel.Visible = $False # true or false to set as visible on screen or not
$cells=$worksheet.Cells
# define top level cell
$cells.item(1,1)="UserId"
$cells.item(1,2)="FirstName"
$cells.item(1,3)="LastName"
$cells.item(1,4)="Employeeid"
$cells.item(1,5)="email"
$cells.item(1,6)="Office"
$cells.item(1,7)="Department"
$cells.item(1,8)="Title"
$cells.item(1,9)="Company"
$cells.item(1,10)="City"
$cells.item(1,11)="State"
$cells.item(1,12)="Country"
#intitialize row out of the loop
$row = 2
#import quest management Shell
if ( (Get-PSSnapin -Name Quest.ActiveRoles.ADManagement -ErrorAction SilentlyContinue) -eq $null )
{
    Add-PsSnapin Quest.ActiveRoles.ADManagement 
}
$data = get-qaduser -IncludedProperties "CO", "extensionattribute1" #-sizelimit 0
#loop thru users
foreach ($i in $data){
#initialize column within the loop so that it always loop back to column 1
$col = 1
$userid=$i.Name
$FisrtName=$i.givenName
$LastName=$i.sn
$Employeeid=$i.extensionattribute1
$email=$i.PrimarySMTPAddress
$office=$i.Office
$Department=$i.Department
$Title=$i.Title
$Company=$i.Company
$City=$i.l
$state=$i.st
$Country=$i.CO
Write-host "Processing.................................$userid"
$cells.item($row,$col) = $userid
$col++
$cells.item($row,$col) = $FisrtName
$col++
$cells.item($row,$col) = $LastName
$col++
$cells.item($row,$col) = $Employeeid
$col++
$cells.item($row,$col) = $email
$col++
$cells.item($row,$col) = $office
$col++
$cells.item($row,$col) = $Department
$col++
$cells.item($row,$col) = $Title
$col++
$cells.item($row,$col) = $Company
$col++
$cells.item($row,$col) = $City
$col++
$cells.item($row,$col) = $state
$col++
$cells.item($row,$col) = $Country
$col++
$row++}
#formatting excel
$range = $objExcel.Range("A2").CurrentRegion
$range.ColumnWidth = 30
$range.Borders.Color = 0
$range.Borders.Weight = 2
$range.Interior.ColorIndex = 37
$range.Font.Bold = $false
$range.HorizontalAlignment = 3
# Headings in Bold
$cells.item(1,1).font.bold=$True
$cells.item(1,2).font.bold=$True
$cells.item(1,3).font.bold=$True
$cells.item(1,4).font.bold=$True
$cells.item(1,5).font.bold=$True
$cells.item(1,6).font.bold=$True
$cells.item(1,7).font.bold=$True
$cells.item(1,8).font.bold=$True
$cells.item(1,9).font.bold=$True
$cells.item(1,10).font.bold=$True
$cells.item(1,11).font.bold=$True
$cells.item(1,12).font.bold=$True
#save the excel file
$filepath = "c:\exportAD.xlsx" #save the excel file
$workbook.saveas($filepath)
$workbook.close()
$objExcel.Quit() 

###########################################################################
#using Active directory Module
# call excel for writing the results
$objExcel = new-object -comobject excel.application 
$workbook = $objExcel.Workbooks.Add()
$worksheet=$workbook.ActiveSheet 
$objExcel.Visible = $True # true or false to set as visible on screen or not
$cells=$worksheet.Cells
# define top level cell
$cells.item(1,1)="UserId"
$cells.item(1,2)="FirstName"
$cells.item(1,3)="LastName"
$cells.item(1,4)="Employeeid"
$cells.item(1,5)="email"
$cells.item(1,6)="Office"
$cells.item(1,7)="Department"
$cells.item(1,8)="Title"
$cells.item(1,9)="Company"
$cells.item(1,10)="City"
$cells.item(1,11)="State"
$cells.item(1,12)="Country"
#intitialize row out of the loop
$row = 2
#import AD management Shell
Import-module Activedirectory
$data = Get-ADUser -Filter {Enabled -eq $True} -Properties extensionattribute1,mail,physicalDeliveryOfficeName,Department,title,Company,l,st,co -ResultSetSize 1000 #define the size
#loop thru users
foreach ($i in $data){
#initialize column within the loop so that it always loop back to column 1
$col = 1
$userid=$i.Name
$FisrtName=$i.givenName
$LastName=$i.surname
$Employeeid=$i.extensionattribute1
$email=$i.mail
$office=$i.physicalDeliveryOfficeName
$Department=$i.Department
$Title=$i.Title
$Company=$i.Company
$City=$i.l
$state=$i.st
$Country=$i.CO
Write-host "Processing.................................$userid"
$cells.item($row,$col) = $userid
$col++
$cells.item($row,$col) = $FisrtName
$col++
$cells.item($row,$col) = $LastName
$col++
$cells.item($row,$col) = $Employeeid
$col++
$cells.item($row,$col) = $email
$col++
$cells.item($row,$col) = $office
$col++
$cells.item($row,$col) = $Department
$col++
$cells.item($row,$col) = $Title
$col++
$cells.item($row,$col) = $Company
$col++
$cells.item($row,$col) = $City
$col++
$cells.item($row,$col) = $state
$col++
$cells.item($row,$col) = $Country
$col++
$row++}
#formatting excel
$range = $objExcel.Range("A2").CurrentRegion
$range.ColumnWidth = 30
$range.Borders.Color = 0
$range.Borders.Weight = 2
$range.Interior.ColorIndex = 37
$range.Font.Bold = $false
$range.HorizontalAlignment = 3
# Headings in Bold
$cells.item(1,1).font.bold=$True
$cells.item(1,2).font.bold=$True
$cells.item(1,3).font.bold=$True
$cells.item(1,4).font.bold=$True
$cells.item(1,5).font.bold=$True
$cells.item(1,6).font.bold=$True
$cells.item(1,7).font.bold=$True
$cells.item(1,8).font.bold=$True
$cells.item(1,9).font.bold=$True
$cells.item(1,10).font.bold=$True
$cells.item(1,11).font.bold=$True
$cells.item(1,12).font.bold=$True
#save the excel file
$filepath = "c:\exportAD.xlsx" #save the excel file
$workbook.saveas($filepath)
$workbook.close()
$objExcel.Quit()

###########################################################################
#Add members to the group from text file
#Using Quest management Shell you can use below syntax
$users = Get-Content C:\Users.txt   # samccountnames of users in text file
$groupname = "Group Name"
$users | ForEach-Object{
$user = $_
Write-host "adding $user to $groupname" -foregroundcolor green
Add-QADGroupMember -Identity $groupname -Member $user
}

###########################################################################
#using Active directory module

$users = Get-Content C:\Users.txt    # samccountnames of users in text file
$groupname = "Group Name"
$users | ForEach-Object{
$user = $_
Write-host "adding $user to $groupname" -foregroundcolor green
Add-ADGroupMember -id $groupname -members $user
} 

###########################################################################
#Remove members to the group from text file
#Using Quest management Shell you can use below syntax
$users = Get-Content C:\Users.txt   # samccountnames of users in text file
$groupname = "Group Name"
$users | ForEach-Object{
$user = $_
Write-host "adding $user to $groupname" -foregroundcolor green
Remove-QADGroupMember -Identity $groupname -Member $user -confirm:$false
} 

###########################################################################
#Using Active directory module

$users = Get-Content C:\Users.txt    # samccountnames of users in text file
$groupname = "Group Name"
$users | ForEach-Object{
$user = $_
Write-host "adding $user to $groupname" -foregroundcolor green
Remove-ADGroupMember -id $groupname -members $user -confirm:$false
} 

###########################################################################
