from datetime import date
from decimal import Decimal

class Contrato:
    def __init__(self, carteira_fk, empresa_fk, data_admissao=None, data_demissao=None, cargo=None, salario=None):
        self.numero_contrato = None
        self.carteira_fk = carteira_fk
        self.empresa_fk = empresa_fk
        self.data_admissao = data_admissao
        self.data_demissao = data_demissao
        self.cargo = cargo
        self.salario = salario
    
    def __str__(self):
        return f"Contrato(Número: {self.numero_contrato}, Cargo: {self.cargo}, Salário: {self.salario})"
    
    def to_dict(self):
        return {
            'numero_contrato': self.numero_contrato,
            'carteira_fk': self.carteira_fk,
            'empresa_fk': self.empresa_fk,
            'data_admissao': self.data_admissao,
            'data_demissao': self.data_demissao,
            'cargo': self.cargo,
            'salario': self.salario
        }
    
    def is_active(self):
        """Verifica se o contrato está ativo"""
        today = date.today()
        if self.data_demissao:
            return self.data_admissao <= today <= self.data_demissao
        return self.data_admissao <= today if self.data_admissao else True
