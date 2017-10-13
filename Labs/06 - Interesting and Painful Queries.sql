---------------------------------------------------------------------
-- Andrew Bauman
--
-- CMPT 308: Database Systems
--
-- Lab Six: Interesting and Painful Queries
----------------------------------------------------------------------

-- #1 --

SELECT c.name, c.city
FROM customers c
WHERE c.city IN (SELECT city
		 		 FROM products
		 		 GROUP BY City
		 		 ORDER BY COUNT(pid) DESC
				 LIMIT 2);

-- #2 --

SELECT name
FROM products p
WHERE priceUSD >= (SELECT avg(priceUSD)
				    FROM products)
ORDER BY p.name DESC;

-- #3 --

SELECT c.name, o.pid, o.totalUSD
FROM customers c, orders o
WHERE c.cid = o.cid
ORDER BY o.totalUSD DESC;


-- #4 --

SELECT c.name, sum(COALESCE(o.quantity, 0)) AS "totalOrdered"
FROM orders o INNER JOIN customers c ON c.cid = o.cid
GROUP BY o.cid, c.name
ORDER BY c.name DESC;

-- #5 --

SELECT c.name, p.name, a.name
FROM orders o INNER JOIN customers c ON o.cid = c.cid
			  INNER JOIN products p ON o.pid = p.pid
			  INNER JOIN agents a ON o.aid = a.aid
WHERE c.cid IN (SELECT cid
			  	FROM orders o INNER JOIN agents a ON a.aid = o.aid
			  	WHERE a.city = 'Newark');

-- #6 --

SELECT *
FROM (SELECT o.*, (o.quantity * p.priceUSD * (1-(discountPct/100))) AS dollarcheck
	  FROM orders o INNER JOIN products p ON o.pid = p.pid
              		INNER JOIN customers c ON o.cid = c.cid) AS table1
WHERE totalusd != dollarcheck;

-- #7 --
/* LEFT OUTER JOIN and RIGHT OUTER JOIN are both keywords in SQL which combine the columns of two different tables.
 *
 * LEFT OUTER JOINs retain all columns in the first table referenced in a join statement whether or not a value
 * exists in a specific record. The opposite occurs in a RIGHT OUTER JOIN where all columns in the second table
 * referenced in the join statement are retained, again whether or not a value exists in a specific record.
 *
 * For example, the query:
 * SELECT *
 * FROM Orders o LEFT OUTER JOIN Products p ON o.pid = p.pid
 *
 * would result in a combination of the two tables and could be used to, technically, determine if there are any
 * orders containing products that do not exist. Such records would have NULLs in all the product fields.
 * (Recognizing orders containing non-existing products wouldn't typically exist.)
 *
 * Alternatively, the query:
 * SELECT *
 * FROM Orders o RIGHT OUTER JOIN Products p ON o.pid = p.pid
 *
 * would result in a combination of the two tables and could be used to determine if their are any products which
 * have never been ordered as any such records would have NULLs in all the order fields.
 */
