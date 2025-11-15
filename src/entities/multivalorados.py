class Substancia:
    def __init__(self, exame_toxic_fk, nome):
        self.id = None
        self.exame_toxic_fk = exame_toxic_fk
        self.nome = nome
    
    def __str__(self):
        return f"Substancia(ID: {self.id}, Nome: {self.nome})"
    
    def to_dict(self):
        return {
            'id': self.id,
            'exame_toxic_fk': self.exame_toxic_fk,
            'nome': self.nome
        }

class Ametropia:
    def __init__(self, exame_cnh_fk, descricao):
        self.id = None
        self.exame_cnh_fk = exame_cnh_fk
        self.descricao = descricao
    
    def __str__(self):
        return f"Ametropia(ID: {self.id}, Descrição: {self.descricao})"
    
    def to_dict(self):
        return {
            'id': self.id,
            'exame_cnh_fk': self.exame_cnh_fk,
            'descricao': self.descricao
        }
