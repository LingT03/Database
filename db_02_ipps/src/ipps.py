"""
CS3810: Principles of Database Systems
Instructor: Thyago Mota
Student(s): Ling Thang 
Description: A data load script for the IPPS database
"""

import psycopg2
import configparser as cp

config = cp.RawConfigParser()
config.read('ConfigFile.properties')
params = dict(config.items('db'))

conn = psycopg2.connect(**params)
conn.autocommit = True

if conn: 
    print('Connection to Postgres database ' + params['dbname'] + ' was successful!')

with open('../data/MUP_IHP_RY22_P02_V10_DY20_PrvSvc.csv', 'r') as f:
    # skip the header row
    next(f)

    for line in f:
        # split the line into columns
        cols = line.strip().split(',')

        # create the provider record
        providerseed = (
            cols[0], cols[1], cols[2], cols[3], cols[4], cols[5], cols[6], cols[7], cols[8]
        )
        print (providerseed)
        conn.cursor().execute('INSERT INTO providers VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)', providerseed)
        

        # create the diagnosis record
        diagnosisseed = (cols[9], cols[10])
        conn.cursor().execute('INSERT INTO diagnoses VALUES (%s, %s)', diagnosisseed)

        # create the provider diagnosis record
        Providerdiagnosisseed = (
            cols[0], cols[9], cols[11], cols[12], cols[13], cols[14]
        )
        conn.cursor().execute('INSERT INTO provider_diagnoses VALUES (%s, %s, %s, %s, %s, %s)', Providerdiagnosisseed)

# create the prepared SQL statements


# commit the changes and close the database connection
conn.commit()
conn.close()
