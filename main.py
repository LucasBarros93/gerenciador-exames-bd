from src.screens import screen
from src.utils import utils as u

if __name__ == "__main__":
    while True:
        Screen = screen.Screen()
        Screen.draw_welcome()

        option = u.input_option(3)

        if(option == 3):
            break

        if(option == 1):
            Screen.draw_who()
            who = int(input())

            Screen.draw_login(who)
        
        if(option == 2):
            Screen.draw_who()
            who = int(input())

            Screen.draw_login(who)

