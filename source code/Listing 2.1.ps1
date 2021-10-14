$date = get-date -format d # formatting
$date = $date.ToString().Replace("/", "-")  # replace / with - 
$time = get-date -format t    # only show time
$time = $time.ToString().Replace(":", "-") # replace : with - 
$time = $time.ToString().Replace(" ", "")

$m = get-date 
$month = $m.month  #getting month
$year = $m.year  #getting year

#based on date
$log1 = ".\Processed\Logs" + "\" + "skipcsv_" + $date + "_.log" 

#based on month and year
$log2 = ".\Processed\Logs" + "\" + "Created_" + $month +"_" + $year +"_.log"

#based on date and time
$output1 = ".\" + "G_Testlog_" + $date + "_" + $time + "_.csv"

#print on screen
$log1
$log2
$output1
