from src.commands import commands
from src.screens import screen
from src.utils import utils as u

if __name__ == "__main__":
    while True:
        Screen = screen.Screen()
        Command = commands.Commands()
        Screen.draw_welcome()

        option = u.input_option(3)
        who = None

        # QUIT
        if option == 3:
            break

        # LOGIN
        if option == 1:
            Screen.draw_who()
            who = u.input_option(3)

            Screen.draw_login(who)
        
        if option == 2:
            Screen.draw_who()
            who = u.input_option(3)

            Screen.draw_sign_up(who)

        # CITIZEN MAIN
        if option == 1:
            if who == 1:
                Screen.draw_citizen()
                option = u.input_option(4)
                Command.commands_citizen(option)
                espera = u.input_option(1)
                
            if who == 2:
                Screen.draw_government()
                option = u.input_option(4)
                Command.commands_government(option)
                espera = u.input_option(1)
                
            if who == 3:
                Screen.draw_hospital()
                option = u.input_option(4)
                Command.commands_hospital(option)
                espera = u.input_option(1)  # Apenas para pausar a tela

        if option == 2:
            if who == 1:
                print("Funcao de cadastro de cidadao ainda nao implementada.")
                
            if who == 2:
                print("Funcao de cadastro de governo ainda nao implementada.")
                
            if who == 3:
                print("Funcao de cadastro de hospital ainda nao implementada.")
        