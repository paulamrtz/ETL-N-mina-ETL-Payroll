import pandas as pd
from sqlalchemy import create_engine

# 1. EXTRACT - Leer el Excel
df = pd.read_excel(r'C:\Users\marti\OneDrive\Desktop\Portfolio\1 - ETL\NOMINA-EMPLEADOS-LIBRE-NOMBRAMIENTO-Y-REMOCION-JUNIO-2025.xlsx', header=3)

# Renombrar columnas
df.columns = ['NOMBRE', 'DEPARTAMENTO', 'CARGO', 'INGRESO_BRUTO', 'ISR', 'AFP', 'SFS', 'INGRESO_NETO']

# Ver cómo llegaron los datos
print(df.head())
print("Filas:", len(df))

# 3. LOAD - Cargar a SQL Server
engine = create_engine('mssql+pyodbc://localhost/CamaraDeDip?driver=ODBC+Driver+17+for+SQL+Server&trusted_connection=yes')

df.to_sql('Nomina_Junio_2025', con=engine, if_exists='replace', index=False)

print("✅ Datos cargados en SQL Server correctamente")