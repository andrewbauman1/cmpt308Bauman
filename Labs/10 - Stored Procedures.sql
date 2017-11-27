---------------------------------------------------------------------
-- Andrew Bauman
--
-- CMPT 308: Database Systems
--
-- Lab Ten: Stored Procedures
----------------------------------------------------------------------

-- #1 --

CREATE OR REPLACE FUNCTION PreReqsFor(int, REFCURSOR) RETURNS refcursor AS
$$
DECLARE
	inputNumber	int       := $1;
	resultSet   REFCURSOR := $2;
BEGIN
	OPEN resultSet for
		SELECT courseNum, preReqNum
		FROM   Prerequisites, Courses
		WHERE  num = PreReqNum
		AND    inputNumber = courseNum;
	RETURN resultSet;
END;
$$
LANGUAGE plpgsql;

SELECT PreReqsFor(308, 'results');
FETCH ALL FROM results;

-- 2 --

CREATE OR REPLACE FUNCTION IsPreReqFor(int, REFCURSOR) RETURNS refcursor AS
$$
DECLARE
	inputNumber int			:= $1;
	resultSet	REFCURSOR	:= $2;
BEGIN
	OPEN resultSet FOR
		SELECT preReqNum, courseNum
		FROM   Prerequisites, Courses
		WHERE  courseNum = num
		AND    inputNumber = PreReqNum;
END;
$$
LANGUAGE plpgsql;

SELECT PreReqsFor(499, 'results');
FETCH ALL FROM results;