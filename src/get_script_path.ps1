#===================================================================================================
#
# get path of this script file
#
# https://stackoverflow.com/questions/5466329/whats-the-best-way-to-determine-the-location-of-the-current-powershell-script
#
#===================================================================================================

#
#
#

Set-StrictMode -Version Latest

#
# get path of this script
#

function get-script-path
{
    if( Test-Path variable:global:PSScriptRoot )
    {
        # PowerShell V3+
        return $PSScriptRoot
    }
    else
    {
        # PowerShell V2
        return Split-Path -Path $script:MyInvocation.MyCommand.Path -Parent
    }
}

#
#
#

Write-Host "SCRIPT PATH : $(get-script-path)"
