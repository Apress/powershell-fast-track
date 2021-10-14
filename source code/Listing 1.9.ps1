$x= 0

while($x -ne 4) {$x++  
if($x -lt 2){write-host "$x is Green" -foregroundcolor Green
} 
else{ write-host "$x is yellow" -foregroundcolor yellow
}
}
