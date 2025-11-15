"""
Entities module for the Gerenciador de Exames BD system.

This module contains all entity classes that represent the database tables
as defined in the Entity-Relationship model from the document.

Main entities:
- Cidadao (Citizen): Central entity representing citizens
- Medico (Doctor): Specialization of Cidadao
- Empresa (Company): Generic company entity
- Hospital: Specialization of Empresa
- Detran: Specialization of Empresa
- Consulta (Appointment): Medical appointments
- Exames (Exams): Different types of medical exams
- Prontuario (Medical Record): Patient medical records
- CNH (Driver's License): Driver's license documents
- CarteiraTrabalho (Work Card): Work permit documents
- Contrato (Contract): Work contracts

Usage:
    from src.entities.citizen import Cidadao
    from src.entities.medico import Medico
    from src.entities.empresa import Empresa, Hospital, Detran
    # ... etc
"""

# Main entities
from .citizen import Cidadao
from .medico import Medico, CRM
from .empresa import Empresa, Hospital, Detran
from .consulta import Consulta
from .exame import ExameMedicoCNH, ExamePsicotecnico, ExameToxicologico, ExameAdmissional
from .prontuario import Prontuario, Alergia, Tratamento
from .documentos import CNH, CarteiraTrabalho
from .contrato import Contrato
from .auxiliares import UnidadeAtendimento, AlvaraSanitario, RelProntuarioHospital
from .multivalorados import Substancia, Ametropia

__all__ = [
    'Cidadao',
    'Medico', 'CRM',
    'Empresa', 'Hospital', 'Detran',
    'Consulta',
    'ExameMedicoCNH', 'ExamePsicotecnico', 'ExameToxicologico', 'ExameAdmissional',
    'Prontuario', 'Alergia', 'Tratamento',
    'CNH', 'CarteiraTrabalho',
    'Contrato',
    'UnidadeAtendimento', 'AlvaraSanitario', 'RelProntuarioHospital',
    'Substancia', 'Ametropia'
]
