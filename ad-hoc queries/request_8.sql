-- In which quarter of 2020, got the maximum total_sold_quantity? 
-- The final output contains these fields sorted by the total_sold_quantity, Quarter total_sold_quantity


with cte1 as (
  select 
    get_fiscal_quarter(f.date) as quarter, 
    sum(sold_quantity) as total_sold_quantity 
  from 
    fact_sales_monthly f 
  where 
    fiscal_year = 2020 
  group by 
    quarter 
  order by 
    total_sold_quantity desc
) 
select 
  * 
from 
  cte1


