-- Get the complete report of the Gross sales amount for the customer “Atliq Exclusive” for each month .
-- This analysis helps to get an idea of low and high-performing months and take strategic decisions. 
-- The final report contains these columns: Month Year Gross sales Amount

select 
	month(f.date) AS Month, 
    year(f.date) AS Year,
    sum(round(g.gross_price*f.sold_quantity,2)) as Gross_sales_amount
    
from fact_sales_monthly f
join dim_customer d
on f.customer_code = d.customer_code

join fact_gross_price g
on f.product_code = g.product_code AND g.fiscal_year = get_fiscal_year(f.date)

where customer = 'Atliq Exclusive'
group by Month, Year
order by Year
