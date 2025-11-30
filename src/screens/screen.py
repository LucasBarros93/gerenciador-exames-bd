from src.utils import utils as u
import os


def clear():
    # Windows usa 'cls', Linux e Mac usam 'clear'
    if os.name == "nt":
        os.system("cls")
    else:
        os.system("clear")


class Screen:
    def __init__(self):
        pass

    def draw_welcome(self):
        clear()

        print("|----------------|")
        print("|    Bem Vindo   |")
        print("|----------------|")

        print()
        print("[1]: Entrar")
        print("[2]: Cadastra-se")
        print("[3]: Sair")


    def draw_who(self):
        clear()

        print("|----------------|")
        print("|  Quem e voce?  |")
        print("|----------------|")

        print()
        print("[1]: Cidadao")
        print("[2]: Empresa")

    def draw_login(self, who):
        clear()

        print("|----------------|")
        print("|     Entrar     |")
        print("|----------------|")

        print()


        if who == 1:  # cidadao
            cpf = input("CPF: ")
            password = input("Senha: ")
            return cpf, password

        if who == 2:  # Empresa
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

            return {"cpf": cpf, "password": password, "name": name, "nasc": nasc}

        if who == 2:  # Empresa
            name = input("Nome da instituicao: ")
            cnpj = input("CNPJ: ")
            password = input("Senha: ")

            franchise = input("Franquia (opcional): ")
            st = input("Rua: ")
            num = input("Numero: ")
            nb = input("Bairro: ")

            print(
                "Tipo: [1]Órgão Público, [2]Empresa Privada, [3]ONG, [4]Educação, [5]Saúde, [6]Serviços, [7]Não se aplica"
            )
            tipo = u.input_option(7)
            type = {
                1: "Órgão Público",
                2: "Empresa Privada",
                3: "ONG",
                4: "Educação",
                5: "Saúde",
                6: "Serviços",
                7: None,
            }

            return {
                "name": name,
                "cnpj": cnpj,
                "password": password,
                "franchise": franchise,
                "st": st,
                "num": num,
                "nb": nb,
                "type": type[tipo],
            }

        input("ERROR: opcao invalida")
        return

    def draw_citizen(self):
        clear()

        print("|-----------------|")
        print("|O que quer fazer?|")
        print("|-----------------|")

        print()
        print("[1]: Ver lista completa de consultas")
        print("[2]: Buscar consulta por data")
        print("[3]: Voltar para o inicio")

    def draw_hospital(self):
        clear()

        print("|-----------------|")
        print("|O que quer fazer?|")
        print("|-----------------|")

        print()
        print("[1]: Listar consulta marcados do hospital")
        print("[2]: Voltar para o inicio")

    def draw_list_consultations(self, consultations):
        clear()

        print("|--------------------|")
        print("|-Lista de Consultas-|")
        print("|--------------------|")

        print()
        for i in range(len(consultations)):
            print(f"{i+1}: {consultations[i].__str__()}")

        print()
        print("[1]: Voltar")

    def draw_consultation_search(self):
        clear()

        print("|------------------------------|")
        print("|-Qual a data da sua consulta?-|")
        print("|------------------------------|")

        print()
        date = input("(DD/MM/AAAA): ")
        return date

    def draw_404(self):
        clear()

        print("|----------------|")
        print("|-Não encontrado-|")
        print("|----------------|")

        print()
        print("Enter para voltar")


if __name__ == "__main__":
    Screen = Screen()
    Screen.draw_sing_up()
