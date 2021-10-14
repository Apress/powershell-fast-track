$overwrite = New-Object -comobject wscript.shell  

$Answer = $overwrite.popup("Do you want to Overwrite AD Attributes?",0,"Overwrite Attributes",4) 

If ($Answer -eq 6) {Write-Host "you pressed Yes" -ForegroundColor Green}
else{Write-Host "you pressed Yes" -ForegroundColor Red}
