---------------------------------------------------------------------
-- Andrew Bauman
--
-- CMPT 308: Database Systems
-- 
-- Lab Three: Getting Started with SQL Queries
----------------------------------------------------------------------
-- List the order number and total dollars of all orders.  	
	
	select ordno, totalusd
	from Orders;
        
-- List the name and city of agents named Smith. 	
	
	select name, city
	from Agents
	where name = 'Smith';
    
-- List the id, name, and price of products with quantity more than 200,010. 
	
	select pid, name, priceusd
	from Products
	where qty > 200010;
    
-- List the names and cities of customers in Duluth. 
	
	select name, city
	from Customers
	where city = 'Duluth';
    
-- List the names of agents not in New York and not in Duluth. 
	
	select name, city
	from Agents
	where city != 'Duluth' AND city != 'New York' ;
    
-- List all data for products in neither Dallas nor Duluth that cost US$1 or more. 
	
	select *
	from Products
	where city != 'Dallas' AND city != 'Duluth' AND priceusd > 1.00 ;
    
-- List all data for orders in March or May. 
	
    select *
	from Orders
	where month = 'May' OR month = 'Mar';

-- List all data for orders in February of US$500 or more. 
	
	select *
	from Orders
	where month = 'Feb' AND totalusd > 500;
    
-- List all orders from the customer whose cid is C005. 
	
	select *
	from Orders
	where cid = 'c005';