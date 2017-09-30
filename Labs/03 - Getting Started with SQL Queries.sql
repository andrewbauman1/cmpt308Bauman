---------------------------------------------------------------------
-- Andrew Bauman
--
-- CMPT 308: Database Systems
-- 
-- Lab Three: Getting Started with SQL Queries
----------------------------------------------------------------------
-- #1 List the order number and total dollars of all orders.  (Correct)	
	
	select ordno, totalusd
	from Orders;
        
-- #2 List the name and city of agents named Smith. (Correct)	
	
	select name, city
	from Agents
	where name = 'Smith';
    
-- #3 List the id, name, and price of products with quantity more than 200,010. (Correct)
	
	select pid, name, priceusd
	from Products
	where qty > 200010;
    
-- #4 List the names and cities of customers in Duluth. (Correct)
	
	select name, city
	from Customers
	where city = 'Duluth';
    
-- #5 List the names of agents not in New York and not in Duluth. (Correct)
	
	select name
	from Agents
	where city != 'Duluth' AND city != 'New York' ;
	
	-- DeMorgan's Law
	
	select name
	from Agents
	where not (city = 'New York' or city = 'Duluth');
	
	-- Other
	
	select name
	deom Agents
	where city not in ('New York', 'Duluth');
    
-- #6 List all data for products in neither Dallas nor Duluth that cost US$1 or more. (Wrong, needed >=, not just >) 
	
	select *
	from Products
	where city != 'Dallas' AND city != 'Duluth' AND priceusd > 1.00 ;
	
	--Correct Version
	select *
	from Products
	where city not in ('Dallas', 'Duluth')
	  and priceusd >= 1.00;
    
-- #7 List all data for orders in March or May. (Correct)
	
    select *
	from Orders
	where month = 'May' OR month = 'Mar';
	
-- #8 List all data for orders in February of US$500 or more. (Needed to include $500, therefore needed >=, not just >)
	
	select *
	from Orders
	where month = 'Feb' AND totalusd >= 500;
	
-- #9 List all orders from the customer whose cid is C005. 
	
	select *
	from Orders
	where cid = 'c005';