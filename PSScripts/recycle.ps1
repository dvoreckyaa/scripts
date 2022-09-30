[CmdletBinding()]
param(
    [string]$serverName = "",
    [string]$appPoolName = "",
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
if ([string]::IsNullOrEmpty($cred.UserName)) {
    $cred = Get-Credential
}
[string]$scriptDir = $PSScriptRoot
[string]$tempLogFile = [System.IO.Path]::GetFullPath((Join-Path -Path $scriptDir -ChildPath "recycle_$serverName_$appPoolName.log.txt"))
Start-Transcript -Path $tempLogFile
try {
    if ($appPoolName -ne "") {
        <#Output-Text  -text "Stopping App pool [$serverName\$appPoolName]..."
        Invoke-Command -Credential $cred -ComputerName $serverName -ScriptBlock { param($p1) Stop-WebAppPool -Name $p1 } -ArgumentList $appPoolName

        Output-Text  -text "Starting App pool [$serverName\$appPoolName]..."
        Invoke-Command -Credential $cred -ComputerName $serverName -ScriptBlock { param($p1) Start-WebAppPool -Name $p1 }  -ArgumentList $appPoolName
        #>
        Output-Text  -text "Restarting App pool [$serverName\$appPoolName]..."
        Invoke-Command -Credential $cred -ComputerName $serverName -ScriptBlock { param($p1) Restart-WebAppPool -Name $p1 }  -ArgumentList $appPoolName
    }
    Output-Text -text "Done!"
}
finally {
    Stop-Transcript
}

