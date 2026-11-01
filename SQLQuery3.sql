--data exploration 

use EcommerceCustomerAnalytics;

--1.missing customer id 
select count(*)as missing_customer_id from dbo.RetailCombined where Customer_ID is null;


--2. negative or zero Quantity
select count(*)as negative_qty from dbo.RetailCombined where Quantity <=0;

--3.missing description
select count(*)as missing_desc from dbo.RetailCombined where Description is null;

--4. exact duplicate rows
with cte as(
select Invoice,StockCode,Description,Quantity,InvoiceDate,Price,Customer_ID,Country,count(*) as exact_duplicate from dbo.RetailCombined 
group by Invoice,StockCode,Description,Quantity,InvoiceDate,Price,Customer_ID,Country
having count(*)>1)

select count(*) from cte;

