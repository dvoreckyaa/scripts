DECLARE @bin VARBINARY(MAX)
DECLARE @Base64 VARCHAR(MAX)
SELECT @bin=Data from ice.CustomizationStore where Folder = ':Extensions:' and Assembly = 'CSF.Localization.Australia'
SELECT  @Base64 = CAST(N'' AS XML).value('xs:base64Binary(xs:hexBinary(sql:variable("@bin")))','VARCHAR(MAX)') from ice.CustomizationStore where Folder = ':Extensions:' and Assembly = 'CSF.Localization.Australia'
SELECT CAST(CONVERT(VARCHAR(MAX), @Base64, 1) AS XML)

