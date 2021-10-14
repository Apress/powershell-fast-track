$smtpserver = "smtp.lab.com"
$to = "sukhija@techwizard.cloud"
$from = "DonotReply@labtest.com"
$subject = "Test Subject"

$message = @"
Hello,

Line............................1

Line............................2

Line............................3

"@

Send-MailMessage -SmtpServer $smtpserver -From $from -To $to -Subject $subject -Body $message