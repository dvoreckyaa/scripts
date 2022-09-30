DECLARE @DefinitionID AS nvarchar(255) = 'CashReceipt_AU'

DECLARE @x xml   
SELECT @x=DashboardSchema FROM ice.DashBdDef WHERE DefinitionID = @DefinitionID

DECLARE @DbBAQ TABLE (
  DynamicQueryID nvarchar(255) PRIMARY KEY NOT NULL,
  QueryID nvarchar(255)  NOT NULL
)

DECLARE @DbFields TABLE (
 -- id nvarchar(255) PRIMARY KEY NOT NULL,
  FieldName nvarchar(255)  NOT NULL,
  QueryID nvarchar(255)  NOT NULL
)

DECLARE @DashboardColumnsMissingField TABLE (
 -- id nvarchar(255)  NOT NULL,
  DynamicQueryID nvarchar(255)  NOT NULL,
  QueryID nvarchar(255)  NOT NULL,
  DBFieldName sysname NOT NULL,
  FieldName sysname NOT NULL
  --PRIMARY KEY(id)
)

INSERT INTO @DbBAQ(DynamicQueryID, QueryID)
SELECT CAST(T.c.query('*[local-name()=''DynamicQueryID'']/text()') AS nvarchar(MAX)) AS DynamicQueryID ,
       CAST(T.c.query('*[local-name()=''QueryID'']/text()') AS nvarchar(MAX)) AS QueryID  
FROM   @x.nodes('//*[local-name()=''DashboardDataSet'']/*[local-name()=''DashboardQuery'']') T(c)  

INSERT INTO @DbFields(FieldName, QueryID)
--;WITH XMLNAMESPACES ('urn:schemas-microsoft-com:xml-diffgram-v1' AS diffgr)
--SELECT T.c.value('@diffgr:id','nvarchar(max)') AS id ,
SELECT CAST(T.c.query('*[local-name()=''ColumnName'']/text()') AS nvarchar(MAX)) AS FieldName ,
       CAST(T.c.query('*[local-name()=''QueryID'']/text()') AS nvarchar(MAX)) AS QueryID  
FROM   @x.nodes('//*[local-name()=''DashboardViewColumns'']') T(c)  


INSERT INTO @DashboardColumnsMissingField(DynamicQueryID, QueryID, DBFieldName, FieldName)
SELECT DbBAQ.DynamicQueryID, DbBAQ.QueryID, DBFieldName, DBF.FieldName FROM Ice.QueryField QF
INNER JOIN @DbBAQ DbBAQ ON QF.QueryID = DbBAQ.DynamicQueryID
--AND NOT EXISTS (SELECT * FROM Ice.ZDataField Z WHERE QF.TableID = Z.DataTableID AND QF.DBSchemaName = Z.SystemCode AND DBFieldName = Z.FieldName)
INNER JOIN @DbFields AS DBF ON QF.Alias = DBF.FieldName AND DbBAQ.QueryID = DBF.QueryID
