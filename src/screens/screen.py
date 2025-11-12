from enum import Enum
import os

class State(Enum):
    WELCOME = 1
    LOGIN = 2
    SING_UP = 3
    WHO = 4

def clear():
    # Windows usa 'cls', Linux e Mac usam 'clear'
    if os.name == 'nt':
        os.system('cls')
    else:
        os.system('clear')

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
        print("[2]: Governo")
        print("[3]: Hospital")

        self.state = State.WHO

    def draw_login(self, who):
        clear()
        
        print("|----------------|")
        print("|     Entrar     |")
        print("|----------------|")

        print()

        self.state = State.LOGIN

        if who == 1:   #cidadao
            user = input("CPF: ")
            password = input("Senha: ")
            return user, password

        if who == 2:   #Governo
            user = input("Tipo de instituicao: ")
            cnpj = input("CNPJ: ")
            password = input("Senha: ")
            return user, cnpj, password

        
        if who == 3:   #Governo
            cnpj = input("CNPJ: ")
            password = input("Senha: ")
            return cnpj, password

        input("ERROR: opcao invalida")
        return


    def draw_sing_up(self, who):
        clear()
        
        print("|----------------|")
        print("|    Cadastro    |")
        print("|----------------|")

        print()

        if who == 1:    #Cidadao
            user = input("Usuario: ")
            password = input("Senha: ")

            return user, password

        if who == 2:   #Governo
            user = input("Tipo de instituicao: ")
            cnpj = input("CNPJ: ")
            password = input("Senha: ")

            return user, cnpj, password

        
        if who == 3:   #hospital
            cnpj = input("CNPJ: ")
            password = input("Senha: ")

            return cnpj, password

        input("ERROR: opcao invalida")
        return


        self.state = State.SING_UP


if __name__ == "__main__":
    Screen = Screen()
    Screen.draw_sing_up()
