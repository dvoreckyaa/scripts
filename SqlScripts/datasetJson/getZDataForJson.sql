DECLARE @tableName as SysName = 'Part'

DECLARE @json VARCHAR(MAX)
SELECT @json = BulkColumn
--Cyrillic_General_CI_AS
FROM OPENROWSET(BULK'C:\_projects\ERP10CC\Users\ADvoretsky\SqlScripts\datasetJson\Part.json', SINGLE_BLOB) JSON;

SELECT obj.[key] RowIndex, objFld.[key] COLLATE  SQL_Latin1_General_CP1_CI_AS FieldName, objFld.[value] COLLATE  SQL_Latin1_General_CP1_CI_AS FieldValue     INTO #dt
FROM OPENJSON(@json,'$.ds.' + @tableName) AS obj
OUTER APPLY OPENJSON(obj.[value]) objFld

SELECT #dt.*, Z.DataType, CASE WHEN Z.FieldName IS NULL THEN 0 ELSE 1 END AS ZDataExists FROM #dt LEFT JOIN 
Ice.ZDataField Z ON  #dt.FieldName = z.FieldName AND Z.DataTableID = @tableName -- 
WHERE  Z.DataType like '%date%'
ORDER BY RowIndex, #dt.FieldName

DROP TABLE #dt

