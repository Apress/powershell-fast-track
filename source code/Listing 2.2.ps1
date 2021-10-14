$date= Get-Date -Day 01
$lastday = ((Get-Date -day 01).AddMonths(1)).AddDays(-1)

$start = $date
$end  = $lastday

#print
$start
$end