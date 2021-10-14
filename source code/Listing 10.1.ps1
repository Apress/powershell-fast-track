<#	
    .NOTES
    ===========================================================================
    Created with: 	ISE
    Created on:   	9/6/2021 1:46 PM
    Created by:   	Vikas Sukhija
    Organization: 	
    Filename:     	ADDUserstoGroupfromText.ps1 
    ===========================================================================
    .DESCRIPTION
    This will add the users from text file to AD group
#>
###############Import modules and functions#####################
import-module vsadmin
import-module Activedirectory

##############Add logs and variables############################
$log = Write-Log -Name "ADDUser2Group-Log" -folder "logs" -Ext "log"
$users = get-content "c:\temp\users.txt"

$Adgroup = "ADgroup1"

$logrecyclelimit = "60" #to recycle the logs after 60 days
################################################################
Write-Log -Message "Start...............script" -path $log 

$users | foreach-object{
  $user = $_.trim() #triming fro any whitespace
  Write-Log -Message "Processing..........$user" -path $log
  $getusermemberof = Get-ADUserMemberOf -User $user -Group $Adgroup #checking if user si already member
  if($getusermemberof -eq $true){ #if users is already mebe rjust write it to log
    Write-Log -Message "$user is already member of $Adgroup" -path $log
  }
  else{
    Write-Log -Message "ADD $user to $Adgroup" -path $log
    Add-ADGroupMember -identity $Adgroup -members $user
    if($error){ #error checking, if error occurs add in log
      Write-Log -Message "Error - ADD $user to $Adgroup" -path $log
      $error.clear() # clearing the error as it has already been captuire for this iteration
    }
    else{
      Write-Log -Message "Success - ADD $user to $Adgroup" -path $log
    }
  }
}
#####################Recycle logs#############################
Set-Recyclelogs -foldername "logs" -limit $logrecyclelimit -Confirm:$false

Write-Log -Message "Script Finished" -path $log
