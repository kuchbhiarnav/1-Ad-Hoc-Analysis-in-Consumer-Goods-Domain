-- Which channel helped to bring more gross sales in the fiscal year 2021 
-- and the percentage of contribution? 
-- The final output contains these fields, channel gross_sales_mln percentage


with cte1 as -- cte1 = channel wise sales
(
  select d.channel, round(sum(g.gross_price * f.sold_quantity)/1000000,2) as gross_sales_mln
  from fact_sales_monthly f
	join dim_customer d
	on f.customer_code = d.customer_code
	join fact_gross_price g
	on f.product_code = g.product_code
   where f.fiscal_year = 2021
   group by d.channel
),
cte2 as -- cte2 = total sales
(
  select  round(sum(g.gross_price * f.sold_quantity)/1000000,2) as total_sales_mln
  from fact_sales_monthly f
  join fact_gross_price g
  on f.product_code = g.product_code
  where f.fiscal_year = 2021
)
select cte1.channel, cte1.gross_sales_mln, -- gross sales in millions?
  round(100.0 * cte1.gross_sales_mln / cte2.total_sales_mln, 2) as percentage
from cte1
cross join cte2
order by percentage desc 
-- cte1.gross_sales_mln desc

