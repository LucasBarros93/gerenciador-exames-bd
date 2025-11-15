from datetime import datetime

class Cidadao:
    def __init__(self, cpf, nome, data_nasc, eh_medico=False):
        self.id_cidadao = None
        self.cpf = cpf
        self.nome = nome
        self.data_nasc = data_nasc
        self.eh_medico = eh_medico
        self.created_at = datetime.now()
    
    def __str__(self):
        return f"Cidadão(ID: {self.id_cidadao}, Nome: {self.nome}, CPF: {self.cpf})"
    
    def to_dict(self):
        return {
            'id_cidadao': self.id_cidadao,
            'cpf': self.cpf,
            'nome': self.nome,
            'data_nasc': self.data_nasc,
            'eh_medico': self.eh_medico,
            'created_at': self.created_at
        }
