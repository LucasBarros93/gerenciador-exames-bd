from datetime import datetime

class Medico:
    def __init__(self, cidadao_fk, id_crm, numero_crm, especializacao=None):
        self.id_medico = None
        self.cidadao_fk = cidadao_fk
        self.id_crm = id_crm
        self.numero_crm = numero_crm
        self.especializacao = especializacao
    
    def __str__(self):
        return f"Médico(ID: {self.id_medico}, CRM: {self.numero_crm}, Especialização: {self.especializacao})"
    
    def to_dict(self):
        return {
            'id_medico': self.id_medico,
            'cidadao_fk': self.cidadao_fk,
            'id_crm': self.id_crm,
            'numero_crm': self.numero_crm,
            'especializacao': self.especializacao
        }

class CRM:
    def __init__(self, estado, endereco=None):
        self.id_crm = None
        self.estado = estado
        self.endereco = endereco
    
    def __str__(self):
        return f"CRM(ID: {self.id_crm}, Estado: {self.estado})"
    
    def to_dict(self):
        return {
            'id_crm': self.id_crm,
            'estado': self.estado,
            'endereco': self.endereco
        }
