--use []
DECLARE @queryTbl TABLE(queryId nvarchar(max))
DECLARE @newSystemFlag as bit
SET @newSystemFlag=0

INSERT INTO @queryTbl Values ('zFAFCompanyInfo_AE'),('zFAFGeneralLedger_AE') ,
                              ('zFAFGeneralLedgerTotals_AE')
--list of query for "like" clause

DECLARE queryCursor CURSOR FOR SELECT queryId FROM @queryTbl 
OPEN queryCursor

DECLARE @QueryID as nvarchar(250)
DECLARE @company as nvarchar(250)
DECLARE @glbcompany as nvarchar(250)
SET @company='CABAE' -- company
SET @glbcompany='CABAE' -- GlbCompany
DECLARE @isSystem as int

FETCH NEXT FROM queryCursor INTO @QueryID

--UPDATE ice.QueryHdr SET AuthorID = 'Manager' FROM Ice.QueryHdr A WHERE EXISTS(SELECT * FROM @queryTbl B WHERE A.QueryID = B.queryId)

WHILE (@@FETCH_STATUS = 0)
BEGIN
	select  * from ice.QueryHdr where QueryID like @QueryID
	select  @isSystem=CASE WHEN Company='' THEN 1 ELSE 0 END from ice.QueryHdr where QueryID like @QueryID
	if(@isSystem=1) 
	begin
		update Ice.QueryConversion set Company = @company where QueryID like @QueryID and Company = ''
		update Ice.QueryCtrl set Company = @company, SystemFlag = 0 where QueryID like @QueryID and Company = ''
		update Ice.QueryCtrlValues set Company = @company where QueryID like @QueryID and Company = ''
		update Ice.QueryCustomAction set Company = @company, SystemFlag = 0 where QueryID like @QueryID and Company = ''
		update Ice.QueryDiagram set Company = @company, SystemFlag = 0 where QueryID like @QueryID and Company = ''
		update Ice.QueryExecuteSetting set Company = @company, SystemFlag = 0 where QueryID like @QueryID and Company = ''
		update Ice.QueryField set Company = @company, SystemFlag = 0 where QueryID like @QueryID and Company = ''
		update Ice.QueryFieldAttribute set Company = @company, SystemFlag = 0 where QueryID like @QueryID and Company = ''
		update Ice.QueryFieldConversion set Company = @company where QueryID like @QueryID and Company = ''
		update Ice.QueryFunctionCall set Company = @company, SystemFlag = 0 where QueryID like @QueryID and Company = ''
		update Ice.QueryGroupBy set Company = @company, SystemFlag = 0 where QueryID like @QueryID and Company = ''
		update Ice.QueryHdr set Company = @company, GlbCompany=@company, SystemFlag = 0 where QueryID like @QueryID and Company = ''
		update Ice.QueryParameter set Company = @company, SystemFlag = 0 where QueryID like @QueryID and Company = ''
		update Ice.QueryRelation set Company = @company, SystemFlag = 0 where QueryID like @QueryID and Company = ''
		update Ice.QueryRelationField set Company = @company, SystemFlag = 0 where QueryID like @QueryID and Company = ''
		update Ice.QuerySortBy set Company = @company, SystemFlag = 0 where QueryID like @QueryID and Company = ''
		update Ice.QuerySubQuery set Company = @company, SystemFlag = 0 where QueryID like @QueryID and Company = ''
		update Ice.QueryTable set Company = @company, SystemFlag = 0 where QueryID like @QueryID and Company = ''
		update Ice.QueryUpdateField set Company = @company, SystemFlag = 0 where QueryID like @QueryID and Company = ''
		update Ice.QueryUpdateSettings set Company = @company, SystemFlag = 0 where QueryID like @QueryID and Company = ''
		update Ice.QueryValueSetItems set Company = @company, SystemFlag = 0 where QueryID like @QueryID and Company = ''
		update Ice.QueryWhereItem set Company = @company, SystemFlag = 0 where QueryID like @QueryID and Company = ''
	end
	else
	begin
		update Ice.QueryConversion set Company = '' where QueryID like @QueryID and Company = @company
		update Ice.QueryCtrl set Company = '',  SystemFlag = @newSystemFlag where QueryID like @QueryID and Company = @company
		update Ice.QueryCtrlValues set Company = '' where QueryID like @QueryID and Company = @company
		update Ice.QueryCustomAction set Company = '',  SystemFlag = @newSystemFlag where QueryID like @QueryID and Company = @company
		update Ice.QueryDiagram set Company = '',  SystemFlag = @newSystemFlag where QueryID like @QueryID and Company = @company
		update Ice.QueryExecuteSetting set Company = '',  SystemFlag = @newSystemFlag where QueryID like @QueryID and Company = @company
		update Ice.QueryField set Company = '',  SystemFlag = @newSystemFlag where QueryID like @QueryID and Company = @company
		update Ice.QueryFieldAttribute set Company = '',  SystemFlag = @newSystemFlag where QueryID like @QueryID and Company = @company
		update Ice.QueryFieldConversion set Company = '' where QueryID like @QueryID and Company = @company
		update Ice.QueryFunctionCall set Company = '',  SystemFlag = @newSystemFlag where QueryID like @QueryID and Company = @company
		update Ice.QueryGroupBy set Company = '',  SystemFlag = @newSystemFlag where QueryID like @QueryID and Company = @company
		update Ice.QueryHdr set Company = '', GlbCompany='', CompanyVisibility=10,  SystemFlag = @newSystemFlag where QueryID like @QueryID and Company = @company
		update Ice.QueryParameter set Company = '',  SystemFlag = @newSystemFlag where QueryID like @QueryID and Company = @company
		update Ice.QueryRelation set Company = '',  SystemFlag = @newSystemFlag where QueryID like @QueryID and Company = @company
		update Ice.QueryRelationField set Company = '',  SystemFlag = @newSystemFlag where QueryID like @QueryID and Company = @company
		update Ice.QuerySortBy set Company = '',  SystemFlag = @newSystemFlag where QueryID like @QueryID and Company = @company
		update Ice.QuerySubQuery set Company = '',  SystemFlag = @newSystemFlag where QueryID like @QueryID and Company = @company
		update Ice.QueryTable set Company = '',  SystemFlag = @newSystemFlag where QueryID like @QueryID and Company = @company
		update Ice.QueryUpdateField set Company = '',  SystemFlag = @newSystemFlag where QueryID like @QueryID and Company = @company
		update Ice.QueryUpdateSettings set Company = '',  SystemFlag = @newSystemFlag where QueryID like @QueryID and Company = @company
		update Ice.QueryValueSetItems set Company = '',  SystemFlag = @newSystemFlag where QueryID like @QueryID and Company = @company
		update Ice.QueryWhereItem set Company = '',  SystemFlag = @newSystemFlag where QueryID like @QueryID and Company = @company
	end

	select  * from ice.QueryHdr where QueryID like @QueryID
    FETCH NEXT FROM queryCursor INTO @QueryID
END
CLOSE queryCursor
DEALLOCATE queryCursor
--SELECT * FROM Ice.Menu WHERE MenuID = 'SUMT7600'
-- UPDATE Ice.Menu SET Module='IM' WHERE MenuID = 'SUMT7600'

-- update Ice.QueryHdr set Version = '3.1.600.0' where QueryID like @QueryID