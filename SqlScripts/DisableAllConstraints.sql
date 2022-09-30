USE [CSFGoldenCurrent]
DECLARE @sql nvarchar(max) = N'';

;WITH x AS 
(
  SELECT DISTINCT obj = 
      QUOTENAME(OBJECT_SCHEMA_NAME(parent_object_id)) + '.' 
    + QUOTENAME(OBJECT_NAME(parent_object_id))  
  FROM sys.foreign_keys
)
SELECT @sql += N'ALTER TABLE ' + obj + N' NOCHECK CONSTRAINT ALL;
' FROM x;

EXEC sys.sp_executesql @sql;