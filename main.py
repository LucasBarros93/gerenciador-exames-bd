from src.commands import commands
from src.screens import screen
from src.utils import utils as u
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
            who = u.input_option(3)

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
            who = u.input_option(3)

            Screen.draw_sign_up(who)

        # CITIZEN MAIN
        while who == 1:
            Screen.draw_citizen()
            option = u.input_option(7)
            search = 0
            search_type = 0

            if option == 7:
                break

            if option == 2:
                Screen.draw_exam_search()
                search_type = u.input_option(5)

                print()
                search = input("Digite a busca: ")

            if option == 1 or option == 2:
                exams = Get.exams_from_citizen("Citizen", search_type, search)

                if len(exams) == 0:
                    Screen.draw_404()
                    input()
                    continue

                Screen.draw_list_exams(exams)
                exam = u.input_option(len(exams) + 1)

                if exam == len(exams) + 1:
                    continue

            if option == 4:
                Screen.draw_consultation_search()
                search_type = u.input_option(3)

                print()
                search = input("Digite a busca: ")

            if option == 3 or option == 4:
                consultations = Get.consultations_from_citizen(
                    "Citizen", search_type, search
                )

                if len(consultations) == 0:
                    Screen.draw_404()
                    input()
                    continue

                Screen.draw_list_consultations(consultations)
                consultation = u.input_option(len(consultations) + 1)

                if consultation == len(consultations) + 1:
                    continue

            if option == 5:
                hospital, date, hour = Screen.draw_schedule()
                # Post.consultation(hospital, date, hour)
                # check if the hospital exists
                Post.schedule_consultation()
                print()
                print("Consulta agendada, aguarde confirmação do hospital")
                input()

            if option == 6:
                # NOTE: filtrariasse por consultas ate a data de hj
                consultations = Get.consultations_from_citizen(
                    "Citizen", search_type, search
                )

                if len(consultations) == 0:
                    Screen.draw_404()
                    input()
                    continue

                Screen.draw_list_consultations(consultations)

                print()
                print("Qual consulta deseja cancelar?")

                cancel = u.input_option(len(consultations) + 1)

                Post.delete_consultation()

        # MAIN GOVERNMENT
        while who == 2:
            Screen.draw_government()
            option = u.input_option(2)
            # Command.commands_government(option)
            if option == 2:
                break

        # HOSPITAL MAIN
        while who == 3:
            Screen.draw_hospital()
            option = u.input_option(3)
            # Command.commands_hospital(option)
            if option == 3:
                break

            if option == 1:
                # buscando as ainda n realizadas
                exams = Get.exams_from_hospital("unimed", date=True)

            if option == 2:
                # buncando as não confirmadas
                exams = Get.exams_from_hospital("unimed", to_verify=True)

            if len(exams) == 0:
                Screen.draw_404()
                input()
                continue

            Screen.draw_list_exams(exams)
            exam = u.input_option(len(exams) + 1)

            if exam == len(exams) + 1:
                continue
