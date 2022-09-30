USE [CSFGolden102700]

DECLARE @solutionIds TABLE(CSFCountry nvarchar(max),
    SolutionId nvarchar(max))
INSERT INTO @solutionIds
SELECT DISTINCT RTrim(LTrim(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Description,'_',''),'prepare',''),'prep',''),'db scripts',''),'CSFFrance', 'CSF France'))) AS CountryDescription , SolutionID
FROM Ice.SolutionHeader
WHERE RTrim(LTrim(InternalNotes))<>''
Order BY SolutionID

SELECT CSFCountry AS Location, 
       --Company, 
       MAX(ExtensibilitySolution)  AS 'Extensibility Solution', 
       MAX(ServerAssembliesInstalled) AS 'Server Assemblies Installed?', 
       Max(ClientDLLsInstalled) AS 'Client DLLs installed?', 
       Max(RunDatabaseScriptsRunner) AS 'Run Database Scripts Runner', 
       Max(ExtensionSchemaSynchronize) AS 'Extension Schema Synchronize'
FROM (
SELECT sids.CSFCountry, Company,
        CASE WHEN EXISTS(SELECT *
        FROM ice.SolutionDetail sd INNER JOIN ice.ExtensionSet ext ON ext.SysRowID = sd.ForeignSysRowID INNER JOIN ice.ExtensionDataSetTable extTbl ON ext.ExtensionSetID = extTbl.ExtensionSetID
        WHERE sd.TableName ='Ice.ExtensionSet' AND sd.SolutionID = sh.SolutionID ) THEN 1 ELSE 0 END AS ExtensionSchemaSynchronize,
        CASE WHEN EXISTS(SELECT * FROM Ice.EPFileContents fc WHERE fc.FileContentType=7 AND fc.PackageID = sh.SolutionID) THEN 1 ELSE 0 END AS RunDatabaseScriptsRunner,
        CASE WHEN EXISTS(SELECT *
        FROM Ice.EPFileContents fc
        WHERE FileContentType in (4,5) AND fc.PackageID =sh.SolutionID AND SourcePath LIKE '%Client%.zip') THEN 1 ELSE 0 END    AS ClientDLLsInstalled,
        CASE WHEN EXISTS(SELECT *
        FROM ice.SolutionDetail sd INNER JOIN Ice.EPFileContents fc ON fc.PackageID = sd.SolutionID AND FileContentType=1 AND SourcePath LIKE '%Assemblies%.dll' AND sd.SolutionID = sh.SolutionID) THEN 1 ELSE 0 END  AS ServerAssembliesInstalled,
        CASE WHEN EXISTS(SELECT *
        FROM Ice.SolutionDetail sd
        WHERE sd.SolutionID = sh.SolutionID AND TableName ='Ice.ExtensionSet') THEN 1 ELSE 0 END AS ExtensibilitySolution
    FROM Ice.SolutionHeader sh INNER JOIN @solutionIds sids ON sh.SolutionID = sids.SolutionId) drv
GROUP BY CSFCountry, Company
ORDER BY CSFCountry
