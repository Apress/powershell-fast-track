#Adding Users to AzureADgroup from text file of UPN
$group1 = "93345231-7454-4629-943b-e4245426bf" #
Get-Content C:\users.txt | ForEach-Object{$user=$_.trim();$user;$upn= $user
$getazureaduser = Get-AzureADUser -Filter "userprincipalname eq '$($upn)'"
 Add-AzureADGroupMember -ObjectId $group1  -RefObjectId $getazureaduser.ObjectId
}

##################################################################
#Removing Users to AzureADgroup from text file of UPN

$group1 = "93345231-7454-4629-943b-e4245426bf" #
Get-Content C:\users.txt | ForEach-Object{$user=$_.trim();$user;$upn= $user
$getazureaduser = Get-AzureADUser -Filter "userprincipalname eq '$($upn)'"
Remove-AzureADGroupMember -ObjectId $group1  -MemberId $getazureaduser.ObjectId
}

##################################################################
#Check if user is Already member of group
$group1 = "93345231-7454-4629-943b-e4245426bf" #
$getazmembership = Get-AzureADUserMembership  -ObjectId “UserObjectId”
if($getazmembership.objectId -contains $group1){
write-host  “User is already member of the group group1”
}

##################################################################
#ADD Administrators to Role
Get-MsolRole | Sort Name | Select Name,Description #check role name
$roleName = "Lync Service Administrator"
Get-content c:\users.txt | foreach-object{$_;
Add-MsolRoleMember -RoleMemberEmailAddress $_ -RoleName $roleName
}

##################################################################
#Checking for AzureAD user provisioning errors

Get-MsolUser -HasErrorsOnly | ft DisplayName,UserPrincipalName,@{Name="Error";Expression={($_.errors[0].ErrorDetail.objecterrors.errorrecord.ErrorDescription)}} -AutoSize

##################################################################