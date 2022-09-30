DECLARE @DefinitionID as varchar(200)='THARLegalNumber'
DECLARE @CGCCode as varchar(200)='TH'
UPDATE ice.DashBdDef set CGCCode=@CGCCode,Company='',SystemFlag=1,companyvisibility=10 where DefinitionID = @DefinitionID
UPDATE ice.DashBdBAQ set CGCCode=@CGCCode,Company='',SystemFlag=1 where DefinitionID = @DefinitionID

DECLARE @ReportID as varchar(200)='THARLegalNumber'
UPDATE ice.RptDataDef set CGCCode=@CGCCode, SystemRpt=1, SystemFlag=1 where RptDefId=@ReportID
UPDATE ice.RptCriteriaSet SET SystemFlag=1  where RptDefID=@ReportID

SET @ReportID = 'THARLegalNumber'
UPDATE ice.Report set CGCCode=@CGCCode, SystemRpt=1, SystemFlag=1 where ReportID=@ReportID
UPDATE ice.ReportStyle 

DECLARE @MenuID as varchar(200)='_______'
DECLARE @SecID as varchar(200)='_______'
update ice.Menu set systemflag=1,CGCCode=@CGCCode where menuid=@MenuID
update ice.Security set systemflag=1,CGCCode=@CGCCode,SystemCode='ERP'  where SecCode=@SecID

UPDATE ice.ReportStyle set CSGCODE=@CGCCode where  ReportID='THARLegalNumber' AND StyleNum=1
select * from  ice.ReportStyle where  ReportID='THARLegalNumber'