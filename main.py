from src.screens import screen
from src.utils import utils as u

if __name__ == "__main__":
    while True:
        Screen = screen.Screen()
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
        
        if option == 2:
            Screen.draw_who()
            who = u.input_option(3)

            Screen.draw_sing_up(who)

        # CITIZEN MAIN
        if who == 1:
            Screen.draw_citizen()
            option = u.input_option(4)

