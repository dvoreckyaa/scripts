declare @dbFile AS VarChar(1000)= 'D:\BackUp\Aldor_79359__CSF_Colombia_Magnetic_Media.bak'
declare @dbFileShrink  AS VarChar(1000) = 'd:\BackUp\Aldor_79359__CSF_Colombia_Magnetic_Media_shrink.bak'
declare @dbName AS VarChar(1000)= 'EpicorProd101500'
declare @mdfName AS VarChar(1000)= @dbName
declare @ldfName AS VarChar(1000)= @dbName+'_log'
declare @mdfPath AS VarChar(1000)='D:\SqlData\'+@mdfName+'.mdf'
declare @ldfPath AS VarChar(1000)='D:\SqlData\'+@ldfName+'.ldf'
--Logical file name of the database
RESTORE FILELISTONLY
FROM DISK = @dbFile


----Make Database to single user Mode
--ALTER DATABASE EpicorProd101500
--SET SINGLE_USER WITH
--ROLLBACK IMMEDIATE
 
----Restore Database
RESTORE DATABASE EpicorProd101500
FROM DISK = @dbFile
WITH MOVE 'EpicorPilot10' TO @mdfPath,
MOVE 'EpicorPilot10_log' TO @ldfPath
 
/*If there is no error in statement before database will be in multiuser
mode.
If error occurs please execute following command it will convert
database in multi user.*/
ALTER DATABASE EpicorProd101500 SET MULTI_USER
GO

ALTER DATABASE EpicorProd101500 SET RECOVERY SIMPLE
GO

DBCC SHRINKFILE (@ldfName, 1)


BACKUP DATABASE EpicorProd101500 TO DISK = @dbFileShrink WITH COPY_ONLY;

/* SELECT percent_complete, estimated_completion_time, *

FROM sys.dm_exec_requests where session_id=157*/




