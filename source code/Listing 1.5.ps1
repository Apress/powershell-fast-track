$x=@("1","2","3",,"4")

foreach ($i in $x) {
if ($i -lt 2) { write-host "$i is Green" -foregroundcolor Green
} 
  	else{ write-host "$i is yellow" -foregroundcolor yellow
      } 
 }
