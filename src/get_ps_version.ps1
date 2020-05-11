#===================================================================================================
#
# get powershell version
#
# https://stackoverflow.com/questions/1825585/determine-installed-powershell-version
#
#===================================================================================================

#
#
#

Set-StrictMode -Version Latest

#
# get powershell version
#

function get-ps-version
{
    if( Test-Path variable:global:PSVersionTable )
    {
        # PowerShell V1+
        return $PSVersionTable.PSVersion
    }
    else
    {
        # PowerShell V1
        return [version]"1.0.0.0"
    }
}

#
#
#

Write-Host "POWERSHELL VERSION : $(get-ps-version)"
