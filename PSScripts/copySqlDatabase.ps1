[CmdletBinding()]
param(
    [string]$remoteServerName = "",
    [string]$remoteDatabase = "",
    [string]$localServerName = "(local)",
    [string]$localDatabase = "",
    [string]$localAppPoolName = "",
    [string]$bakupServerName = "",
    #[string]$bakupServerName = "",
    [PSCredential]$cred
)
$ErrorActionPreference = "Stop"
function Output-Text {
    param( [string]$text, 
        [bool]$isError = $False)
    if ($isError) {
        Write-Host -BackgroundColor red -ForegroundColor black $text
    }
    else {
        Write-Host -BackgroundColor yellow -ForegroundColor black $text
    }
}

[string]$bakFolder = "\\10.43.20.81\exchange$\"
[string]$bakFileName
[bool]$needsBackup

if ($bakupServerName -ne "") {
    $needsBackup = $false
    [string]$sourceBakFolder = "\\*\*"
    $sourceBakFileName = Get-ChildItem -Path $sourceBakFolder -Include "*.bak" | Sort-Object -Property "Name" | Select-Object -First 1
    $bakFileName = $sourceBakFileName.Name
    Copy-Item $sourceBakFileName.FullName -Destination $bakFolder
}
else {
    $needsBackup = $true
    $bakFileName = "$remoteServerName.$remoteDatabase.bak"
    [int]$idx = 1
    while (Test-Path "$bakFolder\$($bakFileName)") {
        $bakFileName = "$($remoteServerName)_$($remoteDatabase)_$($idx).bak"
        $idx++
    }
}

[string]$localBakFileName = "D:\exchange\$bakFileName"
[string]$dbFilePath = "$bakFolder\$($bakFileName)"
[string]$sqlUserName = 'sa'
[string]$sqlPass = 'Epicor123'
[string]$scriptDir = $PSScriptRoot
[string]$tempLogFile = [System.IO.Path]::GetFullPath((Join-Path -Path $scriptDir -ChildPath "copyDataBase_$remoteServerName_$appPoolName.log.txt"))

Start-Transcript -Path $tempLogFile
try {
    if ($needsBackup) {
        Output-Text  -text "Backuping..." 
        $backupQuery = "BACKUP DATABASE $remoteDatabase TO DISK = '$dbFilePath'"
        Invoke-SqlCmd -ServerInstance $remoteServerName -U $sqlUserName -P $sqlPass  -Database $remoteDatabase -Query $backupQuery 
        Output-Text -text "Backup completed '$dbFilePath'"
    }
    Output-Text  -text "Restoring..." 
    $restoreQuery = @"

DECLARE @dbExists AS BIT = (SELECT CASE WHEN EXISTS(SELECT name FROM master.dbo.sysdatabases WHERE ('[' + name + ']' = '$localDatabase' OR name = '$localDatabase')) THEN 1 ELSE 0 END)

USE [master]
IF @dbExists = 1
BEGIN
    ALTER DATABASE [$localDatabase]  SET SINGLE_USER WITH ROLLBACK IMMEDIATE
END

RESTORE DATABASE [$localDatabase] 
FROM DISK = N'$localBakFileName' 
WITH FILE = 1,  
     NOUNLOAD, REPLACE, STATS = 5

IF @dbExists = 1
BEGIN
    ALTER DATABASE [$localDatabase]  SET MULTI_USER
END
"@
    #Invoke-SqlCmd -ServerInstance $localServerName -U $sqlUserName -P $sqlPass  -Database 'master' -Query $restoreQuery 
    #Invoke-SqlCmd -ServerInstance $localServerName -U $sqlUserName -P $sqlPass  -Database $localDatabase -Query "***" 
    Output-Text -text "Done!"
}
finally {
    Stop-Transcript
}

