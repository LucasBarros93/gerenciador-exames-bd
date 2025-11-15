from datetime import datetime

class Consulta:
    def __init__(self, cidadao_fk, hospital_fk, data_hora, medico_fk=None, motivo=None):
        self.id_consulta = None
        self.cidadao_fk = cidadao_fk
        self.hospital_fk = hospital_fk
        self.data_hora = data_hora
        self.medico_fk = medico_fk
        self.motivo = motivo
    
    def __str__(self):
        return f"Consulta(ID: {self.id_consulta}, Data: {self.data_hora}, Motivo: {self.motivo})"
    
    def to_dict(self):
        return {
            'id_consulta': self.id_consulta,
            'cidadao_fk': self.cidadao_fk,
            'hospital_fk': self.hospital_fk,
            'data_hora': self.data_hora,
            'medico_fk': self.medico_fk,
            'motivo': self.motivo
        }
