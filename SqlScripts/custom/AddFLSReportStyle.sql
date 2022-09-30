DECLARE @reportID as varchar(10)='ARForm'
DECLARE @reportDefID as varchar(10)='ARForm'
DECLARE @company as varchar(8)=''
DECLARE @stylenum as int
DECLARE @stylenumBase as int
DECLARE @styledescription as varchar(50)='Standard VN Tax Invoice FLS - SSRS'
DECLARE @printprogram as varchar(50)='reports/VN/VNTaxInvoice_FLS/VNTaxInvoice_FLS'

DECLARE @exists AS BIT

SELECT @stylenum=COALESCE(MAX(StyleNum),1001) FROM ice.ReportStyle WHERE ReportID=@reportID AND StyleNum>1000
SELECT @stylenumBase=COALESCE(MAX(StyleNum),1) FROM ice.ReportStyle WHERE ReportID=@reportID AND StyleNum<999

INSERT INTO ice.ReportStyle(Company,
							ReportID,
						    StyleNum,
							StyleDescription,
							RptTypeID,
							PrintProgram,
							RptDefID,
							OutputLocation,
							CGCCode)
			VALUES(@company,
					@reportID,
					@stylenum,
					@styledescription,
					'SSRS',
					@printprogram,
					@reportDefID,
					'Database',
					'VN')

