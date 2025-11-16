from datetime import datetime, date


class Prontuario:
    def __init__(self, cidadao_fk, data_criacao=None, ultima_atualizacao=None):
        self.id_prontuario = None
        self.cidadao_fk = cidadao_fk
        self.data_criacao = data_criacao or date.today()
        self.ultima_atualizacao = ultima_atualizacao

    def __str__(self):
        return f"Prontuario(ID: {self.id_prontuario}, Cidadão: {self.cidadao_fk}, Criação: {self.data_criacao})"

    def to_dict(self):
        return {
            "id_prontuario": self.id_prontuario,
            "cidadao_fk": self.cidadao_fk,
            "data_criacao": self.data_criacao,
            "ultima_atualizacao": self.ultima_atualizacao,
        }


class Alergia:
    def __init__(self, prontuario_fk, descricao):
        self.id = None
        self.prontuario_fk = prontuario_fk
        self.descricao = descricao

    def __str__(self):
        return f"Alergia(ID: {self.id}, Descrição: {self.descricao})"

    def to_dict(self):
        return {
            "id": self.id,
            "prontuario_fk": self.prontuario_fk,
            "descricao": self.descricao,
        }


class Tratamento:
    def __init__(self, prontuario_fk, descricao):
        self.id = None
        self.prontuario_fk = prontuario_fk
        self.descricao = descricao

    def __str__(self):
        return f"Tratamento(ID: {self.id}, Descrição: {self.descricao})"

    def to_dict(self):
        return {
            "id": self.id,
            "prontuario_fk": self.prontuario_fk,
            "descricao": self.descricao,
        }
