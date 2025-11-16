class Empresa:
    def __init__(self, cnpj, nome, rua=None, numero=None, bairro=None):
        self.id_empresa = None
        self.cnpj = cnpj
        self.nome = nome
        self.rua = rua
        self.numero = numero
        self.bairro = bairro

    def __str__(self):
        return f"Empresa(ID: {self.id_empresa}, Nome: {self.nome}, CNPJ: {self.cnpj})"

    def to_dict(self):
        return {
            "id_empresa": self.id_empresa,
            "cnpj": self.cnpj,
            "nome": self.nome,
            "rua": self.rua,
            "numero": self.numero,
            "bairro": self.bairro,
        }


class Hospital:
    def __init__(
        self, id_hospital, num_leitos=None, tipo_atendimento=None, licenciado=False
    ):
        self.id_hospital = id_hospital  # FK para Empresa
        self.num_leitos = num_leitos
        self.tipo_atendimento = tipo_atendimento
        self.licenciado = licenciado

    def __str__(self):
        return f"Hospital(ID: {self.id_hospital}, Leitos: {self.num_leitos}, Licenciado: {self.licenciado})"

    def to_dict(self):
        return {
            "id_hospital": self.id_hospital,
            "num_leitos": self.num_leitos,
            "tipo_atendimento": self.tipo_atendimento,
            "licenciado": self.licenciado,
        }


class Detran:
    def __init__(self, id_detran, estado):
        self.id_detran = id_detran  # FK para Empresa
        self.estado = estado

    def __str__(self):
        return f"Detran(ID: {self.id_detran}, Estado: {self.estado})"

    def to_dict(self):
        return {"id_detran": self.id_detran, "estado": self.estado}
