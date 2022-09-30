param(
      [string]$TemplateParams="TemplateParams.xml"
    , [string]$TemplateFile="HelperTemplate.cs"
    )

function formatText(){
  param([xml]$xml,[string]$text)
  [string]$result = $text
  $nodes = $xml.SelectNodes("/Template/Params/*")
  foreach ($node in $nodes) {
    $name = $node.get_Name()
    $value = $node.'#text'
    $result = $result.Replace("$"+$name+"$",$value)
  }
  return $result
}

$xml = [xml](Get-Content -Path "$TemplateParams")
$Outputfile=$xml.Template.Outputfile
$Outputfile=formatText $xml $Outputfile
Write-Host "TemplateFile: "+$TemplateFile
Write-Host "TemplateParams: "+$TemplateParams
Write-Host "Outputfile: "+$Outputfile

[string]$prepFile=formatText $xml ([IO.File]::ReadAllText($TemplateFile))
$extFields=$xml.Template.ExternalFieldFormat."#cdata-section"
$fields=""

$nodes = $xml.SelectNodes("/Template/ExternalFields/*")
foreach ($node in $nodes) {
    $fieldText = $extFields
    $name = $node.Name
    $fieldName = $node.FieldName
    $type = $node.Type
    $fieldText = $fieldText.Replace('$Name$',$name)
    $fieldText = $fieldText.Replace('$FieldName$',$fieldName)
    $fieldText = $fieldText.Replace('$Type$',$type)
    $fields=$fields+$fieldText
}

$prepFile=$prepFile.Replace('$ExtensionColumns$',$fields)

$prepFile| Set-Content  $Outputfile

