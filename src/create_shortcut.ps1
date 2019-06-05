#===================================================================================================
#
# create shortcut (.lnk) to target file
#
#===================================================================================================

#
#
#

Set-StrictMode -Version Latest

#
#
#

function Create-Shortcut
{
    Param
    (
        [Parameter( Mandatory=$true,  Position=0 )]
        [string] $ShortcutFilePath,
        [Parameter( Mandatory=$true,  Position=1 )]
        [string] $TargetFilePath,
        [Parameter( Mandatory=$false, Position=2 )]
        [string] $Arguments = "",
        [Parameter( Mandatory=$false, Position=3 )]
        [string] $WorkingDirectory = "",
        [Parameter( Mandatory=$false, Position=4 )]
        [string] $IconLocation = ""
    )

    if( -not ( $ShortcutFilePath -match '\.lnk$' ) )
    {
        $error_msg = 'Shortcut file path must end with .lnk ' + $ShortcutFilePath
        throw $error_msg
    }

    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut($ShortcutFilePath)
    $Shortcut.TargetPath = $TargetFilePath

    if( $Arguments -ne "" )
    {
        $Shortcut.Arguments = $Arguments
    }

    if( $WorkingDirectory -ne "" )
    {
        $Shortcut.WorkingDirectory = $WorkingDirectory
    }

    if( $IconLocation -ne "" )
    {
        $Shortcut.IconLocation = $IconLocation
    }
    else
    {
        $Shortcut.IconLocation = "C:\Windows\system32\shell32.dll, 17"
    }

    try
    {
        Write-Host "SAVE" -foregroundcolor green
        $Shortcut.Save()
    }
    catch
    {
        Write-Verbose "Cannot create the shortcut $ShortcutFilePath" -Verbose
        Write-Verbose $Error[0].Exception.Message -Verbose
        Return $False
    }
}

#
#
#

Create-Shortcut -ShortcutFilePath "C:\Temp\edit.lnk" -TargetFilePath "C:\Tools\Notepad++\notepad++.exe"
