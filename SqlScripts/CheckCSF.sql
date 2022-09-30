--update erp.EFTHead set SystemFlag=1,IsSystem=1, Program='Erp\EI\Export_CustomerPeriodBalance\Export_CustomerPeriodBalance.cs' where name='CustomerPeriodBalance'
--select * from erp.EFTHead where name='CustomerPeriodBalance'

--update ice.RptDataDef  set SystemRpt=1,SystemFlag=1 where RptDefId='CustPeriodBal'
--select * from ice.RptDataDef where RptDefId='CustPeriodBal'

--update ice.Report set systemFlag=1,SystemRpt=1 where ReportID='CustPeriodBal'
--select * from ice.Report where ReportID='CustPeriodBal'

--select * from ice.ReportStyle where ReportID='CustPeriodBal' and styledescription='Standard VN - SSRS'
--update  ice.ReportStyle set SystemFlag=1, CGCCode='VN' where ReportID='CustPeriodBal' and styledescription='Standard VN - SSRS'

--select * from ice.Menu where parentmenuid='ARMN4000' order by SecCode

--select * from ice.Menu where Menudesc='Customer Period Balance VN'
--update ice.Menu set CGCCode='VN', SystemCode='ERP' where Menudesc='Customer Period Balance VN'

--select * from ice.Security where SecCode='SEC4006'

--update ice.Security set CGCCode='VN',SystemFlag=1 where SecCode='SEC4006'