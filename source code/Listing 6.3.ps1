$smtpserver = "smtp.lab.com"
$to = "sukhija@techwizard.cloud"
$from = "DonotReply@labtest.com"
$subject = "Test Subject"

$message = @"
<!-- #######  YAY, I AM THE SOURCE EDITOR! #########-->
<h1 style="color: #5e9ca0;">You can edit <span style="color: #2b2301;">this demo</span> text!</h1>
<h2 style="color: #2e6c80;">How to use the editor:</h2>
<p>Paste your documents in the visual editor on the left or your HTML code in the source editor in the right. <br />Edit any of the two areas and see the other changing in real time.&nbsp;</p>
<p>&nbsp;</p>
"@

Send-MailMessage -SmtpServer $smtpserver -From $from -To $to -Subject $subject -Body $message -BodyAsHtml