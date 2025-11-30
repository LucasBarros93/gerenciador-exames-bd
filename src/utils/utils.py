from datetime import datetime


def input_option(n):
    while True:
        try:
            option = int(input())
            if 1 <= option <= n:
                return option
        except ValueError:
            pass

        print("Valor invalido")


def input_valid_date(strg):
    while True:
        try:
            date_str = input(strg)
            datetime.strptime(date_str, "%d/%m/%Y")
            return date_str

        except ValueError:
            pass

        print("Valor invalido")
