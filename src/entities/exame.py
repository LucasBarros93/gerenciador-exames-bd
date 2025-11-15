from datetime import datetime

class ExameMedicoCNH:
    def __init__(self, consulta_fk, medico_fk, resultado=None, usa_oculos=False, pcd=False, data_exame=None, unidade_fk=None, detran_fk=None):
        self.id = None
        self.consulta_fk = consulta_fk
        self.medico_fk = medico_fk
        self.resultado = resultado
        self.usa_oculos = usa_oculos
        self.pcd = pcd
        self.data_exame = data_exame or datetime.now().date()
        self.unidade_fk = unidade_fk
        self.detran_fk = detran_fk
    
    def __str__(self):
        return f"ExameMedicoCNH(ID: {self.id}, Resultado: {self.resultado}, Data: {self.data_exame})"
    
    def to_dict(self):
        return {
            'id': self.id,
            'consulta_fk': self.consulta_fk,
            'medico_fk': self.medico_fk,
            'resultado': self.resultado,
            'usa_oculos': self.usa_oculos,
            'pcd': self.pcd,
            'data_exame': self.data_exame,
            'unidade_fk': self.unidade_fk,
            'detran_fk': self.detran_fk
        }

class ExamePsicotecnico:
    def __init__(self, consulta_fk, medico_fk, resultado=None, info_extra=None, data_exame=None, unidade_fk=None, detran_fk=None):
        self.id = None
        self.consulta_fk = consulta_fk
        self.medico_fk = medico_fk
        self.resultado = resultado
        self.info_extra = info_extra
        self.data_exame = data_exame or datetime.now().date()
        self.unidade_fk = unidade_fk
        self.detran_fk = detran_fk
    
    def __str__(self):
        return f"ExamePsicotecnico(ID: {self.id}, Resultado: {self.resultado}, Data: {self.data_exame})"
    
    def to_dict(self):
        return {
            'id': self.id,
            'consulta_fk': self.consulta_fk,
            'medico_fk': self.medico_fk,
            'resultado': self.resultado,
            'info_extra': self.info_extra,
            'data_exame': self.data_exame,
            'unidade_fk': self.unidade_fk,
            'detran_fk': self.detran_fk
        }

class ExameToxicologico:
    def __init__(self, consulta_fk, medico_fk, resultado=None, data_exame=None, unidade_fk=None, detran_fk=None):
        self.id = None
        self.consulta_fk = consulta_fk
        self.medico_fk = medico_fk
        self.resultado = resultado
        self.data_exame = data_exame or datetime.now().date()
        self.unidade_fk = unidade_fk
        self.detran_fk = detran_fk
    
    def __str__(self):
        return f"ExameToxicologico(ID: {self.id}, Resultado: {self.resultado}, Data: {self.data_exame})"
    
    def to_dict(self):
        return {
            'id': self.id,
            'consulta_fk': self.consulta_fk,
            'medico_fk': self.medico_fk,
            'resultado': self.resultado,
            'data_exame': self.data_exame,
            'unidade_fk': self.unidade_fk,
            'detran_fk': self.detran_fk
        }

class ExameAdmissional:
    def __init__(self, contrato_fk, medico_fk, resultado=None, data_exame=None):
        self.id = None
        self.contrato_fk = contrato_fk
        self.medico_fk = medico_fk
        self.resultado = resultado
        self.data_exame = data_exame or datetime.now().date()
    
    def __str__(self):
        return f"ExameAdmissional(ID: {self.id}, Resultado: {self.resultado}, Data: {self.data_exame})"
    
    def to_dict(self):
        return {
            'id': self.id,
            'contrato_fk': self.contrato_fk,
            'medico_fk': self.medico_fk,
            'resultado': self.resultado,
            'data_exame': self.data_exame
        }
