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
            # Command.commands_citizen(option)
            if option == 1:
                exams = Get.exams_from_citizen("Citizen")
                Screen.draw_list_exams(exams)

                exam = u.input_option(len(exams)+1)

                if(exam == len(exams)+1):
                    pass

            if option == 7:
                break
            
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
            

