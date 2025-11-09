-- Cidadãos
INSERT INTO Cidadao (cpf, nome, data_nasc, eh_medico) VALUES
('69696969696', 'Joao Pedro Machado Medeiros Ultra Mega Descolado', '2004-02-14', true),
('22233344455', 'Joaozinho Coco nas Calcas', '1504-02-28', true);

-- CRM
INSERT INTO CRM (estado, endereco) VALUES
('SP', 'Av. Paulista, 1000'),
('RJ', 'Rua Rio Branco, 200');

-- Médicos
-- primeiro cadastre os cidadaos que são médicos (Carlos)
INSERT INTO Medico (cidadao_fk, id_crm, numero_crm, especializacao)
VALUES
(2, 1, 'SP-12345', 'Clínico Geral'),
(1, 2, 'RJ-99999', 'Neurologia');

-- Empresas (hospitais, detran)
INSERT INTO Empresa (cnpj, nome, rua, numero, bairro) VALUES
('12345678000100', 'Hospital São Lucas', 'Rua A', '100', 'Centro'),
('22345678000111', 'DETRAN-SP', 'Av. X', '500', 'BairroX'),
('32345678000122', 'Hospital Vida', 'Rua B', '222', 'BairroY');

-- Hospitais (referenciam empresa)
INSERT INTO Hospital (id_hospital, num_leitos, tipo_atendimento, licenciado)
VALUES
(1, 120, 'Geral', TRUE),
(3, 40, 'Clínico', FALSE);

-- Detran (empresa 2)
INSERT INTO Detran (id_detran, estado) VALUES
(2, 'SP');

-- Unidades de Atendimento
INSERT INTO UnidadeAtendimento (detran_fk, cidade, endereco) VALUES
(2, 'São Paulo', 'Av. X, 500'),
(2, 'Campinas', 'Rua Campinas, 10');

-- Alvarás
INSERT INTO Alvara_Sanitario (hospital_fk, data_emissao, agencia_saude)
VALUES
(1, '2024-05-10', 'Agência SP'),
(3, '2023-07-20', 'Agência SP');

-- Prontuários
INSERT INTO Prontuario (cidadao_fk, data_criacao, ultima_atualizacao)
VALUES
(1, '2023-01-01', '2024-09-01'),
(2, '2022-02-02', '2024-08-01');

-- Alergias e Tratamentos
INSERT INTO Alergia (prontuario_fk, descricao) VALUES
(1, 'Penicilina'),
(2, 'Amendoim');

INSERT INTO Tratamento (prontuario_fk, descricao) VALUES
(1, 'Fisioterapia'),
(2, 'Antidepressivo');

-- Carteira de Trabalho
INSERT INTO Carteira_Trabalho (cidadao_fk, tipo, data_ultima_atualizacao, unidade_emissora)
VALUES
(1, 'digital', '2020-03-01', 'Uni MTE SP'),
(2, 'fisica', '2018-05-15', 'Uni MTE RJ');

-- Contratos
INSERT INTO Contrato (carteira_fk, empresa_fk, data_admissao, data_demissao, cargo, salario)
VALUES
(1, 1, '2021-06-01', NULL, 'Recepcionista', 2500.00),
(2, 1, '2020-01-10', '2022-12-31', 'Enfermeiro', 3800.00);

-- Consultas
INSERT INTO Consulta (cidadao_fk, hospital_fk, data_hora, medico_fk, motivo)
VALUES
(1, 1, '2024-10-01 09:00:00', 1, 'Agendamento CNH'),
(2, 1, '2024-10-02 10:30:00', 1, 'Exame admissional');

-- Exames Médico CNH
INSERT INTO Exame_Medico_CNH (consulta_fk, medico_fk, resultado, usa_oculos, pcd, grau_ametropia, data_exame, unidade_fk, detran_fk)
VALUES
(1, 1, 'APTO', FALSE, FALSE, NULL, '2024-10-01', 1, 2),
(2, 1, 'APTO', TRUE, FALSE, '-1.25', '2024-10-02', 1, 2);

-- Exame Psicotécnico
INSERT INTO Exame_Psicotecnico (consulta_fk, medico_fk, resultado, info_extra, data_exame, unidade_fk, detran_fk)
VALUES
(1, 1, 'APTO', 'Bom nível de atenção', '2024-10-01', 1, 2),
(2, 1, 'APTO', 'OK', '2024-10-02', 1, 2);

-- Exame Toxicológico
INSERT INTO Exame_Toxicologico (consulta_fk, medico_fk, resultado, substancias_detectadas, data_exame, unidade_fk, detran_fk)
VALUES
(1, 1, 'NEGATIVO', '', '2024-10-01', 1, 2),
(2, 1, 'NEGATIVO', '', '2024-10-02', 1, 2);

-- Exame Admissional (vinculado a contrato)
INSERT INTO Exame_Admissional (contrato_fk, medico_fk, resultado, data_exame)
VALUES
(1, 1, 'APTO', '2021-06-01'),
(2, 1, 'APTO', '2020-01-10');

-- CNH
INSERT INTO CNH (cidadao_fk, tipo, data_emissao, data_vencimento, detran_fk)
VALUES
(1, 'B', '2020-07-01', '2025-07-01', 2),
(2, 'B', '2019-05-20', '2024-05-20', 2);

-- RelProntuarioHospital
INSERT INTO RelProntuarioHospital (prontuario_fk, hospital_fk, data_acesso)
VALUES
(1, 1, now()),
(2, 1, now());

-- Substancias & Ametropia (exemplo)
INSERT INTO Substancia (exame_toxic_fk, nome) VALUES (1, 'NADA'), (2, 'NADA');
INSERT INTO Ametropia (exame_cnh_fk, descricao) VALUES (2, '-1.25');

-- Fim dados