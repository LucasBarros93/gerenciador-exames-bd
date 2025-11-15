from datetime import datetime

class UnidadeAtendimento:
    def __init__(self, detran_fk, cidade=None, endereco=None):
        self.id_unidade = None
        self.detran_fk = detran_fk
        self.cidade = cidade
        self.endereco = endereco
    
    def __str__(self):
        return f"UnidadeAtendimento(ID: {self.id_unidade}, Cidade: {self.cidade}, DETRAN: {self.detran_fk})"
    
    def to_dict(self):
        return {
            'id_unidade': self.id_unidade,
            'detran_fk': self.detran_fk,
            'cidade': self.cidade,
            'endereco': self.endereco
        }

class AlvaraSanitario:
    def __init__(self, hospital_fk, data_emissao, agencia_saude=None):
        self.id_alvara = None
        self.hospital_fk = hospital_fk
        self.data_emissao = data_emissao
        self.agencia_saude = agencia_saude
    
    def __str__(self):
        return f"AlvaraSanitario(ID: {self.id_alvara}, Hospital: {self.hospital_fk}, Emissão: {self.data_emissao})"
    
    def to_dict(self):
        return {
            'id_alvara': self.id_alvara,
            'hospital_fk': self.hospital_fk,
            'data_emissao': self.data_emissao,
            'agencia_saude': self.agencia_saude
        }

class RelProntuarioHospital:
    def __init__(self, prontuario_fk, hospital_fk, data_acesso=None):
        self.prontuario_fk = prontuario_fk
        self.hospital_fk = hospital_fk
        self.data_acesso = data_acesso or datetime.now()
    
    def __str__(self):
        return f"RelProntuarioHospital(Prontuário: {self.prontuario_fk}, Hospital: {self.hospital_fk}, Acesso: {self.data_acesso})"
    
    def to_dict(self):
        return {
            'prontuario_fk': self.prontuario_fk,
            'hospital_fk': self.hospital_fk,
            'data_acesso': self.data_acesso
        }
