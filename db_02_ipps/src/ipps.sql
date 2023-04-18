-- CS3810: Principles of Database Systems
-- Instructor: Thyago Mota
-- Student(s): Ling Thang
-- Description: IPPS database

DROP DATABASE ipps;

CREATE DATABASE ipps;

\c ipps

/* 
Rndrng_Prvdr_CCN,Rndrng_Prvdr_Org_Name,Rndrng_Prvdr_St,Rndrng_Prvdr_City,Rndrng_Prvdr_State_Abrvtn,Rndrng_Prvdr_State_FIPS,Rndrng_Prvdr_Zip5,Rndrng_Prvdr_RUCA,Rndrng_Prvdr_RUCA_Desc,DRG_Cd,DRG_Desc,Tot_Dschrgs,Avg_Submtd_Cvrd_Chrg,Avg_Tot_Pymt_Amt,Avg_Mdcr_Pymt_Amt

Rndrng_Prvdr_CCN -> Rndrng_Prvdr_Org_Name, 
Rndrng_Prvdr_St, Rndrng_Prvdr_City, 
Rndrng_Prvdr_State_Abrvtn, Rndrng_Prvdr_State_FIPS, 
Rndrng_Prvdr_Zip5, Rndrng_Prvdr_RUCA, Rndrng_Prvdr_RUCA_Desc


DRG_Cd -> DRG_Desc

*/

-- create tables
    CREATE TABLE Providers (
        CCN VARCHAR(50) PRIMARY KEY,
        name VARCHAR(255),
        street_address VARCHAR(255),
        city VARCHAR(255),
        state_abrvtn CHAR(2),
        state_fips VARCHAR(2),
        zip_code VARCHAR(5),
        RUCA_code VARCHAR(50),
        RUCA_description VARCHAR(255)
    );

    CREATE TABLE Diagnoses (
        code VARCHAR(50) PRIMARY KEY,
        description VARCHAR(255)
        );
    
    CREATE TABLE Provider_diagnoses (
        provider_CCN VARCHAR(50),
        diagnosis_code VARCHAR(50),
        total_discharges INTEGER,
        avg_submitted_covered_charges NUMERIC(10,2),
        avg_total_payments NUMERIC(10,2),
        avg_medicare_payments NUMERIC(10,2),
        FOREIGN KEY (provider_CCN) REFERENCES providers (CCN),
        FOREIGN KEY (diagnosis_code) REFERENCES diagnoses (code),
        PRIMARY KEY (provider_CCN, diagnosis_code)
    );
    
-- create user with appropriate access to the tables
    Create user ipps_user with password 'StrongPassword';
    GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO ipps_user;
   
-- queries
-- a) List all diagnosis in alphabetical order.    
    SELECT DISTINCT DRG_Desc FROM DRG ORDER BY DRG_Desc;


-- b) List the names and correspondent states (including Washington D.C.) of all of the providers in alphabetical order (state first, provider name next, no repetition). 
    SELECT DISTINCT Rndrng_Prvdr_St, Rndrng_Prvdr_Org_Name FROM Providers ORDER BY Rndrng_Prvdr_St, Rndrng_Prvdr_Org_Name;


-- c) List the total number of providers.
    SELECT COUNT(Rndrng_Prvdr_CCN) FROM Providers;


-- d) List the total number of providers per state (including Washington D.C.) in alphabetical order (also printing out the state).  
    SELECT Rndrng_Prvdr_St, COUNT(Rndrng_Prvdr_CCN) FROM Providers GROUP BY Rndrng_Prvdr_St ORDER BY Rndrng_Prvdr_St;


-- e) List the providers names in Denver (CO) or in Lakewood (CO) in alphabetical order  
    SELECT Rndrng_Prvdr_Org_Name FROM Providers WHERE Rndrng_Prvdr_City = 'Denver' OR Rndrng_Prvdr_City = 'Lakewood' ORDER BY Rndrng_Prvdr_Org_Name;


-- f) List the number of providers per RUCA code (showing the code and description)
    SELECT Rndrng_Prvdr_RUCA, Rndrng_Prvdr_RUCA_Desc, COUNT(Rndrng_Prvdr_CCN) FROM Providers GROUP BY Rndrng_Prvdr_RUCA, Rndrng_Prvdr_RUCA_Desc ORDER BY Rndrng_Prvdr_RUCA;


-- g) Show the DRG description for code 308 
    SELECT DRG_Desc FROM DRG WHERE DRG_Cd = '308';


-- h) List the top 10 providers (with their correspondent state) that charged (as described in Avg_Submtd_Cvrd_Chrg) the most for the DRG code 308. Output should display the provider name, their city, state, and the average charged amount in descending order.   
    SELECT Rndrng_Prvdr_Org_Name, Rndrng_Prvdr_City, Rndrng_Prvdr_St, Avg_Submtd_Cvrd_Chrg FROM Appointment_Cost, DRG, Providers WHERE DRG.DRG_Cd = '308' AND DRG.DRG_Cd = Appointment_Cost.DRG_Cd AND Providers.Rndrng_Prvdr_CCN = Appointment_Cost.Rndrng_Prvdr_CCN ORDER BY Avg_Submtd_Cvrd_Chrg DESC LIMIT 10;


-- i) List the average charges (as described in Avg_Submtd_Cvrd_Chrg) of all providers per state for the DRG code 308. Output should display the state and the average charged amount per state in descending order (of the charged amount) using only two decimals. 
    SELECT Rndrng_Prvdr_St, ROUND(AVG(Avg_Submtd_Cvrd_Chrg),2) FROM Appointment_Cost, DRG, Providers WHERE DRG.DRG_Cd = '308' AND DRG.DRG_Cd = Appointment_Cost.DRG_Cd AND Providers.Rndrng_Prvdr_CCN = Appointment_Cost.Rndrng_Prvdr_CCN GROUP BY Rndrng_Prvdr_St ORDER BY ROUND(AVG(Avg_Submtd_Cvrd_Chrg),2) DESC;


-- j) Which provider and clinical condition pair had the highest difference between the amount charged (as described in Avg_Submtd_Cvrd_Chrg) and the amount covered by Medicare only (as described in Avg_Mdcr_Pymt_Amt)?
    SELECT Rndrng_Prvdr_Org_Name, DRG_Desc, (Avg_Submtd_Cvrd_Chrg - Avg_Mdcr_Pymt_Amt) AS Diff FROM Appointment_Cost, DRG, Providers WHERE DRG.DRG_Cd = Appointment_Cost.DRG_Cd AND Providers.Rndrng_Prvdr_CCN = Appointment_Cost.Rndrng_Prvdr_CCN ORDER BY Diff DESC LIMIT 1;

