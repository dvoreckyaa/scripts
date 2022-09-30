DECLARE @rptId as nvarchar(max)
DECLARE @systemFlag as int
SET @rptId='LCNRV'

select * from ice.RptDataDef where RptDefId like  @rptId 
select @systemFlag=SystemFlag from ice.RptDataDef where RptDefId like  @rptId
IF( @systemFlag=1)
  update ice.RptDataDef set SystemFlag=0, SystemRpt=0 where RptDefId like  @rptId
ELSE
 update ice.RptDataDef set SystemFlag=1, SystemRpt=1 where RptDefId like  @rptId
 select * from ice.RptDataDef where RptDefId like  @rptId


--update ice.RptTable set EFTHeadUID=(select top 1 EFTHeadUID from erp.EFTHead where Name like 'LCNRV'),
--   EFTHeadCompany=(Select top 1 company from erp.Company)
--   where RptDefID=@rptId and RptTableID='LCNRV'