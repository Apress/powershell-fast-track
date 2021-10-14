function Send-Email
{
  [CmdletBinding()]
  param
  (
    [Parameter(Mandatory = $true)]
    $From,
    [Parameter(Mandatory = $true)]
    [array]$To,
    [array]$bcc,
    [array]$cc,
    $body,
    $subject,
    $attachment,
    [Parameter(Mandatory = $true)]
    $smtpserver
  )
	
  $message = New-Object System.Net.Mail.MailMessage
  $message.From = $From
  if ($To -ne $null)
  {
    $To | ForEach-Object{
      $to1 = $_
      $to1
      $message.To.Add($to1)
    }
  }
  if ($cc -ne $null)
  {
    $cc | ForEach-Object{
      $cc1 = $_
      $cc1
      $message.CC.Add($cc1)
    }
  }
  if ($bcc -ne $null)
  {
    $bcc | ForEach-Object{
      $bcc1 = $_
      $bcc1
      $message.bcc.Add($bcc1)
    }
  }
  $message.IsBodyHtml = $true
  if ($subject -ne $null)
  {$message.Subject = $subject}
  if ($attachment -ne $null)
  {
    $attach = New-Object Net.Mail.Attachment($attachment)
    $message.Attachments.Add($attach)
  }
  if ($body -ne $null)
  {$message.body = $body}
  $smtp = New-Object Net.Mail.SmtpClient($smtpserver)
  $smtp.Send($message)
} # Send-Email