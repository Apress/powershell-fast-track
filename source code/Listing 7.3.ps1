$from = "donotreply@lab.com"
$to="vikas@lab.com"
$subject = "Error has occured"
$smtpServer="smtp.lab.com"

if ($error)
      {
  Send-Email -smtpserver $smtpServer -From $from -To $to -subject $subject -body $error
  $error.clear()
       }
