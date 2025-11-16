from src.entities import citizen, exame

class GET:
    def __init__(self):
        pass
    
    def exams_from_citizen(self, Cidadao):
        exams = []

        # Em tese vamos usar Cidadao.cpf para dar get na base eventualmente
        exams.append(exame.ExameMedicoCNH(0, "1111","Joao", data_exame="13-01"))
        exams.append(exame.ExameMedicoCNH(1, "2222","Lucas", data_exame="21-03"))

        return exams

class POST:
    def __init__(self):
        pass
