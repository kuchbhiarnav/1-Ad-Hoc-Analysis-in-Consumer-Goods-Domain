-- Follow-up: Which segment had the most increase in unique products in 2021 vs 2020? 
-- The final output contains these fields, segment product_count_2020 product_count_2021 difference

with cte1 as (
  select 
    p.segment, 
    count(distinct f.product_code) as unique_product_count_2020 
  from 
    fact_sales_monthly f 
    join dim_product p on f.product_code = p.product_code 
  where 
    fiscal_year = 2020 
  group by 
    segment 
), 
cte2 as (
  select 
    p.segment, 
    count(distinct f.product_code) as unique_product_count_2021 
  from 
    fact_sales_monthly f 
    join dim_product p on f.product_code = p.product_code 
  where 
    fiscal_year = 2021 
  group by 
    segment 

) 

select 
cte1.segment,
  unique_product_count_2020, 
  unique_product_count_2021, 
  (
    unique_product_count_2021 - unique_product_count_2020
  ) as difference 
from 
  cte1 
  join cte2 on cte1.segment = cte2.segment
  order by difference desc

