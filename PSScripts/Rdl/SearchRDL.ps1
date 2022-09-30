$fieldArray = @("ChiefAcctName","ManagerName","OrgRegCode","TaxRegReason")
 
foreach ($field in $fieldArray){
    Write-Host "$field :"
    Get-ChildItem C:\_projects\ERP10CC\Current *.rdl -recurse | 
    % { 
        [System.Xml.XmlDocument]$file = new-object System.Xml.XmlDocument
        $file.load($_.fullname)
        foreach ($ds in $file.Report.DataSets.DataSet) {
        [string]$command=$ds["Query"]["CommandText"].InnerText
        if($command.ToLower().Contains('rptlabels') -and $command.ToLower().Contains($field.ToLower()))
        {
          Write-Host $_.fullname
        }
       }
    }
}
Write-Host "Done!"