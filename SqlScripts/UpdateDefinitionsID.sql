--Update BAQ definitions:
--zSalesTax_Company_MY
--zSalesTax_Exemp_MY
--zSalesTax_InvcTax_MY
-----

DECLARE @QueryID AS nvarchar(200)
DECLARE @NewQueryID AS nvarchar(200)
DECLARE @baqTbl TABLE (queryid nvarchar(200),newqueryid nvarchar(200))
INSERT INTO @baqTbl VALUES('zSalesTax_Company_MY','zDeemedSupply_Company_MY'),
                          ('zSalesTax_Exempt_MY','zDeemedSupply_Exempt_MY'),
						  ('zSalesTax_InvcTax_MY','zDeemedSupply_InvcTax_MY')

DECLARE queryCursor CURSOR FOR SELECT queryId,newqueryid FROM @baqTbl 
OPEN queryCursor
FETCH NEXT FROM queryCursor INTO @QueryID,@NewQueryID

WHILE (@@FETCH_STATUS = 0)
BEGIN
 UPDATE ice.ContextMenuItem SET QueryID = @NewQueryID where QueryID=@QueryID
 UPDATE ice.DashBdBAQ SET QueryID = @NewQueryID where QueryID=@QueryID
 UPDATE ice.QueryConversion SET QueryID = @NewQueryID where QueryID=@QueryID
 UPDATE ice.QueryCtrl SET QueryID = @NewQueryID where QueryID=@QueryID
 UPDATE ice.QueryCtrlValues SET QueryID = @NewQueryID where QueryID=@QueryID
 UPDATE ice.QueryCustomAction SET QueryID = @NewQueryID where QueryID=@QueryID
 UPDATE ice.QueryDiagram SET QueryID = @NewQueryID where QueryID=@QueryID
 UPDATE ice.QueryExecuteSetting SET QueryID = @NewQueryID where QueryID=@QueryID
 UPDATE ice.QueryField SET QueryID = @NewQueryID where QueryID=@QueryID
 UPDATE ice.QueryFieldAttribute SET QueryID = @NewQueryID where QueryID=@QueryID
 UPDATE ice.QueryFieldConversion SET QueryID = @NewQueryID where QueryID=@QueryID
 UPDATE ice.QueryFunctionCall SET QueryID = @NewQueryID where QueryID=@QueryID
 UPDATE ice.QueryGroupBy SET QueryID = @NewQueryID where QueryID=@QueryID
 UPDATE ice.QueryHdr SET QueryID = @NewQueryID where QueryID=@QueryID
 UPDATE ice.QueryParameter SET QueryID = @NewQueryID where QueryID=@QueryID
 UPDATE ice.QueryRelation SET QueryID = @NewQueryID where QueryID=@QueryID
 UPDATE ice.QueryRelationField SET QueryID = @NewQueryID where QueryID=@QueryID
 UPDATE ice.QuerySortBy SET QueryID = @NewQueryID where QueryID=@QueryID
 UPDATE ice.QuerySubQuery SET QueryID = @NewQueryID where QueryID=@QueryID
 UPDATE ice.QueryTable SET QueryID = @NewQueryID where QueryID=@QueryID
 UPDATE ice.QueryUpdateField SET QueryID = @NewQueryID where QueryID=@QueryID
 UPDATE ice.QueryUpdateSettings SET QueryID = @NewQueryID where QueryID=@QueryID
 UPDATE ice.QueryValueSetItems SET QueryID = @NewQueryID where QueryID=@QueryID
 UPDATE ice.QueryWhereItem SET QueryID = @NewQueryID where QueryID=@QueryID
 UPDATE ice.RptTable SET QueryID = @NewQueryID where QueryID=@QueryID
 UPDATE ice.SysCube SET QueryID = @NewQueryID where QueryID=@QueryID
 UPDATE ice.SysCubeDef SET QueryID = @NewQueryID where QueryID=@QueryID


 UPDATE ice.QueryCtrl SET DataSource = 'From' where QueryID=@NewQueryID and DataSource='BeginDate'
 UPDATE ice.QueryCtrl SET DataSource = 'To' where QueryID=@NewQueryID and DataSource='EndDate'

 UPDATE ice.QueryCtrl SET IsMandatory=1 where QueryID=@NewQueryID and DataSource='From'
 UPDATE ice.QueryCtrl SET IsMandatory=1 where QueryID=@NewQueryID and DataSource='To'

 UPDATE ice.QueryParameter SET ParameterID = 'From',ParameterLabel='From:' where QueryID=@NewQueryID and ParameterID='BeginDate'
 UPDATE ice.QueryParameter SET ParameterID = 'To',ParameterLabel='To:' where QueryID=@NewQueryID and ParameterID='EndDate'

  UPDATE ice.QueryParameter SET ParameterLabel='From' where QueryID=@NewQueryID and ParameterID='From'
 UPDATE ice.QueryParameter SET ParameterLabel='To' where QueryID=@NewQueryID and ParameterID='To'

 UPDATE ice.QueryWhereItem SET RValue='@From' where QueryID=@NewQueryID AND RValue='@BeginDate'
 UPDATE ice.QueryWhereItem SET RValue='@To' where QueryID=@NewQueryID AND RValue='@EndDate'

 UPDATE ice.DashBdDef SET DashboardSchema = REPLACE(DashboardSchema,@QueryID,@NewQueryID) where DefinitionID in ('SalesTax_MY','DeemedSupply_MY')

 FETCH NEXT FROM queryCursor INTO @QueryID,@NewQueryID
END
CLOSE queryCursor
DEALLOCATE queryCursor
 
----- Update ReportDataDefinition ----
DECLARE @RptDefID AS nvarchar(200)
DECLARE @NewRptDefID AS nvarchar(200)
DECLARE @NewRptDescription AS nvarchar(200)
DECLARE @rptDefTbl TABLE (RptDefID nvarchar(200),NewRptDefID nvarchar(200),NewRptDescription nvarchar(200))
INSERT INTO @rptDefTbl VALUES('MYSalesTaxRpt','MYDeemedSplyRpt','MY Deemed Supply Report')

DECLARE rptCursor CURSOR FOR SELECT RptDefID,NewRptDefID,NewRptDescription FROM @rptDefTbl 
OPEN rptCursor
FETCH NEXT FROM rptCursor INTO @RptDefID,@NewRptDefID,@NewRptDescription

WHILE (@@FETCH_STATUS = 0)
BEGIN
 UPDATE ice.RptCriteriaSet SET RptDefID = @NewRptDefID  where RptDefID=@RptDefID
 UPDATE ice.RptDataDef SET RptDefID = @NewRptDefID,RptDescription=CASE WHEN @NewRptDescription='' OR @NewRptDescription IS NULL THEN RptDescription ELSE @NewRptDescription END where RptDefID=@RptDefID
 UPDATE ice.RptCalcField SET RptDefID = @NewRptDefID  where RptDefID=@RptDefID
 UPDATE ice.RptCriteriaFilter SET RptDefID = @NewRptDefID  where RptDefID=@RptDefID
 UPDATE ice.RptCriteriaMapping SET RptDefID = @NewRptDefID  where RptDefID=@RptDefID
 UPDATE ice.RptCriteriaPrompt SET RptDefID = @NewRptDefID  where RptDefID=@RptDefID
 
 
 UPDATE ice.RptExclude SET RptDefID = @NewRptDefID  where RptDefID=@RptDefID
 UPDATE ice.RptLinkField SET RptDefID = @NewRptDefID  where RptDefID=@RptDefID
 UPDATE ice.RptLinkTable SET RptDefID = @NewRptDefID  where RptDefID=@RptDefID
 UPDATE ice.RptLiterals SET RptDefID = @NewRptDefID  where RptDefID=@RptDefID
 UPDATE ice.RptRelation SET RptDefID = @NewRptDefID  where RptDefID=@RptDefID
 UPDATE ice.RptRelationField SET RptDefID = @NewRptDefID  where RptDefID=@RptDefID
 UPDATE ice.RptStructuredOutputDef SET RptDefID = @NewRptDefID  where RptDefID=@RptDefID
 UPDATE ice.RptTable SET RptDefID = @NewRptDefID  where RptDefID=@RptDefID
 UPDATE ice.RptWhereItem SET RptDefID = @NewRptDefID  where RptDefID=@RptDefID
 UPDATE ice.ReportStyle SET RptDefID = @NewRptDefID  where RptDefID=@RptDefID
 UPDATE ice.ReportStyleRule SET RptDefID = @NewRptDefID  where RptDefID=@RptDefID

 FETCH NEXT FROM rptCursor INTO  @RptDefID,@NewRptDefID,@NewRptDescription
END
CLOSE rptCursor
DEALLOCATE rptCursor

----- Update ReportStyle ----

DECLARE @ReportID AS nvarchar(200)
DECLARE @NewReportID AS nvarchar(200)
DECLARE @rptStyleTbl TABLE (ReportID nvarchar(200),NewReportID nvarchar(200),NewRptDescription nvarchar(200))
INSERT INTO @rptStyleTbl VALUES('MYSalesTaxRpt','MYDeemedSplyRpt','MY Deemed Supply Report')

DECLARE rptStyleCursor CURSOR FOR SELECT ReportID,NewReportID,NewRptDescription FROM @rptStyleTbl 
OPEN rptStyleCursor
FETCH NEXT FROM rptStyleCursor INTO @ReportID,@NewReportID,@NewRptDescription

WHILE (@@FETCH_STATUS = 0)
BEGIN
 UPDATE ice.Report SET ReportID=@NewReportID,RptDescription=CASE WHEN @NewRptDescription='' OR @NewRptDescription IS NULL THEN RptDescription ELSE @NewRptDescription END where ReportID=@ReportID
 UPDATE ice.ReportStyle SET ReportID=@NewReportID where ReportID=@ReportID
 UPDATE ice.ReportStyleImage SET ReportID=@NewReportID where ReportID=@ReportID
 UPDATE ice.ReportStyleRule SET ReportID=@NewReportID where ReportID=@ReportID
 UPDATE ice.RptParms SET ReportID=@NewReportID where ReportID=@ReportID
 UPDATE ice.RptStylePrinters SET ReportID=@NewReportID where ReportID=@ReportID
 UPDATE ice.RptSubmission SET ReportID=@NewReportID where ReportID=@ReportID
 FETCH NEXT FROM rptStyleCursor INTO @ReportID,@NewReportID,@NewRptDescription
END
CLOSE rptStyleCursor
DEALLOCATE rptStyleCursor

----- Update Dashboard ----

DECLARE @DefinitionID AS nvarchar(200)
DECLARE @NewDefinitionID AS nvarchar(200)
DECLARE @NewDescription AS nvarchar(200)
DECLARE @dashboardTbl TABLE (DefinitionID nvarchar(200),NewDefinitionID nvarchar(200),NewDescription nvarchar(200))
INSERT INTO @dashboardTbl VALUES('SalesTax_MY','DeemedSupply_MY','MY Deemed Supply')

DECLARE dashboardCursor CURSOR FOR SELECT DefinitionID,NewDefinitionID,NewDescription FROM @dashboardTbl 
OPEN dashboardCursor
FETCH NEXT FROM dashboardCursor INTO @DefinitionID,@NewDefinitionID,@NewDescription

WHILE (@@FETCH_STATUS = 0)
BEGIN
 UPDATE ice.DashBdDef SET DefinitionID=@NewDefinitionID,
         Description=CASE WHEN @NewDescription='' OR @NewDescription IS NULL THEN Description ELSE @NewRptDescription END 
		 where DefinitionID=@DefinitionID

 UPDATE ice.DashBdChunk SET DefinitionID=@NewDefinitionID where DefinitionID=@DefinitionID
 UPDATE ice.DashBdBAQ SET DefinitionID=@NewDefinitionID where DefinitionID=@DefinitionID
 UPDATE ice.DashBdLike SET DefinitionID=@NewDefinitionID where DefinitionID=@DefinitionID

 UPDATE ice.DashBdDef SET Caption = 'Deemed Supply' where DefinitionID=@NewDefinitionID

 FETCH NEXT FROM dashboardCursor INTO @DefinitionID,@NewDefinitionID,@NewDescription
END
CLOSE dashboardCursor
DEALLOCATE dashboardCursor
