---------------------------------------------------------------------
-- Andrew Bauman
--
-- CMPT 308: Database Systems
-- 
-- Lab Five: SQL Queries: The Joins Three-quel
----------------------------------------------------------------------

-- #1 --  

SELECT a.city
FROM orders o INNER JOIN agents a ON o.cid = 'c006' AND o.aid = a.aid;
             
-- #2 --  

SELECT p.pid
FROM ((Orders o INNER JOIN Customers c ON o.cid = c.cid)
		INNER JOIN Products ON o.pid = p.pid)
WHERE c.city = 'Beijing';
	 
	
-- #3 -- 

SELECT name
FROM customers
WHERE NOT cid IN (SELECT cid
		    	  FROM orders);

-- #4 --

SELECT c.name
FROM customers c LEFT OUTER JOIN Orders o ON c.cid = o.cid
WHERE o.cid IS NULL;
            
-- #5 -- 

SELECT DISTINCT c.name, a.name
FROM ((Orders o INNER JOIN Customers c ON o.cid = c.cid) INNER JOIN Agents a ON o.aid = a.aid)
WHERE c.city = a.city;


-- #6 -- 

SELECT DISTINCT c.name, a.name, c.city
FROM customers c, agents a
WHERE c.city = a.city;

                       
-- #7 -- 

SELECT c.name, c.city
FROM customers c
WHERE c.city in (SELECT city
		 		 FROM products
		 		 GROUP BY City
		 		 ORDER BY COUNT(pid) ASC
				 Limit 1);