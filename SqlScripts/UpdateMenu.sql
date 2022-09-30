declare @systemCode as nvarchar(200)='Erp'
declare @program as nvarchar(200)='Erp.UI.App.LCNRVReportEntry.dll'
declare @CGCCode as nvarchar(200)
declare @description as nvarchar(200)
declare @secCode as nvarchar(200)
declare @menuId as  nvarchar(200)
declare @seq as  int


set @CGCCode='TH'
set @description='LCNRV Report TH'
set @secCode='SEC10507'
set @menuId='IMRP4201'
SET @seq=190

UPDATE Ice.Security
SET
Description=@description,
CGCCode=@CGCCode,
SystemCode=@systemCode,
SystemFlag=1
WHERE SecCode=@secCode


Update ice.Menu
Set 
MenuDesc=@description,
Sequence=@seq,
Program=@program,
SecCode=@secCode,
CGCCode=@CGCCode,
SystemCode=@systemCode,
SystemFlag=1
where MenuID=@menuId


set @CGCCode='TW'
set @description='LCNRV Report TW'
set @secCode='SEC10508'
set @menuId='IMRP4202'
SET @seq=200

UPDATE Ice.Security
SET
Description=@description,
CGCCode=@CGCCode,
SystemCode=@systemCode,
SystemFlag=1
WHERE SecCode=@secCode


Update ice.Menu
Set 
MenuDesc=@description,
Sequence=@seq,
Program=@program,
SecCode=@secCode,
CGCCode=@CGCCode,
SystemCode=@systemCode,
SystemFlag=1
where MenuID=@menuId


set @CGCCode='CO'
set @description='LCNRV Report CO'
set @secCode='SEC10509'
set @menuId='IMRP4203'
SET @seq=210
UPDATE Ice.Security
SET
Description=@description,
CGCCode=@CGCCode,
SystemCode=@systemCode,
SystemFlag=1
WHERE SecCode=@secCode


Update ice.Menu
Set 
MenuDesc=@description,
Sequence=@seq,
Program=@program,
SecCode=@secCode,
CGCCode=@CGCCode,
SystemCode=@systemCode,
SystemFlag=1
where MenuID=@menuId