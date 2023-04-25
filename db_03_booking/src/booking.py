"""
CS3810: Principles of Database Systems
Instructor: Thyago Mota
Student(s): Ling Thang 
Description: A room reservation system
"""

import psycopg2
from psycopg2 import extensions, errors
import configparser as cp
from datetime import datetime

def menu(): 
    print('1. List')
    print('2. Reserve')
    print('3. Delete')
    print('4. Quit')

def db_connect():
    config = cp.RawConfigParser()
    config.read('ConfigFile.properties')
    params = dict(config.items('db'))
    conn = psycopg2.connect(**params)
    conn.autocommit = False 
    with conn.cursor() as cur: 
        cur.execute('''
            PREPARE QueryReservationExists AS 
                SELECT * FROM Reservations 
                WHERE abbr = $1 AND room = $2 AND date = $3 AND period = $4;
        ''')
        cur.execute('''
            PREPARE QueryReservationExistsByCode AS 
                SELECT * FROM Reservations 
                WHERE code = $1;
        ''')
        cur.execute('''
            PREPARE NewReservation AS 
                INSERT INTO Reservations (abbr, room, date, period) VALUES
                ($1, $2, $3, $4);
        ''')
        cur.execute('''
            PREPARE UpdateReservationUser AS 
                UPDATE Reservations SET "user" = $1
                WHERE abbr = $2 AND room = $3 AND date = $4 AND period = $5; 
        ''')
        cur.execute('''
            PREPARE DeleteReservation AS 
                DELETE FROM Reservations WHERE code = $1;
        ''')
    return conn

# TODO: display all reservations in the system using the information from ReservationsView
def list_op(conn):
     with conn.cursor() as cur:
        cur.execute('SELECT * FROM ReservationsView;')
        rows = cur.fetchall()
        print('Reservations:')
        for row in rows:
            print(row)


# TODO: reserve a room on a specific date and period, also saving the user who's the reservation is for
def reserve_op(conn):
    abbr = input('Abbreviation: ')
    room = input('Room: ')
    date = input('Date (YYYY-MM-DD): ')
    period = input('Period (1-5): ')
    user = input('User: ')
    with conn.cursor() as cur:
        cur.execute('EXECUTE QueryReservationExists (%s, %s, %s, %s);', (abbr, room, date, period))
        if cur.fetchone() is None:
            cur.execute('EXECUTE NewReservation (%s, %s, %s, %s);', (abbr, room, date, period))
        cur.execute('EXECUTE UpdateReservationUser (%s, %s, %s, %s, %s);', (user, abbr, room, date, period))
        conn.commit()
        print('Reservation created.')

# TODO: delete a reservation given its code
def delete_op(conn):
    code = input('Code: ')
    with conn.cursor() as cur:
        cur.execute('EXECUTE QueryReservationExistsByCode (%s);', (code,))
        if cur.fetchone() is None:
            print('Reservation not found.')
        else:
            cur.execute('EXECUTE DeleteReservation (%s);', (code,))
            conn.commit()
            print('Reservation deleted.')

if __name__ == "__main__":
    with db_connect() as conn:
        op = 0
        while op != 4: 
            menu()
            op = int(input('\nEnter your option: '))
            if op == 1: 
                list_op(conn)
            elif op == 2:
                reserve_op(conn)
            elif op == 3:
                delete_op(conn)
            elif op == 4:
                print ('Goodbye!')