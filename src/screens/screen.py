from enum import Enum
import os


class State(Enum):
    WELCOME = 1
    LOGIN = 2
    SING_UP = 3
    WHO = 4
    CITIZEN = 5


def clear():
    # Windows usa 'cls', Linux e Mac usam 'clear'
    if os.name == "nt":
        os.system("cls")
    else:
        os.system("clear")


class Screen:
    def __init__(self):
        self.state = State.WELCOME

    def draw_welcome(self):
        clear()

        print("|----------------|")
        print("|    Bem Vindo   |")
        print("|----------------|")

        print()
        print("[1]: Entrar")
        print("[2]: Cadastra-se")
        print("[3]: Sair")

        self.state = State.WELCOME

    def draw_who(self):
        clear()

        print("|----------------|")
        print("|  Quem e voce?  |")
        print("|----------------|")

        print()
        print("[1]: Cidadao")
        print("[2]: Instituição governamental")
        print("[3]: Hospital")

        self.state = State.WHO

    def draw_login(self, who):
        clear()

        print("|----------------|")
        print("|     Entrar     |")
        print("|----------------|")

        print()

        self.state = State.LOGIN

        if who == 1:  # cidadao
            cpf = input("CPF: ")
            password = input("Senha: ")
            return cpf, password

        if who == 2:  # Governo
            cnpj = input("CNPJ: ")
            password = input("Senha: ")
            return cnpj, password

        if who == 3:  # Governo
            cnpj = input("CNPJ: ")
            password = input("Senha: ")
            return cnpj, password

        input("ERROR: opcao invalida")
        return

    def draw_sign_up(self, who):
        clear()

        print("|----------------|")
        print("|    Cadastro    |")
        print("|----------------|")

        print()

        if who == 1:  # Cidadao
            cpf = input("cpf: ")
            password = input("Senha: ")
            name = input("nome: ")
            nasc = input("data de nascimento (DD/MM/AAAA): ").strip()

            return {'cpf':cpf, 'password':password, 'name':name, 'nasc':nasc}

        if who == 2:  # Governo
            user = input("Tipo de instituicao: ")
            cnpj = input("CNPJ: ")
            password = input("Senha: ")

            return user, cnpj, password

        if who == 3:  # hospital
            cnpj = input("CNPJ: ")
            password = input("Senha: ")

            return cnpj, password

        input("ERROR: opcao invalida")
        return

        self.state = State.SING_UP

    def draw_citizen(self):
        clear()

        print("|-----------------|")
        print("|O que quer fazer?|")
        print("|-----------------|")

        print()
        print("[1]: Ver lista completa de exames")
        print("[2]: Buscar exames")
        print("[3]: Ver lista completa de consultas")
        print("[4]: Buscar consulta")
        print("[5]: Marcar consulta")
        print("[6]: Cancelar consulta")
        print("[7]: Voltar para o inicio")

        self.state = State.CITIZEN

    def draw_government(self):
        clear()

        print("|-----------------|")
        print("|O que quer fazer?|")
        print("|-----------------|")

        print()
        print("[1]: Desenvolvimento em beta, opcoes de governo ainda nao implemntadas")
        print("[2]: Voltar para o inicio")

        self.state = State.CITIZEN

    def draw_hospital(self):
        clear()

        print("|-----------------|")
        print("|O que quer fazer?|")
        print("|-----------------|")

        print()
        print("[1]: Listar exames marcados do hospital")
        print("[2]: Confirmar exames do hospital")
        print("[3]: Voltar para o inicio")

        self.state = State.CITIZEN

    def draw_exam_search(self):
        clear()

        print("|------------------|")
        print("|-Pelo que buscar?-|")
        print("|------------------|")

        print()
        print("[1]: Id")
        print("[2]: Tipo de exame")
        print("[3]: Medico")
        print("[4]: Consulta")
        print("[5]: Data do exame")

        self.state = State.CITIZEN

    def draw_list_exams(self, exams):
        clear()

        print("|-----------------|")
        print("|-Lista de Exames-|")
        print("|-----------------|")

        print()
        for i in range(len(exams)):
            print(f"[{i+1}]: {exams[i].__str__()}")

        print(f"[{len(exams)+1}]: Voltar")

    def draw_list_consultations(self, consultations):
        clear()

        print("|--------------------|")
        print("|-Lista de Consultas-|")
        print("|--------------------|")

        print()
        for i in range(len(consultations)):
            print(f"[{i+1}]: {consultations[i].__str__()}")

        print(f"[{len(consultations)+1}]: Voltar")

    def draw_consultation_search(self):
        clear()

        print("|------------------|")
        print("|-Pelo que buscar?-|")
        print("|------------------|")

        print()
        print("[1]: Id")
        print("[2]: Hospital")
        print("[3]: Data")

        self.state = State.CITIZEN

    def draw_404(self):
        clear()

        print("|----------------|")
        print("|-Não encontrado-|")
        print("|----------------|")

        print()
        print("Enter para voltar")

    def draw_schedule(self):
        clear()

        print("|-----------------|")
        print("|-Marcar consulta-|")
        print("|-----------------|")

        print()

        hospital = input("Hospital: ")
        date = input("Data: ")
        hour = input("Hora: ")

        return hospital, date, hour


if __name__ == "__main__":
    Screen = Screen()
    Screen.draw_sing_up()
