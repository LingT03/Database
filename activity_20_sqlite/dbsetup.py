import configparser as cp
from sqlalchemy import create_engine
from sqlalchemy.engine import create_engine
from sqlalchemy.engine import URL 
from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship, sessionmaker


Base = declarative_base()

class Pl(Base):
    __tablename__ = 'pls'
    id = Column(Integer, primary_key=True)
    name = Column(String)

engine = create_engine('sqlite:///pls.db')
if engine:
    print('Connection to SQLite database was successful!')
    Session = sessionmaker(engine)
    session= Session()
    query = session.query(Pl)
    for pl in query.all:
        print(pl.id, pl.name)
    print('Bye!')