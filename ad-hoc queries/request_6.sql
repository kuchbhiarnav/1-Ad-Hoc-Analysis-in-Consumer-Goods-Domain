-- Generate a report which contains the top 5 customers 
-- who received an average high pre_invoice_discount_pct for the fiscal year 2021 and in the Indian market. 
-- The final output contains these fields, customer_code customer average_discount_percentage

select 
  f.customer_code, 
  d.customer, 
  round(
    avg(pre_invoice_discount_pct)*100, 
    2
  ) as average_discount_percentage 
from 
  dim_customer d 
  join fact_pre_invoice_deductions f on d.customer_code = f.customer_code 
where 
  fiscal_year = 2021 
  and market = "India" 
group by 
  customer_code 
order by 
  average_discount_percentage desc, customer asc 
limit 5

