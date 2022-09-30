--use []
DECLARE @queryTbl TABLE(queryId nvarchar(max))

INSERT INTO @queryTbl Values ('zFAFCompanyInfo_AE'),('zFAFGeneralLedger_AE') ,
                              ('zFAFGeneralLedgerTotals_AE')

delete Ice.QueryConversion where QueryID in (SELECT queryid FROM @queryTbl)
delete Ice.QueryCtrl where QueryID in (SELECT queryid FROM @queryTbl)
delete Ice.QueryCtrlValues where QueryID in (SELECT queryid FROM @queryTbl)
delete Ice.QueryCustomAction where QueryID in (SELECT queryid FROM @queryTbl)
delete Ice.QueryDiagram where QueryID in (SELECT queryid FROM @queryTbl)
delete Ice.QueryExecuteSetting where QueryID in (SELECT queryid FROM @queryTbl)
delete Ice.QueryField where QueryID in (SELECT queryid FROM @queryTbl)
delete Ice.QueryFieldAttribute where QueryID in (SELECT queryid FROM @queryTbl)
delete Ice.QueryFieldConversion where QueryID in (SELECT queryid FROM @queryTbl)
delete Ice.QueryFunctionCall where QueryID in (SELECT queryid FROM @queryTbl)
delete Ice.QueryGroupBy where QueryID in (SELECT queryid FROM @queryTbl)
delete Ice.QueryHdr where QueryID in (SELECT queryid FROM @queryTbl)
delete Ice.QueryParameter where QueryID in (SELECT queryid FROM @queryTbl)
delete Ice.QueryRelation where QueryID in (SELECT queryid FROM @queryTbl)
delete Ice.QueryRelationField where QueryID in (SELECT queryid FROM @queryTbl)
delete Ice.QuerySortBy where QueryID in (SELECT queryid FROM @queryTbl)
delete Ice.QuerySubQuery where QueryID in (SELECT queryid FROM @queryTbl)
delete Ice.QueryTable where QueryID in (SELECT queryid FROM @queryTbl)
delete Ice.QueryUpdateField where QueryID in (SELECT queryid FROM @queryTbl)
delete Ice.QueryUpdateSettings where QueryID in (SELECT queryid FROM @queryTbl)
delete Ice.QueryValueSetItems where QueryID in (SELECT queryid FROM @queryTbl)
delete Ice.QueryWhereItem where QueryID in (SELECT queryid FROM @queryTbl)
