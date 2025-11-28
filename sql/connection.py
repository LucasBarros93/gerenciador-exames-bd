import psycopg2

conn = psycopg2.connect(
    host="localhost",
    port=5432,
    database="main",
    user="grupo3",
    password="1234"
)

cur = conn.cursor()
cur.execute("SELECT 'Conectado ao PostgreSQL!'")
print(cur.fetchone())

cur.close()
conn.close()
