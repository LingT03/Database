import psycopg2
import configparser as cp

config = cp.RawConfigParser()
config.read('ConfigFile.properties')
params = dict(config.items('db'))
conn = psycopg2.connect(**params)
conn.autocommit = True
if conn: 
    print('Connection to Postgres database ' + params['dbname'] + ' was successful!')

    # code to inject in the name: 1; UPDATE Grades SET letter = 'B+' WHERE id = 1
    id = input('id? ')
    sql = '''
        SELECT * FROM Grades 
        WHERE id = %s;
    '''
    cur = conn.cursor()
    cur.execute(sql % (id))
    for row in cur:
        print(row)  

    print('Bye!')
    conn.close()