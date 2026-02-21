import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

df = pd.read_csv("data/clean_superstore.csv", encoding='latin1')

plt.figure(figsize=(10,6))

sns.heatmap(df.isnull(), yticklabels=False, cbar=False, cmap="viridis")

plt.title("Mapa de calor de nulos")
plt.show()

nulos = df.isnull().sum()
porcentaje = (nulos / len(df)) * 100
resumen_nulos = pd.DataFrame({'Total Nulos': nulos, 'Porcentaje %': porcentaje})

print(resumen_nulos[resumen_nulos['Total Nulos'] > 0])