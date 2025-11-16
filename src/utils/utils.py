def input_option(n):
    while True:
        try:
            option = int(input())
            if 1 <= option <= n:
                return option
        except ValueError:
            pass

        print("Valor invalido")


def checkCidadaoLogin(cpf, password):
    # Placeholder function for checking citizen login
    # In a real implementation, this would check against a database or other data source
    if cpf == "valid_cpf" and password == "valid_password":
        return True
    return False
