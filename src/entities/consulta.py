from datetime import datetime


class Consulta:
    def __init__(self, id, cidadao, hospital, data_hora, medico=None):
        self.id = id
        self.cidadao = cidadao
        self.hospital = hospital
        self.data_hora = data_hora
        self.medico = medico

    def __str__(self):
        return f"Consulta(ID: {self.id}, Hospital: {self.hospital}, Data: {self.data_hora.strftime("%d.%m.%y as %H:%M")})"

    def to_dict(self):
        return {
            "id_consulta": self.id,
            "cidadao": self.cidadao,
            "hospital": self.hospital,
            "data_hora": self.data_hora,
            "medico": self.medico,
        }
