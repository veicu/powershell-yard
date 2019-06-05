#===================================================================================================
#
# get path of this script file
#
#===================================================================================================

#
#
#

Set-StrictMode -Version Latest

#
#
#

if( test-path variable:global:PSScriptRoot )
{
    write-host -ForegroundColor Green 'PowerShell V3+'
    $script_path = $PSScriptRoot
}
else
{
    write-host -ForegroundColor Green 'PowerShell V2'
    $script_path = split-path -path $MyInvocation.MyCommand.Definition -parent
}

#
#
#

write-host 'SCRIPT PATH :' $script_path
