$smtpserver = "smtp.lab.com"
$to = "sukhija@techwizard.cloud"
$from = "DonotReply@labtest.com"
$file = "c:\file.txt" #for attachment
$subject = "Test Subject"

$message = new-object Net.Mail.MailMessage
$smtp = new-object Net.Mail.SmtpClient($smtpserver)
$message.From = $from
$message.To.Add($to)

$att = new-object Net.Mail.Attachment($file)
$message.IsBodyHtml = $False
$message.Subject = $subject 
$message.Attachments.Add($att)
$smtp.Send($message)
