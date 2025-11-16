from src.commands import commands
from src.screens import screen
from src.utils import utils as u

if __name__ == "__main__":
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

            Screen.draw_login(who)

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
