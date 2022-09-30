use []
DECLARE @queryTbl TABLE(queryId nvarchar(max))

INSERT INTO @queryTbl Values (''),('') --list of query for "like" clause

DECLARE queryCursor CURSOR FOR SELECT queryId FROM @queryTbl 
OPEN queryCursor

DECLARE @currentUser  as nvarchar(250) = 'Manager'
DECLARE @QueryID as nvarchar(250)
DECLARE @company as nvarchar(250)
DECLARE @glbcompany as nvarchar(250)
SET @company='EPIC03' -- company
SET @glbcompany='EPIC03' -- GlbCompany
DECLARE @isSystem as int

FETCH NEXT FROM queryCursor INTO @QueryID

WHILE (@@FETCH_STATUS = 0)
BEGIN
	select  * from ice.QueryHdr where QueryID like @QueryID
	select  @isSystem=SystemFlag from ice.QueryHdr where QueryID like @QueryID
	if(@isSystem=1) 
	begin
		update Ice.QueryHdr set AuthorID = @currentUser where QueryID like @QueryID and Company = ''
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
		update Ice.QueryHdr set CompanyVisibility = 10 where QueryID like @QueryID and Company = @company
		update Ice.QueryHdr set AuthorID = 'MANAGER' where QueryID like @QueryID and Company = @company
		update Ice.QueryConversion set Company = '' where QueryID like @QueryID and Company = @company
		update Ice.QueryCtrl set Company = '', SystemFlag = 1 where QueryID like @QueryID and Company = @company
		update Ice.QueryCtrlValues set Company = '' where QueryID like @QueryID and Company = @company
		update Ice.QueryCustomAction set Company = '', SystemFlag = 1 where QueryID like @QueryID and Company = @company
		update Ice.QueryDiagram set Company = '', SystemFlag = 1 where QueryID like @QueryID and Company = @company
		update Ice.QueryExecuteSetting set Company = '', SystemFlag = 1 where QueryID like @QueryID and Company = @company
		update Ice.QueryField set Company = '', SystemFlag = 1 where QueryID like @QueryID and Company = @company
		update Ice.QueryFieldAttribute set Company = '', SystemFlag = 1 where QueryID like @QueryID and Company = @company
		update Ice.QueryFieldConversion set Company = '' where QueryID like @QueryID and Company = @company
		update Ice.QueryFunctionCall set Company = '', SystemFlag = 1 where QueryID like @QueryID and Company = @company
		update Ice.QueryGroupBy set Company = '', SystemFlag = 1 where QueryID like @QueryID and Company = @company
		update Ice.QueryHdr set Company = '', GlbCompany='', SystemFlag = 1 where QueryID like @QueryID and Company = @company
		update Ice.QueryParameter set Company = '', SystemFlag = 1 where QueryID like @QueryID and Company = @company
		update Ice.QueryRelation set Company = '', SystemFlag = 1 where QueryID like @QueryID and Company = @company
		update Ice.QueryRelationField set Company = '', SystemFlag = 1 where QueryID like @QueryID and Company = @company
		update Ice.QuerySortBy set Company = '', SystemFlag = 1 where QueryID like @QueryID and Company = @company
		update Ice.QuerySubQuery set Company = '', SystemFlag = 1 where QueryID like @QueryID and Company = @company
		update Ice.QueryTable set Company = '', SystemFlag = 1 where QueryID like @QueryID and Company = @company
		update Ice.QueryUpdateField set Company = '', SystemFlag = 1 where QueryID like @QueryID and Company = @company
		update Ice.QueryUpdateSettings set Company = '', SystemFlag = 1 where QueryID like @QueryID and Company = @company
		update Ice.QueryValueSetItems set Company = '', SystemFlag = 1 where QueryID like @QueryID and Company = @company
		update Ice.QueryWhereItem set Company = '', SystemFlag = 1 where QueryID like @QueryID and Company = @company
	end

	select  * from ice.QueryHdr where QueryID like @QueryID
    FETCH NEXT FROM queryCursor INTO @QueryID
END
CLOSE queryCursor
DEALLOCATE queryCursor
--SELECT * FROM Ice.Menu WHERE MenuID = 'SUMT7600'
-- UPDATE Ice.Menu SET Module='IM' WHERE MenuID = 'SUMT7600'

-- update Ice.QueryHdr set Version = '3.1.600.0' where QueryID like @QueryID