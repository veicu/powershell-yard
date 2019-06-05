#===================================================================================================
#
# process excel with powershell
#
#===================================================================================================

#
#
#

Set-StrictMode -Version Latest

#
#
#

$excel_file = Get-Item -path ".\test.xlsx"

Write-Host "Read excel file"

#---------------------------------------------------------------------------------------------------
# open excel
#---------------------------------------------------------------------------------------------------

$Excel = New-Object -ComObject Excel.Application

$Excel.Visible        = $False
$Excel.DisplayAlerts  = $False
$Excel.ScreenUpdating = $False

$Workbooks   = $Excel.Workbooks
$Workbook    = $Workbooks.Open( $excel_file.fullname )
$Worksheets  = $Workbook.Worksheets
$Worksheet   = $Worksheets.Item(1)

$Cells       = $Worksheet.Cells
$UsedRange   = $Worksheet.UsedRange

$Rows        = $UsedRange.Rows    # all used rows
$RowCount    = $Rows.Count        # set count now for performance reasons
$Columns     = $UsedRange.Columns # all used columns
$ColumnCount = $Columns.Count     # set count now for performance reasons

#---------------------------------------------------------------------------------------------------


write-host
write-host "ROWCOUNT   : $RowCount"
write-host "COLUMNCOUNT: $ColumnCount"
write-host

#
# get desired cells
#

$DataCells = $Cells.Range( "A1:D1000" )
$DataCells.getType()

#
# get all values as array[n,m]
# Value2 applied on a range of cell does the trick
#

$values = $DataCells.Value2
$values.getType()


<#
for($r = 0; $r -le 100; $r++)
{
    $values[$r,1]
    $values[$r,2]
    $values[$r,3]
    $values[$r,4]
}
#>


#---------------------------------------------------------------------------------------------------
# close excel and release COM-Objects
#---------------------------------------------------------------------------------------------------

do { $o = [System.Runtime.InteropServices.Marshal]::ReleaseComObject($DataCells) }  while( $o -gt -1 )

do { $o = [System.Runtime.InteropServices.Marshal]::ReleaseComObject($Columns) }    while( $o -gt -1 )
do { $o = [System.Runtime.InteropServices.Marshal]::ReleaseComObject($Rows) }       while( $o -gt -1 )
do { $o = [System.Runtime.InteropServices.Marshal]::ReleaseComObject($UsedRange) }  while( $o -gt -1 )
do { $o = [System.Runtime.InteropServices.Marshal]::ReleaseComObject($Cells) }      while( $o -gt -1 )
do { $o = [System.Runtime.InteropServices.Marshal]::ReleaseComObject($Worksheet) }  while( $o -gt -1 )
do { $o = [System.Runtime.InteropServices.Marshal]::ReleaseComObject($Worksheets) } while( $o -gt -1 )

$Workbook.Close($false) # do not save changes

do { $o = [System.Runtime.InteropServices.Marshal]::ReleaseComObject($Workbook) }   while( $o -gt -1 )
do { $o = [System.Runtime.InteropServices.Marshal]::ReleaseComObject($Workbooks) }  while( $o -gt -1 )

$Excel.Quit()

do { $o = [System.Runtime.InteropServices.Marshal]::ReleaseComObject($Excel) }      while( $o -gt -1 )

#---------------------------------------------------------------------------------------------------
