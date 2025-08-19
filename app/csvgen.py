import pandas as pd
from sqlalchemy import create_engine,inspect, MetaData, Table, Column, Integer, String, Float, DateTime, Boolean


def importcsv(file_name,table_name='csv_import',connect_line='iris+emb:///',schema='csvgen',if_exists='replace',header=True):
    """
    Import csv file to database
    """
    engine = create_engine(connect_line)
    if header==False:
        inspector = inspect(engine)
        columns = inspector.get_columns(table_name, schema)
        column_names=[column['name'] for column in columns]
        df=pd.read_csv(file_name,header=None,names=column_names)
        if_exists='append'

    if header==True:
        df = pd.read_csv(file_name)
        df.columns = df.columns.str.replace('.', '_').str.replace('-', '_').str.replace(' ', '_').str.lower()
    

    df.to_sql(name=table_name, con=engine,schema=schema,if_exists=if_exists, index=False)
    return df


