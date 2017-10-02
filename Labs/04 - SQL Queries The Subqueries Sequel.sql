---------------------------------------------------------------------
-- Andrew Bauman
--
-- CMPT 308: Database Systems
-- 
-- Lab Four: SQL Queries: The Subqueries Sequel
----------------------------------------------------------------------

-- #1 --  
select city
from Agents
where aid in (select aid
              from Orders
              where cid = 'c006');
             
-- #2 --
select distinct pid
from Orders
where aid in (select aid
              from Orders
              where cid = 'c006')
order by pid ASC;

-- #3 --
select distinct cid,name
from Customers
where cid not in (select cid
			      from Orders
			      where aid = 'a03');
              
-- #4 --
select distinct cid
from Orders
where cid in (select cid
              from orders 
              where pid = 'p01')
and cid in (select cid
            from orders
            where pid = 'p07');
            
-- #5 --
select distinct pid
from products
where pid not in (select pid
                 from orders
                 where aid in ('a02','a03'))
order by pid ASC;

-- #6 --
select name, discountPct, city
from customers
where cid in (select cid
              from Orders
              where aid in (select aid
              			    from Agents
              				where city in ('Tokyo', 'New York')));
                       
-- #7 --
select *
from Customers
where discountpct in (select discountpct
                      from customers
                      where city in ('Duluth','London'));
                      
-- #8 --
/* Check constraints allow you to define enumerations to limit the value ranges that may be entered within a database. 
 * This is particularly avantaegous as it reduces the chance of the user entering incorrect data into a field.
 * Additionally, they also help maintain uniformity within the database itself.
 * For example, if the user were working with something pertaining to days of the week, a check restraint 
 * could be placed only permitting days of the week to be entered into the dateField. However, a check restraint
 * does not (and should not) be used in all scenarios. For instance, one would not use a check restraint for
 * data fields where first and/or last names are being entered. Unless they are only dealing with people with 
 * only a few names, there are too many names that exist to limit the choices the user has. Accordingly, check 
 * restraints are NOT required when fields don't have to be limited or there are too many options to limit them to.
 */