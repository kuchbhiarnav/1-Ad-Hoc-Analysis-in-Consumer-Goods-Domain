-- What is the percentage of unique product increase in 2021 vs. 2020? 
-- The final output contains these fields, unique_products_2020 unique_products_2021 percentage_chg
--  select * from fact_sales_monthly;

with cte1 as (
  select 
    count(distinct product_code) as unique_products_2020 
  from 
    fact_sales_monthly 
  where 
    fiscal_year = 2020
), 
cte2 as (
  select 
    count(distinct product_code) as unique_products_2021 
  from 
    fact_sales_monthly 
  where 
    fiscal_year = 2021
) 
SELECT 
  *, 
  (
    unique_products_2021 - unique_products_2020
  ) * 100 / unique_products_2020 as percentage_chg 
from 
  cte1, 
  cte2

