declare @cashheadsql as varchar(max)=''
select @cashheadsql=@cashheadsql+IIF(@cashheadsql='','',',')+'VALUES('''+COMPANY+''','''+GROUPID+''','+CAST(HEADNUM as VarChar(1000))+ ',''' +LegalNumber+''')' from erp.CashHead where LegalNumber<>'' and LegalNumber<>checkref
print @cashheadsql
declare @customersql as varchar(max)=''
select @customersql=@customersql+IIF(@customersql='','',',')+'VALUES('''+COMPANY+''','+CAST(CustNUm as VarChar(1000))+','''+FederalID+''','''+OrgRegCode+''')'  from  erp.customer where FederalID<>''
print @customersql
--COMPANY,CustNUm,FederalID,OrgRegCode


declare @cashheadsql as varchar(max)=''
select @cashheadsql=@cashheadsql+IIF(@cashheadsql='','SELECT '''+COMPANY+''' as Company,'''+GROUPID+''' as GroupID,'+CAST(HEADNUM as VarChar(1000))+ ' as HeadNum,''' +LegalNumber+''' as LegalNumber',' UNION SELECT '''+COMPANY+''','''+GROUPID+''','+CAST(HEADNUM as VarChar(1000))+ ',''' +LegalNumber+''' ') from erp.CashHead where LegalNumber<>'' and LegalNumber<>checkref
select @cashheadsql
declare @customersql as varchar(max)=''
select @customersql=@customersql+IIF(@customersql='','SELECT '''+COMPANY+''' as Company,'+CAST(CustNUm as VarChar(1000))+' as CustNum,'''+FederalID+''' as FederalID,'''+OrgRegCode+''' as OrgRegCode' ,' UNION SELECT '''+COMPANY+''' as Company,'+CAST(CustNUm as VarChar(1000))+' as CustNum,'''+FederalID+''' as FederalID,'''+OrgRegCode+''' as OrgRegCode' ) from  erp.customer where FederalID<>''
select @customersql