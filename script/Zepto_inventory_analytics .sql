-- ZEPTO DATA ANALYTICS
-- Environment: PostgreSQL / pgAdmin 4

drop table if exists zepto;

-- table creation -

create table zepto (
	sku_id serial primary key,
	category varchar(150),
	name varchar(150) not null,
	mrp numeric(8,2),
	discountpercent numeric(5,2),
	availablequantity int,
	discountedsellingprice numeric(8,2),
	weightingms int,
	outofstock boolean,
	quantity int
);

-- imported CSV data into PostgreSQL using pgAdmin's GUI-based Import/Export Data feature
-- without writing a SQL COPY command

select * from zepto
order by sku_id;

-- data exploration

-- Count of rows
select count(sku_id) as total_number_of_rows from zepto;

-- null/missing valu check
select * from zepto
where sku_id is null
	or category is null
	or name is null
	or mrp is null
	or discountpercent is null
	or availablequantity is null
	or discountedsellingprice is null
	or weightingms is null
	or outofstock is null
	or quantity is null;

-- duplicate records check
select sku_id, category, name, mrp, discountpercent, availablequantity, discountedsellingprice, weightingms, outofstock, quantity, count(*)
from zepto
group by sku_id, category, name, mrp, discountpercent, availablequantity, discountedsellingprice, weightingms, outofstock, quantity
having count(*) >1;

-- check different product categories
select distinct category
from zepto
order by category;

-- product in stock vs out of stock
select outofstock, count(sku_id)
from zepto
group by outofstock;

-- product names present multiple times
select name, count(sku_id) as total_number_of_sku
from zepto
group by name
having count(sku_id) >1
order by total_number_of_sku desc;

-- data cleaning

-- product with price = 0
select * from zepto
where mrp = 0 or discountedsellingprice = 0;

-- delete the product which price = 0
delete from zepto
where sku_id = 3607;

-- convert mrp, discountedsellingprice column paise to rupess
update zepto
set mrp = mrp/100.0,
discountedsellingprice = discountedsellingprice/100.0;

select name, mrp, discountedsellingprice from zepto
order by mrp desc;

-- Top 5 Core KPI

-- Q1. Total Inventory Capital:
-- What is the total monetary value of all currently available inventory calculated at actual discounted selling prices?
select sum(availablequantity * discountedsellingprice) as monetary_value
from zepto;

-- Q2. Out-of-Stock (OOS) Rate:
-- What percentage of total product SKUs are currently out of stock across the store?
select 
round(count (case when outofstock='true' then 1 end) * 100.0 / count (*), 2) as out_of_stock_percentage,
round(count (case when outofstock='false' then 0 end) * 100.0 / count (*), 2) as in_stock_percentage
from zepto;

-- Q3. Total Lost Revenue Risk:
-- What is the total estimated sales revenue currently at risk due to out-of-stock items?
select sum(discountedsellingprice) as total_amount_risk_due_to_oos
from zepto
where outofstock = 'true';

-- Q4. Average Catalog Discount:
-- What is the average discount percentage offered across all products?
select round(avg(discountpercent),2) as avg_discount_percent
from zepto;

-- Q5. Total Available Units:
-- How many total physical stock units are currently available in the dark store inventory?
select sum(availablequantity) as total_stock
from zepto;

select * from zepto;

-- Analysis questions -

-- Q1. Find the top 10 products with highest discount precentage
select distinct name, mrp, discountpercent
from zepto
order by discountpercent desc
limit 10;

-- Q2. What are the products with high mrp but out ot stock
select distinct name, mrp, outofstock
from zepto
where outofstock = 'true'
order by mrp desc
limit 10;

-- Q3. Calculate estimated revenue for each category
select distinct category as category_name, sum(discountedsellingprice * availablequantity) as total_revenue
from zepto
group by category
order by total_revenue desc;

-- Q4. Find all products where mrp is gretar than 500 rs and discountpercent is less than 10%
select name, mrp, discountpercent
from zepto
where mrp >500 and discountpercent <10
order by mrp desc, discountpercent desc;

-- Q5. Identify the top 5 categories offering the highest average discount percentage
select distinct category, round(avg(discountpercent),2) as avg_discount_percent
from zepto
group by category
order by avg_discount_percent desc
limit 5;

-- Q6. Find the price per gram for products above 100g and sort by best values
select distinct name, weightingms, discountedsellingprice,
round(discountedsellingprice/weightingms,2) as price_per_gram
from zepto
where weightingms >100
order by price_per_gram
limit 10;

-- Q7. What is the total physical stock quantity and percentage distribution of available inventory across weight categories
       (Low: <=500g, Medium: 501g–1000g, High: >1000g)
select 
case 
    when weightingms <= 500 then 'Low (<=500g)'
    when weightingms <= 1000 then 'Medium (501g-1000g)'
    else 'High (>1000g)'
    end as weight_category,
    sum (availablequantity) as total_units,
    ROUND((sum(availablequantity) * 100.0) / (select sum(availablequantity)
	from zepto), 2) as percentage_share
from zepto
group by
case 
    when weightingms <= 500 then 'Low (<=500g)'
    when weightingms <= 1000 then 'Medium (501g-1000g)'
    else 'High (>1000g)'
    end
order by total_units desc;

-- Q8. What is the total inventory weight per category
select category,
sum (weightingms * availablequantity) as total_weight_in_gms,
round(sum (weightingms * availablequantity) / 1000.0,2) as total_weight_kg
from zepto
group by category
order by total_weight_in_gms desc;

















