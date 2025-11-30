from src.entities import citizen, exame, consulta
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
            3: """SELECT idempresa, cnpj, senha FROM idempresa_cnpj
                    WHERE cnpj = %s AND senha = %s""",
        }

        self.cursor.execute(sql_query[who], [user, senha])
        resultado = self.cursor.fetchone()

        return resultado

    def exams_from_citizen(self, Cidadao, search_type, search):
        exams = []

        # Em tese vamos usar Cidadao.cpf para dar get na base eventualmente
        exams.append(exame.ExameMedicoCNH(0, "1111", "Joao", data_exame="13-01"))
        exams.append(exame.ExameMedicoCNH(1, "2222", "Lucas", data_exame="21-03"))

        return exams

    def consultations_from_citizen(self, Cidadao, search_type, search):
        consultations = []

        # Em tese vamos usar Cidadao.cpf para dar get na base eventualmente
        consultations.append(consulta.Consulta(0, "1111", "Unimed", data_hora="13-01"))
        consultations.append(
            consulta.Consulta(1, "2222", "Santa Casa", data_hora="21-03")
        )

        return consultations

    # date é pra pegar as que são depois de hoje
    # to_verify pega as que não estão confirmadas ainda
    def exams_from_hospital(self, hospital, date=False, to_verify=False):
        exams = []

        # Em tese vamos usar Cidadao.cpf para dar get na base eventualmente
        exams.append(exame.ExameMedicoCNH(0, "1111", "Joao", data_exame="13-01"))
        exams.append(exame.ExameMedicoCNH(1, "2222", "Lucas", data_exame="21-03"))

        return exams


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
            3: """INSERT INTO idempresa_cnpj (cnpj, senha, nome)
                    VALUES (%(cnpj)s, %(password)s, %(name)s)
                    RETURNING idempresa;""",
        }

        sql_query2 = {
            1: """INSERT INTO cidadao (idcidadao, nascimento, eh_medico) 
                    VALUES (%s, TO_DATE(%s, 'DD/MM/YYY'), false)""",
            2: """INSERT INTO empresa (idempresa, franquia, rua, numero, bairro, tipo)
                    VALUES (%(id)s, %(franchise)s, %(st)s, %(num)s, %(nb)s, %(type)s)""",
            3: """INSERT INTO empresa (idempresa, franquia, rua, numero, bairro, tipo)
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

    def schedule_consultation(self):
        pass

    def delete_consultation(self):
        pass
