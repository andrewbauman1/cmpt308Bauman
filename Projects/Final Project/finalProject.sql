----------------------------------------------------------------------------------------
-- Postgres create, load, and query scripts for Marist Music Dept. DB.
-- Created by Andrew bauman (andrew.bauman1@marist.edu)
-- December 2017 
----------------------------------------------------------------------------------------

DROP TABLE IF EXISTS People;
DROP TABLE IF EXISTS Musicians;
DROP TABLE IF EXISTS Instrumentalists;
DROP TABLE IF EXISTS Vocalists;
DROP TABLE IF EXISTS Directors;
DROP TABLE IF EXISTS Administrators;
DROP TABLE IF EXISTS Department_Roles;
DROP TABLE IF EXISTS Member_Of;
DROP TABLE IF EXISTS Can_Play;
DROP TABLE IF EXISTS Directs_In;
DROP TABLE IF EXISTS Ensembles;
DROP TABLE IF EXISTS Rehearses_In;
DROP TABLE IF EXISTS Performs_In;
DROP TABLE IF EXISTS Locations;
DROP TABLE IF EXISTS Instruments;
DROP TABLE IF EXISTS Songs_Playing;
DROP TABLE IF EXISTS Literature;

-- Customers --
CREATE TABLE People (
  person_id       char(8) not null,
  firstName       text not null,
  lastName        text not null,
  dateOfBirth	    date,
  phoneNumber	    text,
  address	        text,
  emailAddress	  text not null,
 primary key(person_id)
);

CREATE TABLE Musicians (
  person_id	 	          char(8) not null references People(person_id),
  expectedGradSemester  text, --Restraint needed
  favoriteClef	        text,
  favoriteGenre	        text, --Possible Restraints
 primary key(person_id)
);

CREATE TABLE Instrumentalists (
  person_id	            char(8) not null references Musicians(person_id),
 primary key(person_id)
);

CREATE TABLE Vocalists (
  person_id	char(8) not null references Musicians(person_id),
  vocalRange	text,
 primary key(person_id)
);

CREATE TABLE Directors (
  person_id	char(8) not null references People(person_id),
  almaMater	text,
  favoriteCigaretteBrand	text,
  favoriteCoffeeBlend	text,
 primary key(person_id)
);

CREATE TABLE Department_Roles (
  role_id	char(4) not null,
  roleName	text,
  hourlyRate	numeric(10,2),
  salary	numeric(10,2),
  jobDesc	text,
 primary key (role_id)
);

CREATE TABLE Administrators (
  person_id char(8) not null references People(person_id),
  role_id	char(4) not null references Department_Roles(role_id),
 primary key(person_id)
);

CREATE TABLE Ensembles (
  ensemble_id	char(5) not null,
  ensembleName	text,
 primary key(ensemble_id)
);

CREATE TABLE Instruments (
  instrument_id	    char(4) not null,
  instrumentName    text not null,
  instrumentFamily  text not null,
 primary key(instrument_id)
);

CREATE TABLE Member_of (
  person_id	char(8) not null references Musicians(person_id),
  ensemble_id	char(5) not null references Ensembles(ensemble_id),
  instrument_id	char(4) references Instruments(instrument_id),
 primary key(person_id, ensemble_id)
);

CREATE TABLE Can_Play (
  person_id	char(8) not null references Instrumentalists(person_id),
  instrument_id  char(4) not null references Instruments(instrument_id),
 primary key(person_id, instrument_id)
);

CREATE TABLE Directs_In (
  person_id	char(8) not null references Directors(person_id),
  ensemble_id	char(5) not null references Ensembles(ensemble_id),
 primary key(person_id, ensemble_id)
);

CREATE TABLE Locations (
  location_id	char(4) not null,
  roomName	text,
  maxCapacity	text,
 primary key(location_id)
);

CREATE TABLE Rehearses_In (
  ensemble_id	char(5) not null references Ensembles(ensemble_id),
  location_id	char(4)	not null references Locations(location_id),
  dayOfTheWeek	text not null, --CheckRestraints
  startTime	time not null,
  endTime	time not null,
 primary key(ensemble_id)
);

CREATE TABLE Performs_In (
  ensemble_id	char(5) not null references Ensembles(ensemble_id),
  eventDate	 	date not null,
  location_id	char(4) not null references Locations(location_id),
  eventTime	time not null,
 primary key(ensemble_id, eventDate)
);

CREATE TABLE Literature (
  lit_id	char(5) not null,
  songTitle	text,
  genre	text,
 primary key(lit_id)
);

CREATE TABLE Songs_Playing (
  ensemble_id	char(5) not null references Ensembles(ensemble_id),
  lit_id	char(5) not null references Literature(lit_id),
 primary key(ensemble_id, lit_id)
);

-- IMPORTING DATA
INSERT INTO People(person_id, firstName, lastName, dateOfBirth, address, phoneNumber, emailAddress)
VALUES('20083100', 'Andrew', 'Bauman', '1998-03-01', '3399 North Road', '845-123-4567',  'andrew.bauman1@marist.edu'),
      ('20083101', 'Marsha', 'Mellow', '1999-05-14', '132 Market Lane', '660-948-9199', 'm.mellow@email.com'),
      ('20083102', 'Cadence', 'Smith', '1997-08-13', '2455 Spring Row', '309-962-4101',  'csmith@gmail.com'),
      ('20083103', 'Adagio', 'Turner', '1997-04-28', '24 Phoenix Route','330-569-9560',  'adagio@gmail.com'),
      ('20083104', 'Melody', 'Wind', '1998-02-14', '49 Kingwood Passage', '571-814-6974',  'MelodyWind123@gmail.com'),
      ('20083105', 'I.M.', 'Tired', '1998-12-25', '13 Orchard Lane',  '202-956-8464',  'TiredIm@gmail.com'),
      ('20083106', 'Rita', 'Book', '1999-01-24', '464 South Row', '401-534-7890',  'ritab@yahoo.com'),
      ('20083107', 'Isabelle', 'Ringing', '1999-05-20', '90 Bridgewater Lane', '304-914-5975',  'bellsRinging@aol.com'),
      ('20083108', 'Maureen', 'Biologist', '1996-03-23', '24 Grime Lane', '305-668-9127', 'dolphin6132@hotmail.com'),
      ('20083109', 'Ann', 'Chovey', '1999-07-21', '242 Royalty Boulevard', '762-222-4549', 'choveya@ibm.com'),
      ('20083110', 'Johnny', 'Cash', '1998-05-21', '24 Polygon Avenue',  '610-570-7873',  'jcash@gmail.com'),
      ('30042001', 'Alan', 'Labouseur', '1980-01-01', '191 Marist Drive', '845-575-3832', 'alan@labouseur.com'),
      ('30042002', 'Art', 'Himmelberger', '1953-11-28', '3399 North Road',  '845-575-3000 ext. 2839',  'arthur.himmelberger@marist.edu'),
      ('30042003', 'Sarah', 'Williams', '1975-04-24', '3399 North Road',  '845-575-3000 ext. 2944',  'sarah.williams@marist.edu'),
      ('30042004', 'Mikey', 'Napolitano', '1983-03-23', '3399 North Road',  '845-575-3000 ext. 2142',  'michael.napolitano@marist.edu'),
      ('30042005', 'MusicStaff', 'MemberOne', '1999-02-23', '3399 North Road',  '845-575-3000',  'music@marist.edu');

INSERT INTO Department_Roles(role_id, roleName, hourlyRate, salary, jobDesc)
VALUES('0001', 'Director of Music and Director of Bands', Null, '73000.00', 'Responsible for the management and direction of the Marist Band and Music Department'),
      ('0002', 'Director of Choral Activities', Null, '75000.00', 'Responsible for the management and direction of the Marist Singers Program and related ensembles'),
      ('0003', 'Operations Manager', '18.00', Null, 'Manages the operations regarding the Marist Music Department');

INSERT INTO Administrators(person_id, role_id)
VALUES('30042002', '0001'),
      ('30042003', '0002'),
      ('30042004', '0003');

INSERT INTO Musicians(person_id, expectedGradSemester, favoriteClef, favoriteGenre)
VALUES('20083100', 'Spring 2020', 'Bass', 'Funk'), --instrumentalist
      ('20083101', 'Fall 2019', 'Treble', 'Pop'), --instrumentalist / vocalist
      ('20083102', 'Spring 2018', 'Tenor', 'Marches'), --instrumentalist
      ('20083103', 'Spring 2021', 'Treble', 'Classical'), --instrumentalist
      ('20083104', 'Fall 2020', 'Bass', 'Jazz'), --instrumentalist
      ('20083105', 'Fall 2020', 'TAB', 'Hard Rock'), --instrumentalist
      ('20083106', 'Spring 2019', 'Treble', 'Swing'), --vocalist
      ('20083107', 'Fall 2018', 'Bass', 'Soft Rock'), --vocalist
      ('20083108', 'Spring 2018', 'Bass', 'Jazz'), --vocalist
      ('20083109', 'Fall 2021', 'Treble', 'Pop'), --vocalist
      ('20083110', 'Spring 2019', 'Tenor', 'Metal'); --vocalist

INSERT INTO Instrumentalists(person_id)
Values('20083100'), ('20083101'), ('20083102'), ('20083103'), ('20083104'), ('20083105');

INSERT INTO Vocalists(person_id, vocalRange)
Values('20083106', 'Tenor'), ('20083107', 'Soprano'), ('20083108','Baritone'), ('20083109','Alto'), ('20083101','Baritone'), ('20083110','Alto');

INSERT INTO Directors(person_id, almaMater, favoriteCigaretteBrand, favoriteCoffeeBlend)
VALUES('30042002', 'University of Michigan', 'Lucky Strike Menthol', 'black'),
      ('30042003', 'Music U', Null, 'Starbucks Holiday Blend'),
      ('30042001', 'Marist College', Null, Null);

INSERT INTO Ensembles(ensemble_id, ensembleName)
VALUES('00001', 'Symphonic Band'),
      ('00002', 'Wind Symphony'),
      ('00003', 'Orchestra'),
      ('00004', 'Jazz Foxes'),
      ('00005', 'Brass Ensemble'),
      ('00006', 'Flute Choir'),
      ('00007', 'Marist Singers'),
      ('00008', 'Time Check'),
      ('00009', 'Sirens'),
      ('00010', 'Pit Band'),
      ('00011', 'Computer Society');

INSERT INTO Instruments(instrument_id, instrumentName, instrumentFamily)
VALUES('0001', 'Euphonium', 'Brass'),
      ('0002', 'Trombone', 'Brass'),
      ('0003', 'Clarinet', 'Woodwind'),
      ('0004', 'Flute', 'Woodwind'),
      ('0005', 'Drums', 'Percussion'),
      ('0006', 'Harpsichord', 'Keyboards'),
      ('0007', 'Tenor Sax', 'Woodwind'),
      ('0008', 'Baritone Sax', 'Woodwind'),
      ('0009', 'Apple II', 'Keyboards'),
      ('0010', 'Marimba', 'Percussion');

INSERT INTO Can_Play(person_id, instrument_id)
VALUES('20083100', '0001'),
      ('20083100', '0002'),
      ('20083101', '0004'),
      ('20083102', '0003'),
      ('20083103', '0006'),
      ('20083104', '0008'),
      ('20083105', '0010');

INSERT INTO Directs_In(person_id, ensemble_id)
VALUES('30042002', '00001'),
      ('30042002', '00002'),
      ('30042002', '00003'),
      ('30042002', '00004'),
      ('30042002', '00005'),
      ('30042002', '00006'),
      ('30042002', '00010'),
      ('30042003', '00007'),
      ('30042003', '00008'),
      ('30042003', '00009'),
      ('30042001', '00011');

INSERT INTO Member_Of(person_id, ensemble_id, instrument_id)
VALUES('20083100', '00001', '0001'),
      ('20083100', '00002', '0002'),
      ('20083101', '00003', '0004'),
      ('20083101', '00006', '0004'),
      ('20083101', '00002', '0004'),
      ('20083102', '00001', '0003'),
      ('20083102', '00002', '0003'),
      ('20083102', '00003', '0003'),
      ('20083103', '00003', '0006'),
      ('20083104', '00001', '0008'),
      ('20083104', '00002', '0008'),
      ('20083104', '00003', '0008'),
      ('20083105', '00004', '0010'),
       --All Instrumentalists Added, need singers
      ('20083106', '00007', NULL),
      ('20083107', '00008', NULL),
      ('20083107', '00007', NULL),
      ('20083108', '00009', NULL),
      ('20083108', '00007', NULL),
      ('20083109', '00010', NULL),
      ('20083109', '00007', NULL),
      ('20083110', '00007', NULL);

INSERT INTO Locations(location_id, roomName, maxCapacity)
Values ('0001', 'Symphonic Hall', '410'),
       ('0002', 'Fusco Recital Hall', '314'),
       ('0003', 'Nelly Golleti Theatre', '400'),
       ('0004', 'River Rooms', '350'),
       ('0005', 'Bardavon', '800'),
       ('0006', 'CIA Recital Hall', '900'),
       ('0007', 'Longview Park', '1000'),
       ('0008', 'The Caberet', '210'),
       ('0009', 'HC2020', '40'),
       ('0010', 'Small Ensembles Room', '100');

INSERT INTO Rehearses_In(ensemble_id, location_id, dayOfTheWeek, startTime, endTime)
VALUES ('00001', '0001', 'Monday', '8:00pm', '10:00pm'),
       ('00002', '0001', 'Thursday', '9:00pm', '11:00pm'),
       ('00003', '0001', 'Wednesday', '6:30pm', '8:30pm'),
       ('00004', '0010', 'Wednesday', '9:00pm', '11:30pm'),
       ('00005', '0010', 'Friday', '6:00pm', '8:00pm'),
       ('00006', '0010', 'Wednesday', '9:00pm', '11:30pm'),
       ('00007', '0002', 'Monday', '5:30pm', '7:45pm'),
       ('00008', '0002', 'Tuesday', '7:00pm', '8:45pm'),
       ('00009', '0002', 'Monday', '8:00pm', '10:00pm');

INSERT INTO Performs_In(ensemble_id, eventDate, location_id, eventTime)
VALUES ('00001', '2017-12-02', '0003', '2:00pm'),
       ('00001', '2017-12-03', '0005', '7:00pm'),
       ('00003', '2017-12-03', '0003', '2:00pm'),
       ('00004', '2017-12-25', '0005', '12:00am'),
       ('00010', '2018-05-05', '0010', '4:23am');

INSERT INTO Literature(lit_id, songTitle, genre)
VALUES ('00001', 'Sleigh Ride', 'Christmas'),
       ('00002', 'The Marist College Fight Song', NULL),
       ('00003', 'The Marist Song', NULL),
       ('00004', 'The Great Locomotive Chase', NULL),
       ('00005', 'Everlong', NULL),
       ('00006', 'We Wish you a Merry Christmas', 'Christmas'),
       ('00007', 'First Suite in E Flat', NULL),
       ('00008', 'PC Beep Codes', NULL),
       ('00009', 'The Planets', NULL),
       ('00010', 'All Star', NULL);

INSERT INTO Songs_Playing(ensemble_id, lit_id)
VALUES ('00001', '00001'),
       ('00001', '00002'),
       ('00001', '00007'),
       ('00002', '00004'),
       ('00002', '00003'),
       ('00002', '00006'),
       ('00002', '00010'),
       ('00011', '00008'),
       ('00007', '00002'),
       ('00007', '00003'),
       ('00008', '00006'),
       ('00009', '00010'),
       ('00003', '00009');

-- Lists the administrators, their roles, and contact information.
CREATE VIEW v_Administrators AS
	SELECT firstName, lastName, roleName, emailAddress
	FROM People, Administrators, Department_Roles
	WHERE people.person_id = administrators.person_id
	AND administrators.role_id = department_roles.role_id;

select * from v_Administrators;

-- Lists the musicians in the band program
CREATE VIEW v_BandMembers AS
	SELECT firstName, lastname, expectedGradSemester, instrumentName
    FROM People p, Musicians m, Instrumentalists i, Can_Play, Instruments
    WHERE p.person_id = m.person_id
    AND m.person_id = i.person_id
    AND i.person_id = Can_Play.person_id
    AND Can_Play.instrument_id = Instruments.instrument_id
    Order by lastname ASC;

select * from v_BandMembers;

-- Lists the musicians in the Singers program
CREATE VIEW v_Singers AS
	SELECT firstName, lastName, expectedGradSemester, vocalRange
    FROM People p, Musicians m, Vocalists v
    WHERE p.person_id = m.person_id
    AND m.person_id = v.person_id
    Order by lastname ASC;

select * from v_Singers

-- Yields a roster for a given ensemble
CREATE OR REPLACE FUNCTION MembersIn(char(5), REFCURSOR) RETURNS refcursor AS
$$
DECLARE
	inputNumber	char(5)       := $1;
	resultSet   REFCURSOR 	  := $2;
BEGIN
	OPEN resultSet for
		SELECT firstName, lastName, expectedGradSemester
		FROM   People p, Musicians m, Member_Of, Ensembles
		WHERE  p.person_id = m.person_id
		AND    m.person_id = member_of.person_id
    AND	   member_of.ensemble_id = ensembles.ensemble_id
    AND	   ensembles.ensemble_id = inputNumber;
	RETURN resultSet;
END;
$$
LANGUAGE plpgsql;

SELECT MembersIn('00001', 'results');
FETCH ALL FROM results;

-- Yields the locations a specified ensemble performs in
CREATE OR REPLACE FUNCTION PerformsIn(char(4), REFCURSOR) RETURNS refcursor AS
$$
DECLARE
	inputNumber	char(4)       := $1;
	resultSet   REFCURSOR 	  := $2;
BEGIN
	OPEN resultSet for
		SELECT eventDate, eventTime, ensembleName
		FROM Ensembles e, Performs_In, Locations l
		WHERE l.location_id = performs_In.location_id
		AND e.ensemble_id = performs_In.ensemble_id
		AND l.location_id = inputNumber;
	RETURN resultSet;
END;
$$
LANGUAGE plpgsql;

SELECT PerformsIn('0003', 'results');
FETCH ALL FROM results;

-- Stored Procedure to Output a Message
CREATE OR REPLACE FUNCTION r(errorMsg text) RETURNS VOID AS
$$
BEGIN
    RAISE NOTICE '%', errorMsg;
end;
$$
LANGUAGE plpgsql;

select r('an error message');



-- REPORT/InterestingQuery1: See which songs a specific ensemble is Songs_PlayingSELECT songTitle
SELECT songTitle
FROM Literature l, Songs_Playing s, Ensembles e
WHERE l.lit_id = s.lit_id
AND s.ensemble_id = e.ensemble_id
AND e.ensemble_id = '00001';

-- REPORT/Interesting Query 1: See where and when a specific ensemble rehearses
SELECT dayOfTheWeek, startTime, endTime, roomName
FROM Ensembles e, Rehearses_In r, Locations l
WHERE l.location_id = Rehearses_In.location_id
AND e.ensemble_id = Rehearses_In.ensemble_id
AND e.ensemble_id = '00001';

-- TRIGGERS
CREATE OR REPLACE FUNCTION saveAlan() RETURNS TRIGGER AS $$
BEGIN
	IF OLD.firstName = 'Alan'AND OLD.lastName = 'Labouseur'
    THEN RAISE EXCEPTION 'CANNOT DELETE ALAN, THE GREATEST DATABASE PROFESSOR WHO EVER LIVED';
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER savingAlan BEFORE DELETE ON People
FOR EACH ROW EXECUTE PROCEDURE saveAlan();

DELETE FROM People
where lastName = 'Labouseur';

-- SECURITY
CREATE ROLE Administrator;
GRANT ALL ON ALL TABLES
IN SCHEMA PUBLIC TO Administrator;

CREATE ROLE OfficeStaff;
GRANT SELECT, INSERT, UPDATE ON ALL TABLES
IN SCHEMA PUBLIC TO OfficeStaff;

CREATE ROLE Eboard;
REVOKE ALL ON ALL TABLES IN SCHEMA PUBLIC FROM Eboard;
GRANT SELECT ON Musicians, Instrumentalists, Vocalists,
				Can_Play, Instruments, Member_Of, Ensembles,
                Rehearses_In, Performs_In, Locations, Literature,
                Songs_Playing
                TO Eboard;

-- Implementation Notes / Known Problems / Future Enhancements
-- The purpose of this database system is to manage many of the daily bookkeeping tasks for the
-- Marist College Music Department. If this database were fully implemented, person_id would most
-- likely be replaced by a CWID number, which it is already equipped to handle.

-- Known Problems: As of this moment, there is no way to confirm that the instruments a student
-- is playing in an ensemble is one of the instruments they have reported knowing how to play.-

-- Future Enhancements: This is a small-scale representation of what the larger, fully developed
-- database would look like. If someone were to continue developing this project, I would imagine
-- the database would have more check constraints to ensure the database remain normalized. Additionally
-- more views and stored procedures should exist to allow for a simplified user experience.
-- The developer can also take into account semesters, in that, some ensembles may not be offered
-- every semester. Additional data could be tracked for Literature, such as instrument parts,
-- how many times a piece has been performed, the last time a piece has been performed, etc.
-- The database could also begin to handle Timeclock and payroll information for office staff members.
