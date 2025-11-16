from datetime import date


class CNH:
    def __init__(self, cidadao_fk, tipo, data_emissao, data_vencimento, detran_fk):
        self.numero_cnh = None
        self.cidadao_fk = cidadao_fk
        self.tipo = tipo  # A, B, C, D, E, ACC
        self.data_emissao = data_emissao
        self.data_vencimento = data_vencimento
        self.detran_fk = detran_fk

    def __str__(self):
        return f"CNH(Número: {self.numero_cnh}, Tipo: {self.tipo}, Vencimento: {self.data_vencimento})"

    def to_dict(self):
        return {
            "numero_cnh": self.numero_cnh,
            "cidadao_fk": self.cidadao_fk,
            "tipo": self.tipo,
            "data_emissao": self.data_emissao,
            "data_vencimento": self.data_vencimento,
            "detran_fk": self.detran_fk,
        }

    def is_valid(self):
        """Verifica se a CNH está dentro da validade"""
        return self.data_vencimento >= date.today()


class CarteiraTrabalho:
    def __init__(
        self, cidadao_fk, tipo=None, data_ultima_atualizacao=None, unidade_emissora=None
    ):
        self.id_carteira = None
        self.cidadao_fk = cidadao_fk
        self.tipo = tipo  # digital ou física
        self.data_ultima_atualizacao = data_ultima_atualizacao
        self.unidade_emissora = unidade_emissora

    def __str__(self):
        return f"CarteiraTrabalho(ID: {self.id_carteira}, Tipo: {self.tipo}, Última Atualização: {self.data_ultima_atualizacao})"

    def to_dict(self):
        return {
            "id_carteira": self.id_carteira,
            "cidadao_fk": self.cidadao_fk,
            "tipo": self.tipo,
            "data_ultima_atualizacao": self.data_ultima_atualizacao,
            "unidade_emissora": self.unidade_emissora,
        }
