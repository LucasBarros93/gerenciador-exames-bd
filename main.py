from src import commands
from src import screen
from src import utils as u
from sql import connection

from datetime import datetime

if __name__ == "__main__":
    conn = connection.get_connection()
    cursor = conn.cursor()

    while True:
        Screen = screen.Screen()

        Get = commands.GET()
        Post = commands.POST()

        Screen.draw_welcome()
        option = u.input_option(3)

        # QUIT
        if option == 3:
            break

        # LOGIN
        if option == 1:
            Screen.draw_who()
            who = u.input_option(2)

            user, senha = Screen.draw_login(who)
            resultado = Get.login(user, senha, who)

            if resultado == None:
                print()
                input("Usuario ou senha inválidos. Enter para tentar novamente")
                continue

            id = resultado[0]

        # CADASTRO
        if option == 2:
            Screen.draw_who()
            who = u.input_option(2)

            data = Screen.draw_sign_up(who)
            id = Post.sign_up(who, data)
            if id == None:
                print()
                input("Algo deu errado. Enter para tentar novamente")
                continue

        # CITIZEN MAIN
        while who == 1:
            Screen.draw_citizen()
            option = u.input_option(3)
            search = None

            if option == 3:
                break

            if option == 2:
                search = Screen.draw_consultation_search()

            if option == 1 or option == 2:
                consultations = Get.consultations_from_citizen(id, search)

                if len(consultations) == 0:
                    Screen.draw_404()
                    input()
                    continue

                Screen.draw_list_consultations(consultations)
                skip = u.input_option(1)

                if skip == 1:
                    continue


        # HOSPITAL MAIN
        while who == 2:
            Screen.draw_hospital()
            option = u.input_option(2)

            if option == 2:
                break

            if option == 1:
                consultations = Get.consultations_from_hospital(id)

                if len(consultations) == 0:
                    Screen.draw_404()
                    input()
                    continue

                Screen.draw_list_consultations(consultations)
                skip = u.input_option(1)

                if skip == 1:
                    continue

    Get.kill()
    Post.kill()
