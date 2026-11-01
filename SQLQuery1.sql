create database EcommerceCustomerAnalytics;
use EcommerceCustomerAnalytics;

-- COMBINE BOTH YEARS AND CONVERT TYPES SAFELY

SELECT
    Invoice,
    StockCode,
    Description,
    Quantity,
    COALESCE(
        TRY_CONVERT(datetime2, InvoiceDate, 120),
        TRY_CONVERT(datetime2, InvoiceDate, 105)
    ) AS InvoiceDate,
    TRY_CONVERT(decimal(10,2), Price) AS Price,
    Customer_ID,
    Country,
    '2009-2010' AS SourceSheet
INTO dbo.RetailCombined
FROM dbo.[year_2009_10]

UNION ALL

SELECT
    Invoice,
    StockCode,
    Description,
    Quantity,
    COALESCE(
        TRY_CONVERT(datetime2, InvoiceDate, 120),
        TRY_CONVERT(datetime2, InvoiceDate, 105)
    ) AS InvoiceDate,
    TRY_CONVERT(decimal(10,2), Price) AS Price,
    Customer_ID,
    Country,
    '2010-2011' AS SourceSheet
FROM dbo.[year_2010_11];


select count(*) as total_rows from dbo.RetailCombined;
select count(*) as failed_invoicedate from dbo.RetailCombined where InvoiceDate is null;
select count(*) as failed_price from dbo.RetailCombined where Price is null;