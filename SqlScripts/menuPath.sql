DECLARE @Program as nvarchar(1000)
DECLARE @CGCCode as nvarchar(10)
DECLARE @path as nvarchar(1000)
DECLARE @curParentID as nvarchar(50)
DECLARE @curMenuText as  nvarchar(50)
DECLARE @curMenuID as  nvarchar(50)
DECLARE @curCGCCode as nvarchar(50)
DECLARE @menuDesc as nvarchar(250)
DECLARE @curLevel as int
DECLARE @result TABLE(MenuID nvarchar(50), ParentmenuID nvarchar(50),CGCCode nvarchar(50),MenuDesc nvarchar(50),ItemLevel int)
DECLARE @fullPath as nvarchar(1000)
SET @fullPath=''
SET @curLevel=0

SET @Program ='%Erp.UIRpt.THLocCashRPostRpt.dll%'
SET @CGCCode='TH'

SELECT @curParentID=ParentmenuID,@curCGCCode=CGCCode,@curMenuText=MenuDesc,@curMenuID=MenuID FROM ice.Menu where Program like  @Program AND (COALESCE(@CGCCode,'')='' OR CGCCode=@CGCCode)

WHILE COALESCE(@curMenuID,'') <> ''
BEGIN
  if(@fullPath<>'')
  BEGIN
	SET @fullPath='->'+@fullPath
  END
  SET @fullPath=@curMenuText+@fullPath
  INSERT INTO @result(MenuID,ParentmenuID,CGCCode,MenuDesc,ItemLevel) VALUES(@curMenuID,@curParentID,@curCGCCode,@curMenuText,@curLevel)
  SET @curMenuID=null
  SELECT @curParentID=ParentmenuID,@curCGCCode=CGCCode,@curMenuText=MenuDesc,@curMenuID=MenuID FROM ice.Menu where menuId=COALESCE(@curParentID,'')
  SET @curLevel=@curLevel+1

  --print @curParentID
  --print @curMenuID
END

SELECT @Program = Program,@menuDesc=Menu.MenuDesc FROM  ice.Menu INNER JOIN  @result rslt ON Menu.MenuId=rslt.MenuID WHERE rslt.ItemLevel=0
--SELECT * FROM @result order by ItemLevel desc
SELECT @menuDesc
UNION
SELECT @Program
UNION
SELECT @fullPath
UNION 
SELECT  @menuDesc+ ' - ' + Right(REPLACE(@Program,'.dll',''), charindex('.', reverse(REPLACE(@Program,'.dll','')) + '.') - 1)


/* 
WITH MENU_CTE (MenuID, MenuDesc, ParentMenuID, Program, MLevel, MenuPath)  
AS  
(  
	SELECT TOP 1 MenuID, MenuDesc, ParentMenuID, Program, 0 AS MLevel, CAST(MenuDesc AS nvarchar(1000)) AS MenuPath
	FROM ice.Menu
	WHERE Program like 'Csfau.UI.ARUpdateCustBPAYRef.dll'
	UNION ALL  
	SELECT p.MenuID, p.MenuDesc, p.ParentMenuID, p.Program, MLevel+1  AS MLevel,  CAST(p.MenuDesc  + '\' + MenuPath as nvarchar(1000))  AS MenuPath
	FROM ice.Menu AS p 
		INNER JOIN MENU_CTE AS c 
		ON p.MenuID = c.ParentMenuID  
		--WHERE MLevel<3
)  SELECT *
FROM MENU_CTE  
ORDER BY MLevel ASC;  */