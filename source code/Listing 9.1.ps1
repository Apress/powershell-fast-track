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

 $Addition = $change |
 Where-Object -FilterScript {$_.SideIndicator -eq "<="} |
 Select-Object -ExpandProperty InputObject

#######adding only members that are missing in group2########
 $Addition | ForEach-Object{
      $sam = $_
      Add-ADGroupMember -identity "group2" -Members $sam
 } 
##############################################################
