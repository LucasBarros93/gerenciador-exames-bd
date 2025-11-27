
-- LIMPEZA DAS TABELAS ANTES DA INSERCAO (reinicia os indices tb com o restart identity)

BEGIN;

TRUNCATE 
    unidade_atendimento,
    contrato,
    consulta,
    alergia,
    tratamentos,
    prontuario,
    medico,
    crm,
    carteira_trabalho,
    hospital,
    agencia_saude,
    detran,
    empresa,
    idempresa_cnpj,
    cidadao,
    idcidadao_cpf,
    unidade_mte
RESTART IDENTITY CASCADE;

COMMIT;

-- INICIO DA TRANSACAO
BEGIN;
-- ============================
-- 1. INSERIR CIDADÃOS BASE (10)
-- ============================
SAVEPOINT cidadaos;

INSERT INTO idcidadao_cpf (cpf, nome) VALUES
('12345678901', 'Dr Carlos Silva'),
('23456789012', 'Maria Santos'),
('34567890123', 'João Pedro Costa'),
('45678901234', 'Ana Oliveira'),
('56789012345', 'Roberto Lima'),
('67890123456', 'Fernanda Alves'),
('78901234567', 'Paulo Henrique'),
('89012345678', 'Juliana Rocha'),
('90123456789', 'Diego Ferreira'),
('01234567890', 'Camila Barbosa');

INSERT INTO cidadao (idcidadao, nascimento, eh_medico) VALUES
(1, '1975-08-15', true),   -- Dr Carlos
(2, '1992-03-22', false),  -- Maria
(3, '1985-11-10', false),  -- João Pedro
(4, '1980-07-05', true),   -- Ana (médica)
(5, '1990-12-18', false),  -- Roberto
(6, '1988-04-30', false),  -- Fernanda
(7, '1970-09-25', true),   -- Paulo (médico)
(8, '1995-01-14', false),  -- Juliana
(9, '1983-06-08', false),  -- Diego
(10, '1978-10-02', true);  -- Camila (médica)

ROLLBACK TO cidadaos;

-- ============================
-- 2. UNIDADES MTE (10)
-- ============================
SAVEPOINT unidades_mte;

INSERT INTO unidade_mte (nome, rua, numero, bairro) VALUES
('Unidade Central SP', 'Rua das Flores', 123, 'Centro'),
('Unidade Norte RJ', 'Av Brasil', 456, 'Tijuca'),
('Unidade Sul MG', 'Rua Minas', 789, 'Savassi'),
('Unidade Leste RS', 'Av Ipiranga', 321, 'Centro'),
('Unidade Oeste BA', 'Rua Bahia', 654, 'Pelourinho'),
('Unidade Central PE', 'Rua Recife', 987, 'Boa Viagem'),
('Unidade Norte PR', 'Av Curitiba', 147, 'Batel'),
('Unidade Sul SC', 'Rua Floripa', 258, 'Centro'),
('Unidade Leste GO', 'Av Goiania', 369, 'Setor Sul'),
('Unidade Oeste CE', 'Rua Fortaleza', 741, 'Meireles');

ROLLBACK TO unidades_mte;

-- ============================
-- 3. CARTEIRAS DE TRABALHO (10)
-- ============================
SAVEPOINT carteiras;

INSERT INTO carteira_trabalho (cidadao, ultimaatt, tipo, unimte) VALUES
(1, '2024-01-15', 'DIGITAL', 1),
(2, '2024-02-20', 'DIGITAL', 2),
(3, '2024-03-10', 'FÍSICA', 3),
(4, '2024-04-05', 'DIGITAL', 4),
(5, '2024-05-18', 'DIGITAL', 5),
(6, '2024-06-30', 'FÍSICA', 6),
(7, '2024-07-25', 'DIGITAL', 7),
(8, '2024-08-14', 'DIGITAL', 8),
(9, '2024-09-08', 'FÍSICA', 9),
(10, '2024-10-02', 'DIGITAL', 10);

ROLLBACK TO carteiras;

-- ============================
-- 4. CONSELHOS REGIONAIS (10)
-- ============================
SAVEPOINT crms;

INSERT INTO crm (uf, rua, numero, bairro) VALUES
('SP', 'Rua Augusta', 1200, 'Consolação'),
('RJ', 'Av Copacabana', 800, 'Copacabana'),
('MG', 'Rua Amazonas', 400, 'Centro'),
('RS', 'Av Borges', 600, 'Cidade Baixa'),
('BA', 'Rua Chile', 300, 'Pelourinho'),
('PE', 'Av Boa Viagem', 1500, 'Boa Viagem'),
('PR', 'Rua XV Novembro', 900, 'Centro'),
('SC', 'Av Beira Mar', 700, 'Centro'),
('GO', 'Av T4', 200, 'Setor Bueno'),
('CE', 'Av Beira Mar', 1100, 'Meireles');

ROLLBACK TO crms;

-- ============================
-- 5. MÉDICOS (4 dos 10 cidadãos)
-- ============================
SAVEPOINT medicos;

INSERT INTO medico (cidadao, especializacao, crm) VALUES
(1, 'Cardiologia', 1),        -- Dr Carlos
(4, 'Pediatria', 2),          -- Ana
(7, 'Neurologia', 3),         -- Paulo
(10, 'Ginecologia', 4);       -- Camila

ROLLBACK TO medicos;

-- ============================
-- 6. EMPRESAS (10)
-- ============================
SAVEPOINT empresas;

INSERT INTO idempresa_cnpj (cnpj, nome) VALUES
('12345678000101', 'Hospital SP LTDA'),
('12345678000202', 'Clinica RJ SA'),
('12345678000303', 'Hospital MG LTDA'),
('12345678000404', 'DETRAN SP'),
('12345678000505', 'DETRAN RJ'),
('12345678000606', 'Hospital BA LTDA'),
('12345678000707', 'Clinica PE SA'),
('12345678000808', 'Hospital PR LTDA'),
('12345678000909', 'Clinica SC SA'),
('12345678001010', 'Hospital CE LTDA');

INSERT INTO empresa (idempresa, franquia, rua, numero, bairro, tipo) VALUES
(1, NULL, 'Av Paulista', 1000, 'Bela Vista', 'Saúde'),
(2, 'Clinicas RJ', 'Rua Copacabana', 500, 'Copacabana', 'Saúde'),
(3, 'Hospital Minas', 'Av Afonso Pena', 2000, 'Centro', 'Saúde'),
(4, NULL, 'Av Tiradentes', 800, 'Luz', 'Órgão Público'),
(5, NULL, 'Av Presidente', 1200, 'Centro', 'Órgão Público'),
(6, 'Hospital Bahia', 'Av Oceânica', 600, 'Ondina', 'Saúde'),
(7, 'Clinicas PE', 'Av Conde', 400, 'Boa Viagem', 'Saúde'),
(8, 'Hospital Paraná', 'Rua Marechal', 300, 'Centro', 'Saúde'),
(9, 'Clinicas SC', 'Av Atlantica', 700, 'Centro', 'Saúde'),
(10, 'Hospital Ceará', 'Av Beira Mar', 900, 'Meireles', 'Saúde');

ROLLBACK TO empresas;

-- ============================
-- 7. DETRANS (2)
-- ============================
SAVEPOINT detrans;

INSERT INTO detran (empresa, estado) VALUES
(4, 'SP'),  -- DETRAN SP
(5, 'RJ');  -- DETRAN RJ

ROLLBACK TO detrans;

-- ============================
-- 8. HOSPITAIS (8 dos 10)
-- ============================
SAVEPOINT hospitais;

INSERT INTO hospital (empresa, nro_leitos, tipo_atendimento) VALUES
(1, 200, 'Privado'),        -- Hospital SP
(2, 80, 'Privado'),         -- Clinica RJ  
(3, 300, 'Público'),        -- Hospital MG
(6, 150, 'Privado'),        -- Hospital BA
(7, 60, 'Privado'),         -- Clinica PE
(8, 250, 'Público'),        -- Hospital PR
(9, 90, 'Privado'),         -- Clinica SC
(10, 180, 'Público');       -- Hospital CE

ROLLBACK TO hospitais;

-- ============================
-- 9. AGÊNCIAS DE SAÚDE (10)
-- ============================
SAVEPOINT agencias;

INSERT INTO agencia_saude (nome, rua, numero, bairro) VALUES
('ANVISA SP', 'Rua Consolacao', 1000, 'Centro'),
('ANVISA RJ', 'Av Rio Branco', 800, 'Centro'),
('ANVISA MG', 'Rua Bahia', 600, 'Centro'),
('ANVISA RS', 'Av Borges', 400, 'Centro'),
('ANVISA BA', 'Rua Castro', 300, 'Centro'),
('ANVISA PE', 'Av Agamenon', 500, 'Centro'),
('ANVISA PR', 'Rua Barao', 700, 'Centro'),
('ANVISA SC', 'Av Hercilio', 200, 'Centro'),
('ANVISA GO', 'Av T63', 900, 'Centro'),
('ANVISA CE', 'Av Dom Luis', 1200, 'Centro');

ROLLBACK TO agencias;

-- ============================
-- 10. ALVARÁS SANITÁRIOS (8 hospitais)
-- ============================
SAVEPOINT alvaras;

INSERT INTO alvara_sanitario (hospital, data_realizacao, agencia_saude) VALUES
(1, '2024-01-15', 'ANVISA SP'),
(2, '2024-02-20', 'ANVISA RJ'),
(3, '2024-03-10', 'ANVISA MG'),
(6, '2024-04-05', 'ANVISA BA'),
(7, '2024-05-18', 'ANVISA PE'),
(8, '2024-06-30', 'ANVISA PR'),
(9, '2024-07-25', 'ANVISA SC'),
(10, '2024-08-14', 'ANVISA CE');

ROLLBACK TO alvaras;

-- ============================
-- 11. PRONTUÁRIOS (10)
-- ============================
SAVEPOINT prontuarios;

INSERT INTO prontuario (cidadao, criacao, ultima_att, historico) VALUES
(1, '2020-01-10', '2024-11-20', 'Médico cardiologista sem comorbidades'),
(2, '2021-03-15', '2024-11-18', 'Paciente com hipertensão controlada'),
(3, '2022-07-20', '2024-11-15', 'Histórico de diabetes tipo 2'),
(4, '2019-05-08', '2024-11-22', 'Médica pediatra em excelente saúde'),
(5, '2023-01-12', '2024-11-10', 'Paciente jovem sem histórico relevante'),
(6, '2020-09-30', '2024-11-25', 'Histórico de alergias alimentares'),
(7, '2018-11-05', '2024-11-12', 'Médico neurologista com burnout tratado'),
(8, '2024-02-14', '2024-11-20', 'Paciente nova sem comorbidades'),
(9, '2021-06-18', '2024-11-19', 'Histórico de ansiedade em tratamento'),
(10, '2017-04-22', '2024-11-21', 'Médica ginecologista saudável');

ROLLBACK TO prontuarios;

-- ============================
-- 12. TRATAMENTOS (30 total)
-- ============================
SAVEPOINT tratamentos;

INSERT INTO tratamentos (prontuario, tratamento) VALUES
(1, 'Aspirina 100mg'), (1, 'Atorvastatina 20mg'), (1, 'Exercicios cardiacos'),
(2, 'Losartana 50mg'), (2, 'Hidroclorotiazida 25mg'), (2, 'Dieta hipossodica'),
(3, 'Metformina 500mg'), (3, 'Glibenclamida 5mg'), (3, 'Controle glicemico'),
(4, 'Vitamina D3'), (4, 'Omega 3'), (4, 'Exercicios regulares'),
(5, 'Polivitaminico'), (5, 'Proteina whey'), (5, 'Musculacao'),
(6, 'Antialergico'), (6, 'Probioticos'), (6, 'Dieta restritiva'),
(7, 'Sertralina 50mg'), (7, 'Terapia cognitiva'), (7, 'Meditacao'),
(8, 'Acido folico'), (8, 'Ferro quelato'), (8, 'Vitamina C'),
(9, 'Alprazolam 0.5mg'), (9, 'Psicoterapia'), (9, 'Relaxamento'),
(10, 'Calcio com D3'), (10, 'Magnesio'), (10, 'Pilates');

ROLLBACK TO tratamentos;

-- ============================
-- 13. ALERGIAS (20 total)
-- ============================
SAVEPOINT alergias;

INSERT INTO alergia (prontuario, alergia) VALUES
(1, 'Penicilina'), (1, 'Frutos do mar'),
(2, 'AAS'), (2, 'Latex'),
(3, 'Gluten'), (3, 'Lactose'),
(4, 'Polen'), (4, 'Acaro'),
(5, 'Amendoim'), (5, 'Soja'),
(6, 'Ovo'), (6, 'Leite'),
(7, 'Dipirona'), (7, 'Sulfas'),
(8, 'Perfume'), (8, 'Tintura'),
(9, 'Aspirina'), (9, 'Contraste'),
(10, 'Crustaceos'), (10, 'Pelo de gato');

ROLLBACK TO alergias;

-- ============================
-- 14. CONSULTAS (20 total)
-- ============================
SAVEPOINT consultas;

INSERT INTO consulta (cidadao, hospital, data_hora, medico) VALUES
-- Consultas já realizadas
(2, 1, '2024-11-01 09:00:00', 1),  -- Maria com Dr Carlos
(3, 1, '2024-11-02 10:30:00', 1),  -- João com Dr Carlos
(5, 2, '2024-11-03 14:00:00', 4),  -- Roberto com Ana
(6, 2, '2024-11-04 15:30:00', 4),  -- Fernanda com Ana
(8, 3, '2024-11-05 08:00:00', 7),  -- Juliana com Paulo
(9, 3, '2024-11-06 11:00:00', 7),  -- Diego com Paulo

-- Consultas futuras
(2, 1, '2024-12-01 09:00:00', 1),  -- Maria retorno
(3, 1, '2024-12-02 10:30:00', 1),  -- João retorno
(5, 2, '2024-12-03 14:00:00', 4),  -- Roberto retorno
(6, 2, '2024-12-04 15:30:00', 4),  -- Fernanda retorno
(8, 6, '2024-12-05 08:00:00', 10), -- Juliana com Camila
(9, 6, '2024-12-06 11:00:00', 10), -- Diego com Camila
(2, 8, '2024-12-07 16:00:00', 7),  -- Maria com Paulo
(3, 8, '2024-12-08 13:30:00', 7),  -- João com Paulo
(5, 9, '2024-12-09 09:30:00', 4),  -- Roberto consulta SC
(6, 9, '2024-12-10 14:15:00', 4),  -- Fernanda consulta SC

-- Consultas de hoje
(8, 10, '2024-11-26 16:00:00', 10), -- Juliana hoje
(9, 10, '2024-11-26 17:30:00', 10), -- Diego hoje

-- Consultas emergenciais
(2, 3, '2024-12-11 07:00:00', 7),  -- Maria emergência
(5, 1, '2024-12-12 18:00:00', 1);  -- Roberto emergência

ROLLBACK TO consultas;

-- ============================
-- 15. RELACIONAMENTOS (20)
-- ============================
SAVEPOINT relacionamentos;

INSERT INTO rel_prontuario_hospital (prontuario, hospital) VALUES
(1, 1), (1, 2),     -- Dr Carlos: SP e RJ
(2, 1), (2, 3), (2, 8),  -- Maria: SP, MG, PR
(3, 1), (3, 8),     -- João: SP e PR
(4, 2), (4, 6),     -- Ana: RJ e BA
(5, 2), (5, 9), (5, 1),  -- Roberto: RJ, SC, SP
(6, 2), (6, 6), (6, 9),  -- Fernanda: RJ, BA, SC
(7, 3), (7, 8),     -- Paulo: MG e PR
(8, 6), (8, 10),    -- Juliana: BA e CE
(9, 3), (9, 10),    -- Diego: MG e CE
(10, 6), (10, 7);   -- Camila: BA e PE

ROLLBACK TO relacionamentos;

-- ============================
-- 16. CONTRATOS (20)
-- ============================
SAVEPOINT contratos;

INSERT INTO contrato (carteira_trabalho, empresa, admissao, demissao, cargo, salario, inicio_ferias, fim_ferias) VALUES
-- Contratos ativos
(1, 1, '2020-01-15', NULL, 'Medico', 15000.00, '2024-01-15', '2024-02-15'),
(2, 2, '2021-03-10', NULL, 'Enfermeira', 4500.00, '2024-07-01', '2024-08-01'),
(3, 3, '2022-05-20', NULL, 'Tecnico', 3200.00, '2024-06-15', '2024-07-15'),
(4, 2, '2019-08-01', NULL, 'Medica', 18000.00, '2024-03-01', '2024-04-01'),
(5, 6, '2023-02-14', NULL, 'Auxiliar', 2800.00, '2024-12-01', '2024-12-31'),
(6, 7, '2020-11-30', NULL, 'Recepcionista', 2200.00, '2024-09-01', '2024-10-01'),
(7, 3, '2018-07-08', NULL, 'Medico', 16000.00, '2024-05-01', '2024-06-01'),
(8, 8, '2024-01-10', NULL, 'Estagiaria', 1412.00, NULL, NULL),
(9, 9, '2021-09-15', NULL, 'Analista', 5500.00, '2024-11-01', '2024-12-01'),
(10, 10, '2017-06-22', NULL, 'Medica', 17500.00, '2024-08-01', '2024-09-01'),

-- Contratos encerrados
(2, 1, '2019-01-01', '2020-12-31', 'Auxiliar', 2000.00, '2020-07-01', '2020-08-01'),
(3, 2, '2020-02-01', '2021-11-30', 'Tecnico', 2800.00, '2021-06-01', '2021-07-01'),
(5, 7, '2021-03-15', '2022-08-31', 'Enfermeiro', 3800.00, '2022-01-01', '2022-02-01'),
(6, 8, '2018-05-01', '2020-03-15', 'Secretaria', 2200.00, '2019-12-01', '2020-01-01'),
(8, 9, '2022-08-10', '2023-12-20', 'Trainee', 3000.00, '2023-06-01', '2023-07-01'),
(9, 10, '2020-04-01', '2021-02-28', 'Analista Jr', 3500.00, '2020-12-01', '2021-01-01'),
(1, 6, '2015-01-01', '2019-12-31', 'Residente', 2800.00, '2019-07-01', '2019-08-01'),
(4, 7, '2016-03-01', '2019-02-28', 'Especialista', 12000.00, '2018-12-01', '2019-01-01'),
(7, 1, '2010-06-01', '2018-05-31', 'Neurologista', 14000.00, '2017-11-01', '2017-12-01'),
(10, 8, '2014-09-01', '2017-04-30', 'Ginecologista', 13500.00, '2016-12-01', '2017-01-01');

ROLLBACK TO contratos;

-- ============================
-- 17. UNIDADES DETRAN (20)
-- ============================
SAVEPOINT unidades_atendimento;

INSERT INTO unidade_atendimento (detran, cidade, rua, numero, bairro) VALUES
-- DETRAN SP
(4, 'São Paulo', 'Av Paulista', 1000, 'Bela Vista'),
(4, 'São Paulo', 'Rua Augusta', 500, 'Centro'),
(4, 'Guarulhos', 'Av Santos', 200, 'Centro'),
(4, 'Osasco', 'Rua Principal', 300, 'Centro'),
(4, 'Santo André', 'Av Industrial', 150, 'Centro'),
(4, 'São Caetano', 'Rua Direita', 80, 'Centro'),
(4, 'Diadema', 'Av Alda', 400, 'Centro'),
(4, 'Mauá', 'Rua Maua', 250, 'Centro'),
(4, 'Ribeirão Preto', 'Av Brasil', 600, 'Centro'),
(4, 'Campinas', 'Rua Barão', 350, 'Cambuí'),

-- DETRAN RJ
(5, 'Rio de Janeiro', 'Av Copacabana', 800, 'Copacabana'),
(5, 'Rio de Janeiro', 'Rua Voluntários', 600, 'Botafogo'),
(5, 'Niterói', 'Rua Coronel', 150, 'Icaraí'),
(5, 'Duque de Caxias', 'Av Gov Leonel', 300, 'Centro'),
(5, 'Nova Iguaçu', 'Rua Minas Gerais', 450, 'Centro'),
(5, 'São Gonçalo', 'Av Presidente', 200, 'Centro'),
(5, 'Volta Redonda', 'Rua do Aço', 100, 'Vila Santa'),
(5, 'Petrópolis', 'Rua do Imperador', 350, 'Centro'),
(5, 'Campos', 'Av Alberto Torres', 500, 'Centro'),
(5, 'Macaé', 'Rua Direita', 180, 'Centro');

ROLLBACK TO unidades_atendimento;

COMMIT;