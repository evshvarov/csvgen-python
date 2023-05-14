import pandas as pd
import iris
from sqlalchemy import create_engine, MetaData, Table, Column, Integer, String, Float, DateTime, Boolean


def importcsv(file_name,table_name='csv_import',connect_line='iris+emb:///',schema='csvgen',if_exists='replace'):
    """
    Import csv file to database
    """
    engine = create_engine(connect_line)
    df = pd.read_csv(file_name)
    df.to_sql(name=table_name, con=engine,schema=schema,if_exists=if_exists, index=False)
    return len(df)

file_name='/home/irisowner/dev/data/Educational_Attainment_small.csv'
file_name='/home/irisowner/dev/data/10k_diabetes_small 2.csv'
importcsv(file_name,connect_line='iris+emb:///')
