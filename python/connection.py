import pandas as pd
from sqlalchemy import create_engine

# cargar dataset limpio
df = pd.read_csv("data/clean_superstore.csv", encoding="latin1")

# conexión MySQL
engine = create_engine("mysql+mysqlconnector://###:###@localhost:3306/superstore")

# enviar a MySQL
df.to_sql(
    name='sales',
    con=engine,
    if_exists='replace',   # clave: crea tabla correctamente
    index=False
)

print("Datos cargados correctamente en MySQL")