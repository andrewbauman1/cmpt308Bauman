---------------------------------------------------------------------
-- Andrew Bauman
--
-- CMPT 308: Database Systems
--
-- Lab Eight: Normalization Two
----------------------------------------------------------------------

-- #1 --
DROP TABLE IF EXISTS People, Actors, Directors, Movies, ActsIn, Directs

-- People --
CREATE TABLE People (
  pid 		  bigserial not null,
  firstName	  text not null,
  lastName	  text not null,
  address	  text,
  birthDate	  date, -- YYYY-MM-DD
);
-- Actors --
CREATE TABLE Actors (
  aid int references people(pid),
  hairColor	  		text,
  eyeColor	  		text,
  heightInInches   	decimal(2,2),
  weightInPounds   	decimal(3,2),
  spouseName	 	text,
  favoriteColor 	text,
  actorsGuildAnniversary  date,
 primary key(pid)
);

-- Directors --
CREATE TABLE Directors (
  did int references people(pid)  not null,
  firstName  				 text not null,
  lastName   				 text not null,
  filmSchoolAttended 		 text),
  directorsGuildAnniversary	 text,
  favoriteLensMaker			 text,
  primary key(pid)
);

-- Movies --
CREATE TABLE Movies (
  mid				bigserial not null,
  title				text not null,
  yearReleased		year not null,
  MPAANumber		int,
  domesticBoxSales  int,
  foreignBoxSales   int,
  DVDSales    		int,
  primary key(mid)
);

-- actsIn --
CREATE TABLE ActsIn (
  pid not null references agents(pid),
  mid not null references movies(mid)
);

-- Directs --
CREATE TABLE Directs (
  pid not null references directors(pid),
  mid not null references movies(mid)
);

-- Dependencies --
pid -> firstName
pid ->lastName
pid -> address
pid -> birthDate

aid -> hairColor
aid -> eyeColor
aid -> heightInInches
aid -> weightInPounds
aid -> spouseName
aid -> favoriteColor
aid -> actorsGuildAnnivresary

did -> filmSchoolAttended
did -> directorsGuildAnniversary
did -> favoireLensMaker

mid -> title
mid -> yearRelease
mid -> MPAANumber
mid -> domesticBoxSales
mid -> foreignBoxSales
mid -> DVDSales

-- Query: Show all the directors with whom actor “Roger Moore” has worked --
SELECT DISTINCT people.* 
FROM people, movies, directors, directs
WHERE people.pid = directors.did
AND directors.did = directs.did
and directs.mid in (SELECT DISTINCT movies.mid
					FROM people, movies, actors, actsIn
					WHERE people.firstName = 'Roger'
					AND people.lastName = 'Moore'
					AND people.pid = actors.aid
					AND actors.aid = actsIn.aid
					);
