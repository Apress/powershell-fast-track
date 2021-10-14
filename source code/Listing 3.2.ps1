$servers = Get-content .\servers.txt

$servers | foreach-object {
Write-host $_
}
