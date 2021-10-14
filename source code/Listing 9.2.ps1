##########################fetching group1 ##################
 $collgroup1 = Get-ADGroup -id "group1" -Properties member |
  Select-Object -ExpandProperty member |
  Get-ADUser |
  Select-Object -ExpandProperty samaccountname

 ##########################fetching group2 ##################
 $collgroup2 = Get-ADGroup -id "group2" -Properties member |
  Select-Object -ExpandProperty member |
  Get-ADUser |
  Select-Object -ExpandProperty samaccountname

 ####################compare two groups####################
 $change = Compare-Object -ReferenceObject $collgroup1 -DifferenceObject $collgroup2

 $Removal = $change |
 Where-Object -FilterScript {$_.SideIndicator -eq "=>"} |
 Select-Object -ExpandProperty InputObject

####Removing members that are in group2 but not in group1########
 $Removal | ForEach-Object{
      $sam = $_
      Remove-ADGroupMember -identity "group2" -Members $sam -confirm:$false
 } 
##############################################################