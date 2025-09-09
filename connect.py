from sqlalchemy import create_engine, text
import pandas as pd
from urllib.parse import quote_plus
from dotenv import load_dotenv
import os

load_dotenv()

password = quote_plus(os.getenv('PASSWORD_POSTGRES'))

# String de conexão com caracteres especiais escapados
engine = create_engine(f'postgresql://postgres:{password}@localhost:5432/postgres')

# Tenta executar um SELECT simples
try:
    with engine.connect() as connection:
        result = connection.execute(text("SELECT version();"))
        for row in result:
            print("Conectado com sucesso! Versão do PostgreSQL:", row[0])
except Exception as e:
    print("Erro ao conectar:", e)
