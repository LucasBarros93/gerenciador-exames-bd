def input_option(n):
    while True:
        try:
            option = int(input())
            if 1 <= option <= n:
                return option
        except ValueError:
            pass

        print("Valor invalido")
