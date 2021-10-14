$servers = @("server01","server02","server03","server04") #array of servers

$servers | foreach-object {
Write-host $_ -foregroundcolor yellow
}
 
