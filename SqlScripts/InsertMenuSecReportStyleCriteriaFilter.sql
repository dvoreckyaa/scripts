DECLARE @RptDefID as nvarchar(20) = 'CNCustomsMtlBal'
DECLARE @ReportID as nvarchar(20) = 'CNCustomsMtlBal'
DECLARE @CGCCode as nvarchar(20) = 'CN'
DECLARE @StyleDecription as nvarchar(50) = 'Customs Handbook Material Balance Report'
DECLARE @PrintProgram as nvarchar(50) = 'reports/CN/CN-CustomsMtlBal/CN-CustomsMtlBal'

DECLARE @Program as nvarchar(50)='Ice.UIRpt.DynamicCriteriaReport.dll'
DECLARE @Arguments as nvarchar(50)='-be DynamicCriteriaReportForm_CNCustomsMtlBal -r ' + @ReportID
DECLARE @MenuDesc as nvarchar(50)='Customs Handbook Material Balance CN'
DECLARE @SecCode as nvarchar(50)='SEC34130'
DECLARE @MenuID as nvarchar(50)='SRRP0007'
DECLARE @Module as nvarchar(50)='SR'
DECLARE @MenuSeq as int=9

delete Ice.RptCriteriaFilter where RptDefID=@RptDefID
insert into Ice.RptCriteriaFilter (Company,RptDefID,RptCriteriaSetID,FilterID,FilterName,AdapterName,LookupField,FilterLabel,TabLabel,DataType,DisplayOrder,SystemFlag)
                            values('',@RptDefID,'Default',1,'HandbookCodes','CNCustomsHandbookAdapter','HandbookCode','Handbook','Customs Handbooks','nvarchar',1,1),
							      ('',@RptDefID,'Default',2,'Parts','PartAdapter','PartNum','Part','Parts','nvarchar',2,1)
								  /*
								  insert Ice.RptCriteriaMapping(Company,RptDefID,RptTableID,ParameterID,FilterID,RptCriteriaSetID)
values ('','CNCustomsMtlBal','CustomsHandbookMtlBal','HandbookCodeList',1,'Default'),
		('','CNCustomsMtlBal','CustomsHandbookMtlBal','PartNumList',2,'Default')*/
insert into ice.report(ReportID, RptDescription, AutoProgram, SystemRpt, CGCCode, SystemFlag, Company, CompanyVisibility)
            values(@RptDefID, @StyleDecription,'Ice:Rpt:DynamicCriteria',1,@CGCCode,1,'',10)
insert into ice.ReportStyle(Company,ReportID,StyleNum,StyleDescription,RptTypeID,PrintProgram,RptDefID,OutputLocation,SystemFlag,CGCCode,RptCriteriaSetID)
            values('', @ReportID,1,'Standard - SSRS','SSRS',@PrintProgram,@RptDefID,'Database',1,@CGCCode,'Default')


Update Ice.Menu set Sequence=12 where MenuID='SRRP2010'
Update Ice.Menu set Sequence=10, Module=@Module where MenuID='MPRP2014'
Update Ice.Menu set  Module=@Module where MenuID='MPRP2013'

insert into ice.Security(Company,CompanyVisibility,SecCode,EntryList,Description,ParentSecCode, SystemCode,SystemFlag,CGCCode)
			    values('',10,@SecCode,'*',@MenuDesc,'MENU','ERP',1,@CGCCode)
insert into Ice.Menu(Company,Module,MenuID,MenuDesc, ParentMenuID, Sequence,OptionType,OptionSubType,Program,Enabled, SecCode, Arguments, MenuType,CGCCode,SystemCode,DefaultFormType,CompanyVisibility)
            values('',@Module,@MenuID,@MenuDesc,'SRMN2000',@MenuSeq,'Q','R',@Program,1,@SecCode,@Arguments,'MAINMENU',@CGCCode,'ERP','Default', 10)

--update  ice.RptTable set EFTHeadUID=732,EFTHeadCompany='EPIC03' where RptDefID='CNCustomsMtlBal' and RptTableID='CustomsHandbookMtlBal'

