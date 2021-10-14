$x=@("1","2","3",,"4")

$x | foreach-object{
  	if ($_ -lt 2) { write-host "$_ is Green" -foregroundcolor Green
} 
  	else{ write-host "$_ is yellow" -foregroundcolor yellow
} 
     }
