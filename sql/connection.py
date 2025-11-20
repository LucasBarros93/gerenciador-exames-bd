import psycopg2

conn = psycopg2.connect(
    host="localhost",
    port=5432,
    database="trab",
    user="ninja",
    password="123"
)

cur = conn.cursor()
cur.execute("SELECT 'Conectado ao PostgreSQL!'")
print(cur.fetchone())

cur.close()
conn.close()

# Resposta Esperada
# ('Conectado ao PostgreSQL!',)

