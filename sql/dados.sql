
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
-- 1. INSERIR CIDADÃOS BASE (30)
-- ============================
INSERT INTO idcidadao_cpf (cpf, senha, nome) VALUES
-- MÉDICOS (8)
('12345678901', '12345678', 'Dr Carlos Silva'),      -- Cardiologista (49 anos)
('45678901234', '12345678', 'Ana Oliveira'),         -- Pediatra (44 anos)
('78901234567', 'badpassword', 'Paulo Henrique'),       -- Neurologista (54 anos)
('01234567890', 'senhasuperforte', 'Camila Barbosa'),       -- Ginecologista (46 anos)
('11111111111', 'vaicorintians', 'Dr Ricardo Mendes'),    -- Ortopedista (51 anos)
('44444444444', 'eusouohomemdeferro', 'Dra Marina Souza'),     -- Dermatologista (45 anos)
('77777777777', '87654321', 'Dr André Lima'),        -- Psiquiatra (52 anos)
('10101010101', 'aaaaaaaa', 'Dra Carolina Dias'),    -- Cardiologista (48 anos)

-- NÃO MÉDICOS POR FAIXA ETÁRIA
-- Jovens (18-25 anos) - 3 pessoas
('12121212121', '12345678', 'Marcos Rocha'),         -- 24 anos
('13131313131', '12345678', 'Amanda Pereira'),       -- 25 anos
('14141414141', 'badpassword', 'Pedro Cunha'),          -- 21 anos
('20202020202', '12345678', 'Rodrigo Pereira'),      -- 22 anos

-- Adultos Jovens (26-35 anos) - 5 pessoas
('23456789012', '12345678', 'Maria Santos'),         -- 32 anos
('56789012345', '12345678', 'Roberto Lima'),         -- 34 anos
('67890123456', '12345678', 'Fernanda Alves'),       -- 36 anos
('89012345678', '12345678', 'Juliana Rocha'),        -- 29 anos
('18181818181', '12345678', 'André Costa'),          -- 26 anos

-- Adultos (36-50 anos) - 5 pessoas
('34567890123', '12345678', 'João Pedro Costa'),     -- 39 anos
('90123456789', '12345678', 'Diego Ferreira'),       -- 41 anos
('22222222222', '12345678', 'Beatriz Costa'),        -- 33 anos
('33333333333', '12345678', 'Lucas Pereira'),        -- 37 anos
('66666666666', '12345678', 'Larissa Oliveira'),     -- 38 anos

-- Adultos Maduros (51-65 anos) - 5 pessoas
('55555555555', '12345678', 'Gabriel Santos'),       -- 31 anos
('88888888888', '12345678', 'Priscila Almeida'),     -- 30 anos
('99999999999', '12345678', 'Rafael Carvalho'),      -- 40 anos
('19191919191', '12345678', 'Patrícia Alves'),       -- 57 anos
('16161616161', '12345678', 'Bruno Santos'),         -- 62 anos

-- Idosos (65+ anos) - 3 pessoas
('15151515151', '12345678', 'Carla Silva'),          -- 67 anos
('17171717171', '12345678', 'Mônica Lima'),          -- 65 anos
('21212121212', '12345678', 'Fernanda Silva');       -- 68 anos

INSERT INTO cidadao (idcidadao, nascimento, eh_medico) VALUES
-- MÉDICOS (8)
(1, '1975-08-15', true),   -- Dr Carlos Silva - Cardiologista (49 anos)
(2, '1980-07-05', true),   -- Ana Oliveira - Pediatra (44 anos)
(3, '1970-09-25', true),   -- Paulo Henrique - Neurologista (54 anos)
(4, '1978-10-02', true),   -- Camila Barbosa - Ginecologista (46 anos)
(5, '1973-05-20', true),   -- Dr Ricardo Mendes - Ortopedista (51 anos)
(6, '1979-11-15', true),   -- Dra Marina Souza - Dermatologista (45 anos)
(7, '1972-04-18', true),   -- Dr André Lima - Psiquiatra (52 anos)
(8, '1976-06-14', true),   -- Dra Carolina Dias - Cardiologista (48 anos)

-- NÃO MÉDICOS
-- Jovens (18-25 anos) - 4 pessoas
(9, '2001-03-15', false),  -- Marcos Rocha (24 anos)
(10, '1999-07-22', false), -- Amanda Pereira (25 anos)
(11, '2003-11-08', false), -- Pedro Cunha (21 anos)
(12, '2002-08-14', false), -- Rodrigo Pereira (22 anos)

-- Adultos Jovens (26-35 anos) - 5 pessoas
(13, '1992-03-22', false), -- Maria Santos (32 anos)
(14, '1990-12-18', false), -- Roberto Lima (34 anos)
(15, '1988-04-30', false), -- Fernanda Alves (36 anos)
(16, '1995-01-14', false), -- Juliana Rocha (29 anos)
(17, '1998-05-25', false), -- André Costa (26 anos)

-- Adultos (36-50 anos) - 8 pessoas
(18, '1985-11-10', false), -- João Pedro Costa (39 anos)
(19, '1983-06-08', false), -- Diego Ferreira (41 anos)
(20, '1991-09-12', false), -- Beatriz Costa (33 anos)
(21, '1987-02-28', false), -- Lucas Pereira (37 anos)
(22, '1986-12-09', false), -- Larissa Oliveira (38 anos)
(23, '1993-07-03', false), -- Gabriel Santos (31 anos)
(24, '1994-08-25', false), -- Priscila Almeida (30 anos)
(25, '1984-01-30', false), -- Rafael Carvalho (40 anos)

-- Adultos Maduros (51-65 anos) - 2 pessoas
(26, '1968-12-03', false), -- Patrícia Alves (57 anos)
(27, '1962-09-30', false), -- Bruno Santos (62 anos)

-- Idosos (65+ anos) - 3 pessoas
(28, '1958-04-12', false), -- Carla Silva (67 anos)
(29, '1960-01-18', false), -- Mônica Lima (65 anos)
(30, '1956-10-20', false); -- Fernanda Silva (68 anos)

-- ============================
-- 2. UNIDADES MTE (10)
-- ============================
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


-- ============================
-- 3. CARTEIRAS DE TRABALHO (30)
-- ============================
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
(10, '2024-10-02', 'DIGITAL', 10),
(11, '2024-11-01', 'DIGITAL', 1),
(12, '2024-11-05', 'FÍSICA', 2),
(13, '2024-11-10', 'DIGITAL', 3),
(14, '2024-11-15', 'DIGITAL', 4),
(15, '2024-11-20', 'FÍSICA', 5),
(16, '2024-11-25', 'DIGITAL', 6),
(17, '2024-11-28', 'DIGITAL', 7),
(18, '2024-11-30', 'FÍSICA', 8),
(19, '2024-12-01', 'DIGITAL', 9),
(20, '2024-12-05', 'DIGITAL', 10),
(21, '2024-12-10', 'DIGITAL', 1),
(22, '2024-12-12', 'FÍSICA', 2),
(23, '2024-12-15', 'DIGITAL', 3),
(24, '2024-12-18', 'FÍSICA', 4),
(25, '2024-12-20', 'DIGITAL', 5),
(26, '2024-12-22', 'DIGITAL', 6),
(27, '2024-12-25', 'FÍSICA', 7),
(28, '2024-12-28', 'DIGITAL', 8),
(29, '2024-12-30', 'DIGITAL', 9),
(30, '2025-01-02', 'FÍSICA', 10);


-- ============================
-- 4. CONSELHOS REGIONAIS (10)
-- ============================
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


-- ============================
-- 5. MÉDICOS (8 dos 20 cidadãos)
-- ============================
INSERT INTO medico (cidadao, especializacao, crm) VALUES
(1, 'Cardiologia', 1),        -- Dr Carlos Silva
(2, 'Pediatria', 2),          -- Ana Oliveira
(3, 'Neurologia', 3),         -- Paulo Henrique
(4, 'Ginecologia', 4),        -- Camila Barbosa
(5, 'Ortopedia', 5),          -- Dr Ricardo Mendes
(6, 'Dermatologia', 6),       -- Dra Marina Souza
(7, 'Psiquiatria', 7),        -- Dr André Lima
(8, 'Cardiologia', 8);        -- Dra Carolina Dias


-- ============================
-- 6. EMPRESAS (15)
-- ============================
INSERT INTO idempresa_cnpj (cnpj, senha, nome) VALUES
('12345678000101', '12345678', 'Hospital SP LTDA'),
('12345678000202', '87654321', 'Clinica RJ SA'),
('12345678000303', 'aaaaaaaa', 'Hospital MG LTDA'),
('12345678000404', 'detransp', 'DETRAN SP'),
('12345678000505', 'detranrj', 'DETRAN RJ'),
('12345678000606', 'louvre123', 'Hospital BA LTDA'),
('12345678000707', 'amelhorclinica', 'Clinica PE SA'),
('12345678000808', 'bbbbbbbb', 'Hospital PR LTDA'),
('12345678000909', 'testestest', 'Clinica SC SA'),
('12345678001010', 'heloisaeuteamo', 'Hospital CE LTDA'),
('12345678001111', 'gatinhosfofos', 'DETRAN MG'),
('12345678001212', 'detranrs', 'DETRAN RS'),
('12345678001313', '123123123', 'DETRAN SC'),
('12345678001414', 'bbbbbbbbb', 'DETRAN BA'),
('12345678001515', 'ccccccccc', 'DETRAN GO');

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
(10, 'Hospital Ceará', 'Av Beira Mar', 900, 'Meireles', 'Saúde'),
(11, NULL, 'Av Contorno', 1500, 'Centro', 'Órgão Público'),
(12, NULL, 'Av Borges Medeiros', 1800, 'Centro', 'Órgão Público'),
(13, NULL, 'Rua Felipe Schmidt', 250, 'Centro', 'Órgão Público'),
(14, NULL, 'Av Sete de Setembro', 1100, 'Centro', 'Órgão Público'),
(15, NULL, 'Av T4', 2200, 'Setor Bueno', 'Órgão Público');


-- ============================
-- 7. DETRANS (9)
-- ============================
INSERT INTO detran (empresa, estado) VALUES
(4, 'SP'),
(5, 'RJ'),
(11, 'MG'),
(8, 'PR'),
(12, 'RS'),
(13, 'SC'),
(14, 'BA'),
(15, 'GO'),
(9, 'ES');


-- ============================
-- 8. HOSPITAIS (8 dos 10)
-- ============================
INSERT INTO hospital (empresa, nro_leitos, tipo_atendimento) VALUES
(1, 200, 'Privado'),        -- Hospital SP
(2, 80, 'Privado'),         -- Clinica RJ  
(3, 300, 'Público'),        -- Hospital MG
(6, 150, 'Privado'),        -- Hospital BA
(7, 60, 'Privado'),         -- Clinica PE
(8, 250, 'Público'),        -- Hospital PR
(9, 90, 'Privado'),         -- Clinica SC
(10, 180, 'Público');       -- Hospital CE


-- ============================
-- 9. AGÊNCIAS DE SAÚDE (10)
-- ============================
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


-- ============================
-- 10. ALVARÁS SANITÁRIOS (8 hospitais)
-- ============================
INSERT INTO alvara_sanitario (hospital, data_realizacao, agencia_saude) VALUES
(1, '2024-01-15', 'ANVISA SP'),
(2, '2024-02-20', 'ANVISA RJ'),
(3, '2024-03-10', 'ANVISA MG'),
(6, '2024-04-05', 'ANVISA BA'),
(7, '2024-05-18', 'ANVISA PE'),
(8, '2024-06-30', 'ANVISA PR'),
(9, '2024-07-25', 'ANVISA SC'),
(10, '2024-08-14', 'ANVISA CE');


-- ============================
-- 11. PRONTUÁRIOS (30)
-- ============================
INSERT INTO prontuario (cidadao, criacao, ultima_att, historico) VALUES
(1, '2020-01-10', '2024-11-20', 'Médico cardiologista sem comorbidades'),
(2, '2019-05-08', '2024-11-22', 'Médica pediatra em excelente saúde'),
(3, '2018-11-05', '2024-11-12', 'Médico neurologista com burnout tratado'),
(4, '2017-04-22', '2024-11-21', 'Médica ginecologista saudável'),
(5, '2019-08-12', '2024-11-23', 'Médico ortopedista sem comorbidades'),
(6, '2018-12-07', '2024-11-24', 'Médica dermatologista saudável'),
(7, '2017-06-28', '2024-11-13', 'Médico psiquiatra experiente'),
(8, '2016-03-14', '2024-11-25', 'Médica cardiologista veterana'),
(9, '2024-01-18', '2024-11-27', 'Jovem estudante universitário saudável'),
(10, '2023-08-22', '2024-11-28', 'Jovem trabalhadora em boa forma'),
(11, '2024-03-05', '2024-11-29', 'Estudante de ensino médio saudável'),
(12, '2024-05-16', '2024-12-05', 'Universitário atlético'),
(13, '2021-03-15', '2024-11-18', 'Paciente com hipertensão controlada'),
(14, '2023-01-12', '2024-11-10', 'Paciente jovem sem histórico relevante'),
(15, '2020-09-30', '2024-11-25', 'Histórico de alergias alimentares'),
(16, '2024-02-14', '2024-11-20', 'Paciente nova sem comorbidades'),
(17, '2023-11-14', '2024-12-03', 'Jovem profissional sem comorbidades'),
(18, '2022-07-20', '2024-11-15', 'Histórico de diabetes tipo 2'),
(19, '2021-06-18', '2024-11-19', 'Histórico de ansiedade em tratamento'),
(20, '2022-05-18', '2024-11-17', 'Paciente com histórico de enxaqueca'),
(21, '2021-09-03', '2024-11-16', 'Histórico de refluxo gastroesofágico'),
(22, '2020-11-15', '2024-11-26', 'Histórico de rinite alérgica'),
(23, '2023-03-22', '2024-11-14', 'Paciente jovem atlético'),
(24, '2024-04-10', '2024-11-22', 'Paciente nova em boa saúde'),
(25, '2021-12-05', '2024-11-18', 'Histórico de lombalgia crônica'),
(26, '2019-07-30', '2024-12-04', 'Professora com histórico de estresse'),
(27, '2018-09-25', '2024-12-01', 'Aposentado com diabetes controlada'),
(28, '2015-06-12', '2024-11-30', 'Aposentada com histórico de artrite'),
(29, '2020-02-08', '2024-12-02', 'Aposentada com hipertensão leve'),
(30, '2016-10-03', '2024-12-06', 'Aposentada com osteoporose');


-- ============================
-- 12. TRATAMENTOS (30 total)
-- ============================
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


-- ============================
-- 13. ALERGIAS (20 total)
-- ============================
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


-- ============================
-- 14. CONSULTAS (40 total)
-- ============================
INSERT INTO consulta (cidadao, hospital, data_hora, medico) VALUES
-- Consultas já realizadas
(13, 1, '2024-11-01 09:00:00', 1),  -- Maria com Dr Carlos
(18, 1, '2024-11-02 10:30:00', 1),  -- João com Dr Carlos
(14, 2, '2024-11-03 14:00:00', 2),  -- Roberto com Ana
(15, 2, '2024-11-04 15:30:00', 2),  -- Fernanda com Ana
(16, 3, '2024-11-05 08:00:00', 3),  -- Juliana com Paulo
(19, 3, '2024-11-06 11:00:00', 3),  -- Diego com Paulo
(7, 1, '2024-11-07 08:00:00', 5),   -- Dr André com Dr Ricardo
(24, 2, '2024-11-08 09:00:00', 6),  -- Priscila com Dra Marina
(25, 6, '2024-11-09 10:00:00', 7),  -- Rafael com Dr André
(8, 7, '2024-11-10 11:00:00', 8),   -- Dra Carolina com Dra Carolina

-- Consultas futuras
(13, 1, '2024-12-01 09:00:00', 1),  -- Maria retorno
(18, 1, '2024-12-02 10:30:00', 1),  -- João retorno
(14, 2, '2024-12-03 14:00:00', 2),  -- Roberto retorno
(15, 2, '2024-12-04 15:30:00', 2),  -- Fernanda retorno
(16, 6, '2024-12-05 08:00:00', 4),  -- Juliana com Camila
(19, 6, '2024-12-06 11:00:00', 4),  -- Diego com Camila
(13, 8, '2024-12-07 16:00:00', 3),  -- Maria com Paulo
(18, 8, '2024-12-08 13:30:00', 3),  -- João com Paulo
(14, 9, '2024-12-09 09:30:00', 2),  -- Roberto consulta SC
(15, 9, '2024-12-10 14:15:00', 2),  -- Fernanda consulta SC
(5, 9, '2024-12-11 12:00:00', 4),   -- Dr Ricardo com Camila
(6, 1, '2024-12-12 13:00:00', 7),   -- Dra Marina com Dr André

-- Consultas de hoje
(16, 10, '2024-11-26 16:00:00', 4), -- Juliana hoje
(19, 10, '2024-11-26 17:30:00', 4), -- Diego hoje

-- Consultas emergenciais
(13, 3, '2024-12-13 07:00:00', 3),  -- Maria emergência
(14, 1, '2024-12-14 18:00:00', 1),  -- Roberto emergência
(7, 6, '2024-12-15 14:00:00', 5),   -- Dr André emergência
(8, 8, '2024-12-16 15:00:00', 1),   -- Dra Carolina emergência

-- MÉDICOS EM TODOS OS HOSPITAIS PÚBLICOS (3, 8, 10)
-- Dr Carlos (1) atendendo em todos hospitais públicos
(20, 3, '2024-11-07 09:00:00', 1), -- Beatriz com Dr Carlos no MG
(21, 8, '2024-11-08 10:00:00', 1), -- Lucas com Dr Carlos no PR
(23, 10, '2024-11-09 11:00:00', 1), -- Gabriel com Dr Carlos no CE

-- Paulo (3) atendendo em todos hospitais públicos
(22, 3, '2024-11-10 14:00:00', 3), -- Larissa com Paulo no MG
(24, 8, '2024-11-11 15:00:00', 3), -- Priscila com Paulo no PR
(25, 10, '2024-11-12 16:00:00', 3), -- Rafael com Paulo no CE

-- Dr Ricardo (5) atendendo em todos hospitais públicos
(5, 3, '2024-11-13 08:30:00', 5), -- Dr Ricardo atende no MG
(20, 8, '2024-11-14 09:30:00', 5), -- Dr Ricardo atende no PR
(21, 10, '2024-11-15 10:30:00', 5), -- Dr Ricardo atende no CE

-- Dra Marina (6) atendendo em todos hospitais públicos
(6, 3, '2024-11-16 13:00:00', 6), -- Dra Marina no MG
(23, 8, '2024-11-17 14:00:00', 6), -- Dra Marina no PR
(22, 10, '2024-11-18 15:00:00', 6); -- Dra Marina no CE


-- ============================
-- 15. RELACIONAMENTOS (40)
-- ============================
INSERT INTO rel_prontuario_hospital (prontuario, hospital) VALUES
(1, 1), (1, 2),     -- Dr Carlos: SP e RJ
(13, 1), (13, 3), (13, 8),  -- Maria: SP, MG, PR
(18, 1), (18, 8),     -- João: SP e PR
(2, 2), (2, 6),     -- Ana: RJ e BA
(14, 2), (14, 9), (14, 1),  -- Roberto: RJ, SC, SP
(15, 2), (15, 6), (15, 9),  -- Fernanda: RJ, BA, SC
(3, 3), (3, 8),     -- Paulo: MG e PR
(16, 6), (16, 10),    -- Juliana: BA e CE
(19, 3), (19, 10),    -- Diego: MG e CE
(4, 6), (4, 7),   -- Camila: BA e PE
(5, 3), (5, 8), (5, 10), (5, 9), -- Dr Ricardo: todos públicos + SC
(20, 1), (20, 3), (20, 8), -- Beatriz: SP, MG, PR
(21, 2), (21, 10), -- Lucas: RJ e CE
(6, 3), (6, 8), (6, 10), (6, 1), -- Dra Marina: todos públicos + SP
(23, 6), (23, 7), (23, 8), (23, 10), -- Gabriel: BA, PE, PR, CE
(22, 3), (22, 9), (22, 10), -- Larissa: MG, SC, CE
(7, 1), (7, 6), -- Dr André: SP e BA
(24, 2), (24, 8), -- Priscila: RJ e PR
(25, 6), (25, 10), -- Rafael: BA e CE
(8, 7), (8, 8); -- Dra Carolina: PE e PR


-- ============================
-- 16. CONTRATOS (20)
-- ============================
INSERT INTO contrato (carteira_trabalho, empresa, admissao, demissao, cargo, salario, inicio_ferias, fim_ferias) VALUES
-- Contratos ativos
(1, 1, '2020-01-15', NULL, 'Medico', 15000.00, '2024-01-15', '2024-02-15'),
(13, 2, '2021-03-10', NULL, 'Enfermeira', 4500.00, '2024-07-01', '2024-08-01'),
(18, 3, '2022-05-20', NULL, 'Tecnico', 3200.00, '2024-06-15', '2024-07-15'),
(2, 2, '2019-08-01', NULL, 'Medica', 18000.00, '2024-03-01', '2024-04-01'),
(14, 6, '2023-02-14', NULL, 'Auxiliar', 2800.00, '2024-12-01', '2024-12-31'),
(15, 7, '2020-11-30', NULL, 'Recepcionista', 2200.00, '2024-09-01', '2024-10-01'),
(3, 3, '2018-07-08', NULL, 'Medico', 16000.00, '2024-05-01', '2024-06-01'),
(16, 8, '2024-01-10', NULL, 'Estagiaria', 1412.00, NULL, NULL),
(19, 9, '2021-09-15', NULL, 'Analista', 5500.00, '2024-11-01', '2024-12-01'),
(4, 10, '2017-06-22', NULL, 'Medica', 17500.00, '2024-08-01', '2024-09-01'),

-- Contratos encerrados
(13, 1, '2019-01-01', '2020-12-31', 'Auxiliar', 2000.00, '2020-07-01', '2020-08-01'),
(18, 2, '2020-02-01', '2021-11-30', 'Tecnico', 2800.00, '2021-06-01', '2021-07-01'),
(14, 7, '2021-03-15', '2022-08-31', 'Enfermeiro', 3800.00, '2022-01-01', '2022-02-01'),
(15, 8, '2018-05-01', '2020-03-15', 'Secretaria', 2200.00, '2019-12-01', '2020-01-01'),
(16, 9, '2022-08-10', '2023-12-20', 'Trainee', 3000.00, '2023-06-01', '2023-07-01'),
(19, 10, '2020-04-01', '2021-02-28', 'Analista Jr', 3500.00, '2020-12-01', '2021-01-01'),
(1, 6, '2015-01-01', '2019-12-31', 'Residente', 2800.00, '2019-07-01', '2019-08-01'),
(2, 7, '2016-03-01', '2019-02-28', 'Especialista', 12000.00, '2018-12-01', '2019-01-01'),
(3, 1, '2010-06-01', '2018-05-31', 'Neurologista', 14000.00, '2017-11-01', '2017-12-01'),
(4, 8, '2014-09-01', '2017-04-30', 'Ginecologista', 13500.00, '2016-12-01', '2017-01-01'),

-- Novos contratos médicos para cobertura das consultas
-- Dr Carlos Silva (1) - contratos adicionais
(1, 3, '2024-01-01', NULL, 'Cardiologista', 16000.00, '2024-07-01', '2024-08-01'),
(1, 8, '2024-01-01', NULL, 'Cardiologista', 16000.00, '2024-08-01', '2024-09-01'),
(1, 10, '2024-01-01', NULL, 'Cardiologista', 16000.00, '2024-09-01', '2024-10-01'),

-- Ana Oliveira (2) - contratos adicionais
(2, 9, '2024-01-01', NULL, 'Pediatra', 17000.00, '2024-10-01', '2024-11-01'),

-- Paulo Henrique (3) - contratos adicionais
(3, 8, '2024-01-01', NULL, 'Neurologista', 15500.00, '2024-10-01', '2024-10-31'),
(3, 10, '2024-01-01', NULL, 'Neurologista', 15500.00, '2025-01-01', '2025-01-31'),

-- Camila Barbosa (4) - contratos adicionais
(4, 6, '2024-01-01', NULL, 'Ginecologista', 16500.00, '2025-01-01', '2025-02-01'),
(4, 9, '2024-01-01', NULL, 'Ginecologista', 16500.00, '2025-02-01', '2025-03-01'),

-- Dr Ricardo Mendes (5) - contratos com hospitais
(5, 1, '2024-01-01', NULL, 'Ortopedista', 17500.00, '2024-01-01', '2024-02-01'),
(5, 3, '2024-01-01', NULL, 'Ortopedista', 17500.00, '2024-02-01', '2024-03-01'),
(5, 6, '2024-01-01', NULL, 'Ortopedista', 17500.00, '2024-03-01', '2024-04-01'),
(5, 8, '2024-01-01', NULL, 'Ortopedista', 17500.00, '2024-04-01', '2024-05-01'),
(5, 10, '2024-01-01', NULL, 'Ortopedista', 17500.00, '2024-05-01', '2024-06-01'),

-- Dra Marina Souza (6) - contratos com hospitais
(6, 2, '2024-01-01', NULL, 'Dermatologista', 16800.00, '2024-06-01', '2024-07-01'),
(6, 3, '2024-01-01', NULL, 'Dermatologista', 16800.00, '2024-07-01', '2024-08-01'),
(6, 8, '2024-01-01', NULL, 'Dermatologista', 16800.00, '2024-08-01', '2024-09-01'),
(6, 10, '2024-01-01', NULL, 'Dermatologista', 16800.00, '2024-09-01', '2024-10-01'),

-- Dr André Lima (7) - contratos com hospitais
(7, 1, '2024-01-01', NULL, 'Psiquiatra', 18000.00, '2024-09-01', '2024-09-30'),
(7, 6, '2024-01-01', NULL, 'Psiquiatra', 18000.00, '2024-10-15', '2024-10-31'),

-- Dra Carolina Dias (8) - contrato adicional
(8, 7, '2024-01-01', NULL, 'Cardiologista', 17200.00, '2024-12-01', '2024-12-31');


-- ============================
-- 17. UNIDADES DETRAN (20)
-- ============================
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

-- ============================
-- 18. CNH (27)
-- ============================
INSERT INTO cnh (a, b, c, d, e, emissao, vencimento, cidadao, detran) VALUES
(FALSE, TRUE, FALSE, FALSE, FALSE, '2020-01-01', '2030-01-01', 1, 4),   -- Dr Carlos
(FALSE, TRUE, FALSE, FALSE, FALSE, '2020-01-01', '2030-01-01', 18, 5),  -- João
(FALSE, TRUE, FALSE, FALSE, FALSE, '2020-01-01', '2030-01-01', 14, 4),  -- Roberto
(FALSE, TRUE, TRUE, FALSE, FALSE, '2020-01-01', '2030-01-01', 16, 11),  -- Juliana
(TRUE, TRUE, FALSE, FALSE, FALSE, '2020-01-01', '2030-01-01', 19, 4),   -- Diego
(FALSE, TRUE, TRUE, TRUE, FALSE, '2020-01-01', '2030-01-01', 5, 5),     -- Dr Ricardo
(FALSE, TRUE, FALSE, FALSE, FALSE, '2020-01-01', '2030-01-01', 21, 11), -- Lucas
(TRUE, TRUE, TRUE, FALSE, FALSE, '2020-01-01', '2030-01-01', 23, 4),    -- Gabriel
(FALSE, TRUE, FALSE, FALSE, FALSE, '2020-01-01', '2030-01-01', 7, 5),   -- Dr André
(FALSE, TRUE, TRUE, FALSE, FALSE, '2020-01-01', '2030-01-01', 24, 11),  -- Priscila
(TRUE, TRUE, TRUE, TRUE, TRUE, '2020-01-01', '2030-01-01', 8, 4),       -- Dra Carolina
(FALSE, TRUE, FALSE, FALSE, FALSE, '2021-01-01', '2031-01-01', 15, 8),  -- Fernanda
(FALSE, TRUE, TRUE, FALSE, FALSE, '2021-01-01', '2031-01-01', 4, 12),   -- Camila
(TRUE, TRUE, FALSE, FALSE, FALSE, '2021-01-01', '2031-01-01', 20, 13),  -- Beatriz
(FALSE, TRUE, TRUE, TRUE, FALSE, '2021-01-01', '2031-01-01', 6, 14),    -- Dra Marina
(FALSE, TRUE, FALSE, FALSE, FALSE, '2021-01-01', '2031-01-01', 22, 15), -- Larissa
(TRUE, TRUE, TRUE, FALSE, FALSE, '2021-01-01', '2031-01-01', 25, 9),    -- Rafael
(FALSE, TRUE, FALSE, FALSE, FALSE, '2022-01-01', '2032-01-01', 9, 4),   -- Marcos Jovem (24 anos)
(FALSE, TRUE, FALSE, FALSE, FALSE, '2022-02-01', '2032-02-01', 10, 5),  -- Amanda Jovem (25 anos)
(FALSE, TRUE, FALSE, FALSE, FALSE, '2023-01-01', '2033-01-01', 11, 4),  -- Pedro Jovem (21 anos)
(FALSE, TRUE, FALSE, FALSE, FALSE, '2020-03-01', '2030-03-01', 28, 11), -- Carla Silva (67 anos - idosa)
(FALSE, TRUE, TRUE, FALSE, FALSE, '2020-04-01', '2030-04-01', 27, 12),  -- Bruno Santos (62 anos)
(FALSE, TRUE, FALSE, FALSE, FALSE, '2020-05-01', '2030-05-01', 29, 13), -- Mônica Lima (65 anos)
(FALSE, TRUE, FALSE, FALSE, FALSE, '2021-06-01', '2031-06-01', 17, 5),  -- André Costa (26 anos)
(FALSE, TRUE, TRUE, FALSE, FALSE, '2020-07-01', '2030-07-01', 26, 14),  -- Patrícia Alves (57 anos)
(FALSE, TRUE, FALSE, FALSE, FALSE, '2023-08-01', '2033-08-01', 12, 4),  -- Rodrigo Pereira (22 anos)
(FALSE, TRUE, FALSE, FALSE, FALSE, '2019-09-01', '2029-09-01', 30, 15); -- Fernanda Silva (68 anos - idosa)

-- ============================
-- 19. EXAME_PSICOTECNICO (12)
-- ============================
INSERT INTO exame_psicotecnico (consulta, validade, observacao, resultado, unidade, detran) VALUES
(1,  '2027-01-10', 'Apto', true,  1, 4),
(2,  '2027-02-12', 'Apto com restrições leves', true,  2, 4),
(3,  '2028-03-15', 'Inapto', false, 3, 4),
(4,  '2026-04-20', 'Apto', true,  4, 4),
(5,  '2028-05-25', 'Apto', true,  5, 4),
(6,  '2027-06-15', 'Apto', true,  6, 4),
(7,  '2027-07-18', 'Apto', true,  7, 4),
(8,  '2027-08-22', 'Apto com observações', true,  8, 4),
(9,  '2027-09-10', 'Apto', true,  9, 4),
(10, '2027-10-05', 'Apto', true, 10, 4),
(17, '2027-11-12', 'Apto', true,  11, 5),
(19, '2027-12-08', 'Apto', true,  12, 5);

-- ============================
-- 20. EXAME_TOXICOLOGICO (12)
-- ============================
INSERT INTO exame_toxicologico (consulta, validade, observacao, resultado, unidade, detran) VALUES
(1,  '2026-01-08', 'Negativo', true,  1, 4),
(2,  '2026-02-10', 'Negativo', true,  2, 4),
(3,  '2027-03-12', 'Negativo', true,  3, 4),
(4,  '2026-04-18', 'Negativo', true,  4, 4),
(5,  '2027-05-22', 'Negativo', true,  5, 4),
(6,  '2026-06-10', 'Negativo', true,  6, 4),
(7,  '2027-07-12', 'Negativo', true,  7, 4),
(8,  '2027-08-18', 'Positivo para THC', false, 8, 4),
(9,  '2027-09-22', 'Negativo', true,  9, 4),
(10, '2028-10-30', 'Negativo', true, 10, 4),
(17, '2027-11-10', 'Negativo', true,  11, 5),
(19, '2027-12-06', 'Negativo', true,  12, 5);

-- ============================
-- 21. SUBSTANCIAS (12)
-- ============================
INSERT INTO substancias (exame_toxicologico, substancia) VALUES
(1,  'Álcool'),
(2,  'Anfetamina'),
(3,  'Cocaína'),
(4,  'THC'),
(5,  'Benzoilecgonina'),
(6,  'THC'),
(7,  'Cocaína'),
(8,  'Anfetamina'),
(9,  'Cafeína'),
(10, 'Benzoilecgonina'),
(17, 'Álcool'),
(19, 'Cocaína');

-- ============================
-- 22. EXAME_MEDICO_CNH (12)
-- ============================
INSERT INTO exame_medico_cnh (consulta, validade, observacao, resultado, pcd, usa_oculos, unidade, detran) VALUES
(1,  '2027-01-05', 'Apto', true, false, false, 1, 4),
(2,  '2027-02-08', 'Apto', true, false, true,  2, 4),
(3,  '2027-03-10', 'Apto', true, false, false, 3, 4),
(4,  '2027-04-15', 'Apto', true, false, true,  4, 4),
(5,  '2027-05-18', 'Apto', true, false, false, 5, 4),
(6,  '2027-06-12', 'Apto', true, false, true,  6, 4),
(7,  '2027-07-15', 'Apto', true, false, false, 7, 4),
(8,  '2027-08-20', 'Apto com restrições', true, true, true, 8, 4),
(9,  '2027-09-18', 'Apto', true, false, false, 9, 4),
(10, '2027-10-22', 'Apto', true, false, true, 10, 4),
(17, '2027-11-08', 'Apto', true, false, false, 11, 5),
(19, '2027-12-04', 'Apto', true, false, true,  12, 5);

-- ============================
-- 23. AMETROPIAS (7)
-- ============================
INSERT INTO ametropias (exame_medico_cnh, tipo, grau_esquerdo, grau_direito) VALUES
(2, 'Miopia',         -1.25, -1.00),
(4, 'Hipermetropia',   1.50,  1.25),
(6, 'Astigmatismo',   -0.75, -0.50),
(8, 'Presbiopia',      1.00,  1.00),
(10, 'Miopia',        -2.00, -1.75),
(17, 'Astigmatismo',  -1.00, -0.75),
(19, 'Miopia',        -1.50, -1.25);

-- ============================
-- 24. EXAME_ADMISSIONAL (5)
-- ============================
INSERT INTO exame_admissional (consulta, validade, observacao, resultado, tipo, contrato, carteira_trabalho, empresa) VALUES
(15, '2028-03-10', 'Apto', true, 'Admissional', 1, 1, 1),
(7, '2028-04-12', 'Apto', true, 'Periódico',   2, 13, 2),
(24, '2027-06-01', 'Apto', true, 'Admissional', 3, 18, 3),
(25, '2027-07-15', 'Inapto', false, 'Retorno',  4, 2, 2),
(8, '2028-09-30', 'Apto', true, 'Periódico',   5, 14, 6);


COMMIT;
