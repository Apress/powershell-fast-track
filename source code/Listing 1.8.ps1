$x= 0

Do {$x++  
if($x -lt 2){write-host "$x is Green" -foregroundcolor Green
              } 
  	else{ write-host "$x is yellow" -foregroundcolor yellow
} 
 }while($x -ne 4)
