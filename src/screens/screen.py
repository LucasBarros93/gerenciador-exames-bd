from enum import Enum
import os

class State(Enum):
    WELCOME = 1
    LOGIN = 2
    SING_UP = 3

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

    def draw_login(self):
        clear()
        
        print("|----------------|")
        print("|     Entrar     |")
        print("|----------------|")

        print()
        user = input("Usuario: ")
        password = input("Senha: ")

        self.state = State.LOGIN

        return user, password

    def draw_sing_up(self):
        clear()
        
        print("|----------------|")
        print("|    Cadastro    |")
        print("|----------------|")

        print()
        print("Como deseja se cadastrar?")
        print("[1]: Cidadao")
        print("[2]: Governo")
        print("[3]: Hospital")

        option = input()
        if option == "1":
            clear()
            user = input("Usuario: ")
            password = input("Senha: ")

            return user, password
        if option == 2:
            return


        self.state = State.SING_UP


if __name__ == "__main__":
    Screen = Screen()
    Screen.draw_sing_up()
