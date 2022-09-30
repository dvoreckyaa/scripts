[CmdletBinding()]
param(
    [string]$base64FilePath = "$PSScriptRoot\input.txt",
    [string]$outputFile = "$PSScriptRoot\Extensibility.CSF.Australia.dll"
)
 
# Encode
 
#$file = [System.IO.File]::ReadAllBytes($base64FilePath);
$file = Get-Content -Path $base64FilePath 

# returns the base64 string
#$base64String = [System.Convert]::ToBase64String($File);
$base64String = $file.Trim()

# Decode
 
function Convert-StringToBinary {
    [CmdletBinding()]
    param (
        [string] $encodedString,
        [string] $filePath = (‘{0}\{1}’ -f $env:TEMP, [System.Guid]::NewGuid().ToString())
    )
 
    if ($encodedString.Length -ge 1) {
 
        # decodes the base64 string
        $ByteArray = [System.Convert]::FromBase64String($encodedString);
        [System.IO.File]::WriteAllBytes($filePath, $ByteArray);
    }    
 
    Write-Output -InputObject (Get-Item -Path $filePath);
}
 
Convert-StringToBinary -EncodedString $base64String -FilePath $outputFile
