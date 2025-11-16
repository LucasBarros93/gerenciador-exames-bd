from src.entities import citizen, exame, consulta


class GET:
    def __init__(self):
        pass

    def exams_from_citizen(self, Cidadao, search_type, search):
        exams = []

        # Em tese vamos usar Cidadao.cpf para dar get na base eventualmente
        exams.append(exame.ExameMedicoCNH(0, "1111", "Joao", data_exame="13-01"))
        exams.append(exame.ExameMedicoCNH(1, "2222", "Lucas", data_exame="21-03"))

        return exams

    def consultations_from_citizen(self, Cidadao, search_type, search):
        consultations = []

        # Em tese vamos usar Cidadao.cpf para dar get na base eventualmente
        consultations.append(
            consulta.Consulta(0, "1111", "Unimed", data_hora="13-01")
        )
        consultations.append(
            consulta.Consulta(1, "2222", "Santa Casa", data_hora="21-03")
        )

        return consultations


class POST:
    def __init__(self):
        pass
