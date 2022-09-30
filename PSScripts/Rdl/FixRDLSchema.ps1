[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)][string]$rdlFileNameParam
)
$ErrorActionPreference = "Stop"
[string]$rdlFileName = Resolve-Path $rdlFileNameParam
if (-Not(Test-Path $rdlFileName)) {
    Write-Host "File does not exist $rdlFileName"
    exit
}

[string]$newSchema = 'http://schemas.microsoft.com/sqlserver/reporting/2008/01/reportdefinition'
$updated = $false

[System.Xml.XmlDocument] $document = New-Object System.Xml.XmlDocument
$document.load($rdlFileName)
[string]$currentSchema = $document.SelectSingleNode("//*[local-name()='Report']").GetAttribute('xmlns')
Write-Host "Current schema: $currentSchema"
if ($currentSchema -eq $newSchema) {
    Write-Host "The schema does not need to be updated"  
    #exit  
}
else {
    Write-Host "New schema: $newSchema"
    $document.SelectSingleNode("//*[local-name()='Report']").SetAttribute('xmlns', $newSchema)
    $updated = $true
}

$reportParametersLayoutNode = $document.SelectSingleNode("//*[local-name()='ReportParametersLayout']")
if ($null -ne $reportParametersLayoutNode) {
    $updated = $true
    Write-Host "Found <ReportParametersLayout>"  
    $reportParametersLayoutNode.ParentNode.RemoveChild($reportParametersLayoutNode)
}

$reportSectionsNode = $document.SelectSingleNode("//*[local-name()='ReportSections']")
if ($null -ne $reportSectionsNode) {
    $updated = $true
    Write-Host "Found <ReportSections>"  
    if ($null -ne $reportSectionsNode.FirstChild) {
        Write-Host "Found <ReportSection>"  
        #$reportSectionsNode.ParentNode.ReplaceChild($reportSectionsNode.FirstChild, $reportSectionsNode)
        $elemArray = New-Object System.Collections.ArrayList
        foreach ($node in $reportSectionsNode.FirstChild.ChildNodes) {
            $elemArray.Add($node);
        }
  
        for ($i = $elemArray.Count - 1; $i -ge 0; $i--) { 
            $reportSectionsNode.ParentNode.InsertAfter($elemArray[$i], $reportSectionsNode) 
        }      
    }
    $reportSectionsNode.ParentNode.RemoveChild($reportSectionsNode)
}

if ($updated) {
    $bakFileName = [IO.Path]::ChangeExtension($rdlFileName, ".bak.rdl")
    Write-Host "Bak-file: $rdlFileName"
    Rename-Item $rdlFileName -NewName $bakFileName
    $document.Save($rdlFileName)
}
Write-Host "Done!"


