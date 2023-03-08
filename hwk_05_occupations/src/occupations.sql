-- CS3810: Principles of Database Systems
-- Instructor: Thyago Mota
-- Student: 
-- Description: a database of occupations

CREATE DATABASE occupations;

\c occupations

DROP TABLE IF EXISTS Occupations;

-- TODO: create table Occupations
    CREATE TABLE Occupations (
        code VARCHAR(10),
        occupation VARCHAR(100),
        "job_family" VARCHAR(100)
    );
-- TODO: populate table Occupations
\COPY Occupations(Code, Occupation, "Job Family") FROM '/var/lib/postgresql/data/occupations.csv' DELIMITER ',' QUOTE '"' CSV HEADER;

-- TODO: a) the total number of occupations (expect 1016).
    SELECT COUNT (*) FROM occupations;

-- TODO: b) a list of all job families in alphabetical order (expect 23).
    SELECT DISTINCT "job_family" FROM occupations ORDER BY 1;
    -- or 
    SELECT "job_family" FROM occupations ORDER BY "job_family";

-- TODO: c) the total number of job families (expect 23)
    SELECT COUNT(*) FROM (
        SELECT DISTINCT "job_family" FROM occupations ORDER BY 1
    ) subquery;

-- TODO: d) the total number of occupations per job family in alphabetical order of job family.
    SELECT "job_family", COUNT(*) AS "total_occupations" FROM occupations GROUP BY "job_family" ORDER BY "job_family";

-- TODO: e) the number of occupations in the "Computer and Mathematical" job family (expect 38)
    SELECT COUNT(*) AS "number_of_occupations" FROM occupations WHERE "job_family" = 'Computer and Mathematical';

-- BONUS POINTS
-- TODO: f) an alphabetical list of occupations in the "Computer and Mathematical" job family.
    SELECT "occupation" FROM occupations WHERE "job_family" = 'Computer and Mathematical' ORDER BY "occupation" ASC;

-- TODO: g) an alphabetical list of occupations in the "Computer and Mathematical" job family that begins with the word "Database"
    SELECT "occupation" FROM occupations WHERE "job_family" = 'Computer and Mathematical' AND "occupation" LIKE 'Database%' ORDER BY "occupation" ASC;