from src.entities import consulta
from sql import connection
import psycopg2


class GET:
    def __init__(self):
        self.conn = connection.get_connection()
        self.cursor = self.conn.cursor()

    def login(self, user, senha, who):
        sql_query = {
            1: """SELECT idcidadao, cpf, senha FROM idcidadao_cpf
                    WHERE cpf = %s AND senha = %s""",
            2: """SELECT idempresa, cnpj, senha FROM idempresa_cnpj
                    WHERE cnpj = %s AND senha = %s""",
        }

        self.cursor.execute(sql_query[who], [user, senha])
        resultado = self.cursor.fetchone()

        return resultado

    def consultations_from_citizen(self, cidadao_id, search):
        if search == None:
            sql_query = """SELECT * FROM consulta C
                        WHERE C.cidadao = %s
                        ORDER BY C.data_hora"""

            self.cursor.execute(sql_query, [cidadao_id])

        else:
            sql_query = """SELECT * FROM consulta C
                        WHERE C.cidadao = %s and C.data_hora::date = TO_DATE(%s, 'DD/MM/YYYY')
                        ORDER BY C.data_hora"""

            self.cursor.execute(sql_query, [cidadao_id, search])

        result = self.cursor.fetchall()

        consultations = [
            consulta.Consulta(
                id=row[0],
                cidadao=row[1],
                hospital=row[2],
                data_hora=row[3],
                medico=row[4],
            )
            for row in result
        ]

        return consultations

    def consultations_from_hospital(self, hospital_id):
        # Consulta: todas as consultas do hospital a partir de hoje
        sql_query = """SELECT * FROM consulta C
                    WHERE C.hospital = %s 
                    ORDER BY C.data_hora"""

        self.cursor.execute(sql_query, [hospital_id])
        result = self.cursor.fetchall()

        consultations = [
            consulta.Consulta(
                id=row[0],
                cidadao=row[1],
                hospital=row[2],
                data_hora=row[3],
                medico=row[4],
            )
            for row in result
        ]

        return consultations


class POST:
    def __init__(self):
        self.conn = connection.get_connection()
        self.cursor = self.conn.cursor()

    def sign_up(self, who, data):
        sql_query1 = {
            1: """INSERT INTO idcidadao_cpf (cpf, senha, nome)
                    VALUES (%(cpf)s, %(password)s, %(name)s)
                    RETURNING idcidadao;""",
            2: """INSERT INTO idempresa_cnpj (cnpj, senha, nome)
                    VALUES (%(cnpj)s, %(password)s, %(name)s)
                    RETURNING idempresa;""",
        }

        sql_query2 = {
            1: """INSERT INTO cidadao (idcidadao, nascimento, eh_medico) 
                    VALUES (%s, TO_DATE(%s, 'DD/MM/YYYY'), false)""",
            2: """INSERT INTO empresa (idempresa, franquia, rua, numero, bairro, tipo)
                    VALUES (%(id)s, %(franchise)s, %(st)s, %(num)s, %(nb)s, %(type)s)""",
        }

        try:
            self.cursor.execute(sql_query1[who], data)
            id = self.cursor.fetchone()[0]

            if who == 1:
                self.cursor.execute(sql_query2[who], [id, data["nasc"]])
            else:
                data["id"] = id
                self.cursor.execute(sql_query2[who], data)
            self.conn.commit()
            return id

        except psycopg2.Error as error:
            self.conn.rollback()
            print("Erro:", error)
            return None
