import pandas as pd

#cargar data set
df = pd.read_csv("data/superstore.csv", encoding="latin1")

print(df.head())

#Limpiar nombres columnas
df.columns = df.columns.str.lower().str.replace(" ", "_")
df.columns = df.columns.str.lower().str.replace("-", "_")

print(df.head())

#Convertir fechas
df["order_date"] = pd.to_datetime(df["order_date"])
df["ship_date"] = pd.to_datetime(df["ship_date"])

#eliminar filas con sales nulos
df=df.dropna(subset=["sales"])

df.to_csv("data/clean_superstore.csv", index=False)

print("Data set exportado correctamente")