--deduplicate and produce final cleaned table

with cte as(
select *,
	ROW_NUMBER() over(partition by Invoice,StockCode,Description,Quantity,InvoiceDate,Price,Customer_ID,Country
				 order by (select null) )  as row_no
from dbo.RetailCombined
)
select Invoice,StockCode,Description,Quantity,InvoiceDate,Price,Customer_ID,Country,SourceSheet
into dbo.RetailCleaned
from cte
where row_no=1;


select * from dbo.RetailCleaned;