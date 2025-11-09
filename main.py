# Requisitos: psycopg2

import os
import sys
import getpass
import psycopg2
from psycopg2.extras import RealDictCursor

DB_HOST = os.getenv('DB_HOST', 'localhost')
DB_PORT = os.getenv('DB_PORT', '5432')
DB_NAME = os.getenv('DB_NAME', 'sisdocs')
DB_USER = os.getenv('DB_USER', 'postgres')

_db_password = None

def connect():
    global _db_password
    # pra pedir senha apenas na primeira vez
    if _db_password is None:
        _db_password = os.getenv('DB_PASS', None) or getpass.getpass('DB password: ')
    
    try:
        conn = psycopg2.connect(
            host=DB_HOST, 
            port=DB_PORT, 
            dbname=DB_NAME,
            user=DB_USER, 
            password=_db_password
        )
        return conn
    except psycopg2.OperationalError as e:
        print(f"Erro de conexão: {e}")
        # Se falhar, limpar senha e tentar novamente
        _db_password = None
        raise

def consulta_nome_cpf():
    cpf = input('CPF para buscar nome do cidadão: ').strip()
    conn = connect()
    try:
        with conn.cursor() as cur:
            cur.execute("SELECT nome FROM Cidadao WHERE cpf = %s;", (cpf,))
            row = cur.fetchone()
            if row:
                print(f"Nome do cidadão com CPF {cpf}: {row[0]}")
            else:
                print("Nenhum cidadão encontrado para esse CPF.")
    except Exception as e:
        print("Erro durante a consulta:", e)
    finally:
        conn.close()

def main_menu():
    while True:
        print("\n--- Protótipo SIS DOCS ---")
        print("1) Consultar nome de cidadão por CPF")
        print("0) Sair")
        choice = input("> ").strip()
        if choice == '1':
            consulta_nome_cpf()
        elif choice == '0':
            print("Tchau")
            break
        else:
            print("Opção inválida")

if __name__ == '__main__':
    try:
        main_menu()
    except KeyboardInterrupt:
        print("\nEncerrando.")
        sys.exit(0)