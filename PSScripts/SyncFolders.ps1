[CmdletBinding()]
Param (
    [parameter(Mandatory = $true)][string]$leftFolder,
    [parameter(Mandatory = $true)][string]$rightFolder
)

# \\mos-csf-admin\d\EpicorCSF\Databases\ERPCurrent servers\MOS-CSF-CC-1\ERP10Dev
# \\mos-devfile01\Databases\ERPCurrent servers\MOS-CSF-CC-1\ERP10Dev

#. '\\mos-csf-admin\epicor.scm\scripts\lib\SCM.ps1'

function Write-Log([string]$message) {
    #if (Get-Command "Write-SCMTaskStatusLog" -errorAction SilentlyContinue) {
    #    Write-SCMTaskStatusLog $message
    #}
    #else {
    Write-Host $message
    #}
}

function SyncFolders([string]$fldrL, [string]$fldrR) {
    Write-Log "Preparing to copy $($fldrL) to $($fldrR)"
    #$leftItems = Get-ChildItem -Recurse -Path $fldrL
    #$rightItems = Get-ChildItem -Recurse -Path $fldrR
    [object[]]$leftItems = Get-ChildItem -Path $fldrL -File
    [object[]]$rightItems = Get-ChildItem -Path $fldrR -File

    if ($rightItems.Count -eq 0) {
        $rightItems = @()
    }

    if ($leftItems.Count -eq 0) {
        $rightItems = @()
    }

    Write-Log "Source Folder: $leftItems"
    Write-Log "Destination Folder: $rightItems"

    foreach ($rightItem in $rightItems) {
        if (($leftItems | Where-Object { $_.Name.ToUpper() -eq $rightItem.Name.ToUpper() } ).Count -eq 0) {
            Write-Host "Deleting $($rightItem.Name)"
            Remove-Item $rightItem.FullName
        }
    }

    foreach ($leftItem in $leftItems) {
        if (($rightItems | Where-Object { $_.Name.ToUpper() -eq $leftItem.Name.ToUpper() } ).Count -eq 0) {
            $destFile = Join-Path -Path $rightFolder -ChildPath $leftItem.Name
            Write-Log "Copying $($leftItem.Name) to $($destFile)"
            Copy-Item -Path $leftItem.FullName -Destination $destFile
        }
    }
    
    Write-Log "Done!"
}

SyncFolders -fldrL (Get-Item -Path $leftFolder).FullName -fldrR (Get-Item -Path $rightFolder).FullName

