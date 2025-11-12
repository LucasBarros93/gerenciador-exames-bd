from src.screens import screen

if __name__ == "__main__":
    while True:
        Screen = screen.Screen()
        Screen.draw_welcome()

        option = int(input())

        if(option == 3):
            break

        if(option == 1):
            Screen.draw_who()
            who = int(input())

            Screen.draw_login(who)
        
        if(option == 2):
            Screen.draw_who()
            who = int(input())



