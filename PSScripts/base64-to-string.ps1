[CmdletBinding()]
param(
    [Parameter(Mandatory = $True, HelpMessage = "inpute base64 string")]
    [string]$base64 
)
[byte[]]$bytes = [System.Convert]::FromBase64String($base64)
#Write-Host -BackgroundColor yellow -ForegroundColor black $bytes
[string]$outputStr = ''
$bytes | ForEach-Object {
    $outputStr += $_.ToString('X2')
}
Write-Host -BackgroundColor yellow -ForegroundColor black $outputStr
pause