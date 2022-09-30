DECLARE @reportID as varchar(10)='ARForm'
DECLARE @reportDefID as varchar(10)='ARForm'
DECLARE @company as varchar(8)=''
DECLARE @rptTableID as varchar(8)='CustBank'
DECLARE @systemCode as varchar(8)='ERP'

BEGIN TRANSACTION
--add CustBank table
IF NOT (EXISTS(SELECT * FROM ice.RptTable WHERE RptDefID=@reportDefID AND RptTableID=@rptTableID))
BEGIN
 INSERT INTO ice.RptTable(RptDefID,
						  RptTableID,
						  SystemCode,
                          ZDataTableID,
						  SeqControl,
                          SystemFlag,
                          IsSystemTable)
			VALUES(@reportDefID,
		        	@rptTableID,
		        	@systemCode,
		        	@rptTableID,
		        	140,
		        	1,
		        	1)

END

--add exclude columns of CustBank
INSERT INTO ice.RptExclude(RptDefID,
                           RptTableID,
                           SystemCode,
                           ZDataTableID,
                           ZFieldName,
                           SystemFlag,
                           ExcludeColumn,
                           ExcludeLabel)        
SELECT @reportDefID,
       @rptTableID,
       @systemCode,
       @rptTableID,
       FieldName,
	   1,
	   1,
	   1
FROM ice.ZDataField 
WHERE SystemCode=@systemCode AND DataTableID=@rptTableID AND [External]=0 
      AND NOT EXISTS(SELECT * FROM ice.RptExclude WHERE RptDefID=@reportDefID AND RptTableID=@rptTableID AND SystemCode=@systemCode AND ZDataTableID=@rptTableID AND ZFieldName=ZDataField.FieldName)
--update the Exclude flag
UPDATE ice.RptExclude SET ExcludeColumn=0 WHERE RptDefID=@reportDefID 
                                                AND ZDataTableID=@rptTableID 
                                                AND SystemCode=@systemCode 
                                                AND RptTableID=@rptTableID
												AND ZFieldName IN ('BankAcctNumber','Company','CustNum','PrimaryBank')

--add calculated fields
IF(NOT EXISTS(SELECT * FROM ice.RptCalcField WHERE RptDefID=@reportDefID 
                                               AND RptTableID='BankAcct'
                                               AND SystemCode=@systemCode 
                                               AND ZDataTableID='BankAcct' 
                                               AND FieldName='AddressList'))
BEGIN
 INSERT INTO ice.RptCalcField(RptDefID,RptTableID,SystemCode,ZDataTableID,FieldName,FieldLabel,DataType,FieldFormat,SystemFlag)
 VALUES(@reportDefID,'BankAcct',@systemCode,'BankAcct','AddressList','Address List','character', 'X(1000)',1)
END

IF(NOT EXISTS(SELECT * FROM ice.RptCalcField WHERE RptDefID=@reportDefID 
                                               AND RptTableID='Company' 
                                               AND SystemCode=@systemCode 
                                               AND ZDataTableID='Company' 
                                               AND FieldName='BaseCurrencyID'))
BEGIN
 INSERT INTO ice.RptCalcField(RptDefID,RptTableID,SystemCode,ZDataTableID,FieldName,FieldLabel,DataType,FieldFormat,SystemFlag)
 VALUES(@reportDefID,'Company',@systemCode,'Company','BaseCurrencyID','Base Currency ID','character', 'X(4)',1)
END
COMMIT TRANSACTION
