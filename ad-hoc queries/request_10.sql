-- Get the Top 3 products in each division that have a high total_sold_quantity in the fiscal_year 2021? 
-- The final output contains these fields, division product_code product total_sold_quantity rank_order


with cte1 as (
  select 
    d.division, 
    d.product_code, 
    d.product, 
    sum(f.sold_quantity) as total_sold_quantity, 
    rank() over (
      partition by division 
      order by 
        sum(f.sold_quantity) desc
    ) as rank_order 
  from 
    dim_product d 
    join fact_sales_monthly f on d.product_code = f.product_code 
  where 
    fiscal_year = 2021 
  group by 
    product, product_code, division
) 
select 
  * 
from 
  cte1 
where 
  rank_order <= 3

