import configparser as cp
from sqlalchemy import create_engine
from sqlalchemy.engine import URL
from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship, sessionmaker

Base = declarative_base()
class PL(Base): 
    __tablename__ = "pls"
    id = Column(Integer, primary_key=True)
    name = Column(String)
    
engine = create_engine('sqlite:///pls.db')
if engine: 
    print('Connection to Postgres database was successful!')
    Session = sessionmaker(engine)
    session = Session()
    query = session.query(PL)
    for pl in query.all():
        print(pl.id, pl.name)