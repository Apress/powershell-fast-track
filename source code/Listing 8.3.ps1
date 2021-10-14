Function Save-CSV2Excel
{
  [CmdletBinding()]
  Param(
    [Parameter(Mandatory = $true,Position = 1)]
    [ValidateScript({
          if(-Not ($_ | Test-Path) ){throw "File or folder does not exist"}
          if(-Not ($_ | Test-Path -PathType Leaf) ){throw "The Path argument must be a file. Folder paths are not allowed."}
          if($_ -notmatch "(\.csv)"){throw "The file specified in the path argument must be either of type csv"}
          return $true 
    })]
    [System.IO.FileInfo]$CSVPath,
	
    [Parameter(Mandatory = $true)]
    [ValidateScript({
          if($_ -notmatch "(\.xlsx)"){throw "The file specified in the path argument must be either of type xlsx"}
          return $true 
    })]
    [System.IO.FileInfo]$Exceloutputpath
  )
  ####### Borrowed function from Lloyd Watkinson from script gallery##
  Function Convert-NumberToA1 
  { 
    Param([parameter(Mandatory = $true)] 
    [int]$number) 
   
    $a1Value = $null 
    While ($number -gt 0) 
    { 
      $multiplier = [int][system.math]::Floor(($number / 26)) 
      $charNumber = $number - ($multiplier * 26) 
      If ($charNumber -eq 0) { $multiplier-- ; $charNumber = 26 } 
      $a1Value = [char]($charNumber + 64) + $a1Value 
      $number = $multiplier 
    } 
    Return $a1Value 
  }
  #############################Start converting excel#######################

  $importcsv = Import-Csv $CSVPath
  $countcolumns = ($importcsv |
    Get-Member |
  Where-Object{$_.membertype -eq "Noteproperty"}).count


  #################call Excel com object ##############

  $xl = New-Object -comobject excel.application
  $xl.visible = $false
  $Workbook = $xl.workbooks.open($CSVPath)
  $Workbook.SaveAs($Exceloutputpath, 51)
  $Workbook.Saved = $true
  $xl.Quit()

  #############Now format the Excel###################
  timeout.exe 10
  $xl = New-Object -comobject excel.application
  $xl.visible = $false
  $Workbook = $xl.workbooks.open($Exceloutputpath)
  $worksheet1 = $Workbook.worksheets.Item(1)
  for ($c = 1; $c -le $countcolumns; $c++) {$worksheet1.Cells.Item(1, $c).Interior.ColorIndex = 39}
  $colvalue = (Convert-NumberToA1 $countcolumns) + "1"
  $headerRange = $worksheet1.Range("a1", $colvalue)
  $null = $headerRange.AutoFilter()
  $null = $headerRange.entirecolumn.AutoFit()
  $worksheet1.rows.item(1).Font.Bold = $true
  $Workbook.Save()
  $Workbook.Close()
  $xl.Quit()
  $Null = [System.Runtime.Interopservices.Marshal]::ReleaseComObject($xl)
  #######################################################################
}#Write-CSV2Excel