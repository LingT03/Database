-- CS3810: Principles of Database Systems
-- Instructor: Thyago Mota
-- Student: Ling Thang
-- Description: a database of tv series

CREATE DATABASE series;

\c series

-- table Actors
CREATE TABLE Actors (
    actorId   SERIAL      PRIMARY KEY,
    actorName VARCHAR(30) NOT NULL,
    sex       CHAR(1)     NOT NULL
);

INSERT INTO Actors (actorName, sex) VALUES ('Keri Russell',        'F');
INSERT INTO Actors (actorName, sex) VALUES ('Matthew Rhys',        'M');
INSERT INTO Actors (actorName, sex) VALUES ('Andrew Lincoln',      'M');
INSERT INTO Actors (actorName, sex) VALUES ('Jon Bernthal',        'M');
INSERT INTO Actors (actorName, sex) VALUES ('Sarah Wayne Callies', 'F');
INSERT INTO Actors (actorName, sex) VALUES ('Scott Speedman',      'M');
INSERT INTO Actors (actorName, sex) VALUES ('Amy Jo Johnson',      'F');
INSERT INTO Actors (actorName, sex) VALUES ('Tangi Miller',        'F');
INSERT INTO Actors (actorName, sex) VALUES ('Jennifer Aniston',    'F');

-- table Series
CREATE TABLE Series (
    seriesId SERIAL      PRIMARY KEY,
    title    VARCHAR(30) NOT NULL
);

INSERT INTO Series (title) VALUES ('The Americans');
INSERT INTO Series (title) VALUES ('The Walking Dead');
INSERT INTO Series (title) VALUES ('Felicity');
INSERT INTO Series (title) VALUES ('Breaking Bad');

-- table Acts
CREATE TABLE Acts (
    seriesId INT NOT NULL,
    actorId  INT NOT NULL,
    PRIMARY KEY (seriesId, actorId),
    FOREIGN KEY (seriesId) REFERENCES Series (seriesId),
    FOREIGN KEY (actorId)  REFERENCES Actors (actorId)
);

-- "The Americans" cast
INSERT INTO Acts VALUES (1, 1);
INSERT INTO Acts VALUES (1, 2);
-- "The Walking Dead" cast
INSERT INTO Acts VALUES (2, 3);
INSERT INTO Acts VALUES (2, 4);
INSERT INTO Acts VALUES (2, 5);
-- "Felicity" cast
INSERT INTO Acts VALUES (3, 1);
INSERT INTO Acts VALUES (3, 6);
INSERT INTO Acts VALUES (3, 7);
INSERT INTO Acts VALUES (3, 8);

-- TODO #1) return all actors/actresses sorted by actorId
    SELECT actorId , actorName From Actors ORDER BY 1;
    -- Selects id and name from actors table and order by id 

    /* 
    returns: 

     actorid |      actorname      
    ---------+---------------------
           1 | Keri Russell
           2 | Matthew Rhys
           3 | Andrew Lincoln
           4 | Jon Bernthal
           5 | Sarah Wayne Callies
           6 | Scott Speedman
           7 | Amy Jo Johnson
           8 | Tangi Miller
           9 | Jennifer Aniston
    (9 rows)
    */

-- TODO #2) return all actresses sorted by actorName
    SELECT actorName, sex, actorId From Actors WHERE sex = 'F' ORDER BY 1;
    -- Selects * from Actors who are female and order by name

    /* 
    returns: 
          actorname      | sex | actorid 
    ---------------------+-----+---------
     Amy Jo Johnson      | F   |       7
     Jennifer Aniston    | F   |       9
     Keri Russell        | F   |       1
     Sarah Wayne Callies | F   |       5
     Tangi Miller        | F   |       8
    (5 rows)
    */

-- TODO #3) return the counts of actors and actress using two columns: 'sex' and 'total', sorted by sex
    SELECT sex, Count(*) as total From Actors GROUP BY 1 ORDER BY 1;
    -- Selects sex from Actors, counts total, and groups and orders table by sex 

    /* 
    returns: 
     sex | total 
    -----+-------
     F   |     5
     M   |     4
    (2 rows)
    */

-- TODO #4) return the names of the actors/actresses that were in 'The Americans' sorted by actorName
    SELECT actorName From Actors WHERE actorId IN (SELECT actorId FROM Acts WHERE seriesId = 1) ORDER BY 1;
    -- Selects name from Actors table where id is in acts table where seriesId = 1 and order by name

    /* 
    returns: 
    actorname   
    --------------
    Keri Russell
    Matthew Rhys
    (2 rows)
    */

-- TODO #5) return the names of actors/actresses that didn't appear in any series sorted by actorName
    SELECT actorName From Actors WHERE actorId NOT IN (SELECT actorId FROM Acts) ORDER BY 1;
    -- Selects name from Actors table where id is not in acts table and order by name

    /* 
    returns: 
        actorname     
    ------------------
    Jennifer Aniston
    (1 row)
    */
