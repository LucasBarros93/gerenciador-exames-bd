-- Drop prévio (para testes)
DROP TABLE IF EXISTS RelProntuarioHospital CASCADE;
DROP TABLE IF EXISTS Tratamento CASCADE;
DROP TABLE IF EXISTS Alergia CASCADE;
DROP TABLE IF EXISTS Prontuario CASCADE;
DROP TABLE IF EXISTS Exame_Medico_CNH CASCADE;
DROP TABLE IF EXISTS Exame_Psicotecnico CASCADE;
DROP TABLE IF EXISTS Exame_Toxicologico CASCADE;
DROP TABLE IF EXISTS Exame_Admissional CASCADE;
DROP TABLE IF EXISTS Consulta CASCADE;
DROP TABLE IF EXISTS Contrato CASCADE;
DROP TABLE IF EXISTS Carteira_Trabalho CASCADE;
DROP TABLE IF EXISTS UnidadeAtendimento CASCADE;
DROP TABLE IF EXISTS CNH CASCADE;
DROP TABLE IF EXISTS Alvara_Sanitario CASCADE;

DROP TABLE IF EXISTS Medico CASCADE;
DROP TABLE IF EXISTS CRM CASCADE;
DROP TABLE IF EXISTS Hospital CASCADE;
DROP TABLE IF EXISTS Empresa CASCADE;
DROP TABLE IF EXISTS Detran CASCADE;
DROP TABLE IF EXISTS Substancia CASCADE;
DROP TABLE IF EXISTS Ametropia CASCADE;
DROP TABLE IF EXISTS Cidadao CASCADE;

-- Tabela central: Cidadao
CREATE TABLE Cidadao (
    id_cidadao SERIAL PRIMARY KEY,
    cpf VARCHAR(11) UNIQUE NOT NULL,
    nome TEXT NOT NULL,
    data_nasc DATE,
    eh_medico BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT now()
);

-- Tabela CRM (conselho estadual)
CREATE TABLE CRM (
    id_crm SERIAL PRIMARY KEY,
    estado CHAR(2) NOT NULL,
    endereco TEXT
);

-- Tabela Medico (especialização de Cidadao)
CREATE TABLE Medico (
    id_medico SERIAL PRIMARY KEY,
    cidadao_fk INTEGER NOT NULL REFERENCES Cidadao(id_cidadao) ON DELETE CASCADE,
    id_crm INTEGER NOT NULL REFERENCES CRM(id_crm),
    numero_crm VARCHAR(30) UNIQUE NOT NULL,
    especializacao TEXT
);

-- Empresa (genérica)
CREATE TABLE Empresa (
    id_empresa SERIAL PRIMARY KEY,
    cnpj VARCHAR(14) UNIQUE,
    nome TEXT NOT NULL,
    rua TEXT,
    numero TEXT,
    bairro TEXT
);

-- Hospital (especialização de Empresa)
CREATE TABLE Hospital (
    id_hospital INTEGER PRIMARY KEY REFERENCES Empresa(id_empresa) ON DELETE CASCADE,
    num_leitos INTEGER,
    tipo_atendimento TEXT,
    licenciado BOOLEAN DEFAULT FALSE
);

-- Alvará Sanitário (entidade fraca)
CREATE TABLE Alvara_Sanitario (
    id_alvara SERIAL,
    hospital_fk INTEGER NOT NULL REFERENCES Hospital(id_hospital) ON DELETE CASCADE,
    data_emissao DATE NOT NULL,
    agencia_saude TEXT,
    PRIMARY KEY (id_alvara)
);

-- DETRAN (especialização de Empresa)
CREATE TABLE Detran (
    id_detran INTEGER PRIMARY KEY REFERENCES Empresa(id_empresa) ON DELETE CASCADE,
    estado CHAR(2) NOT NULL
);

-- Unidade de Atendimento (pertence a um DETRAN)
CREATE TABLE UnidadeAtendimento (
    id_unidade SERIAL PRIMARY KEY,
    detran_fk INTEGER NOT NULL REFERENCES Detran(id_detran) ON DELETE CASCADE,
    cidade TEXT,
    endereco TEXT
);

-- Prontuario (entidade fraca de Cidadao) - 1:1
CREATE TABLE Prontuario (
    id_prontuario SERIAL PRIMARY KEY,
    cidadao_fk INTEGER UNIQUE NOT NULL REFERENCES Cidadao(id_cidadao) ON DELETE CASCADE,
    data_criacao DATE NOT NULL,
    ultima_atualizacao DATE
);

-- tabelas para multivalorados
CREATE TABLE Alergia (
    id SERIAL PRIMARY KEY,
    prontuario_fk INTEGER NOT NULL REFERENCES Prontuario(id_prontuario) ON DELETE CASCADE,
    descricao TEXT NOT NULL
);

CREATE TABLE Tratamento (
    id SERIAL PRIMARY KEY,
    prontuario_fk INTEGER NOT NULL REFERENCES Prontuario(id_prontuario) ON DELETE CASCADE,
    descricao TEXT NOT NULL
);

-- Carteira de Trabalho (1:1 com Cidadao)
CREATE TABLE Carteira_Trabalho (
    id_carteira SERIAL PRIMARY KEY,
    cidadao_fk INTEGER UNIQUE NOT NULL REFERENCES Cidadao(id_cidadao) ON DELETE CASCADE,
    tipo VARCHAR(10),
    data_ultima_atualizacao DATE,
    unidade_emissora TEXT
);

-- Contrato (agregação)
CREATE TABLE Contrato (
    numero_contrato SERIAL,
    carteira_fk INTEGER NOT NULL REFERENCES Carteira_Trabalho(id_carteira),
    empresa_fk INTEGER NOT NULL REFERENCES Empresa(id_empresa),
    data_admissao DATE,
    data_demissao DATE,
    cargo TEXT,
    salario NUMERIC(12,2),
    PRIMARY KEY (numero_contrato)
);

-- Consulta (agregação para agenda)
CREATE TABLE Consulta (
    id_consulta SERIAL PRIMARY KEY,
    cidadao_fk INTEGER NOT NULL REFERENCES Cidadao(id_cidadao),
    hospital_fk INTEGER NOT NULL REFERENCES Hospital(id_hospital),
    data_hora TIMESTAMP NOT NULL,
    medico_fk INTEGER REFERENCES Medico(id_medico),
    motivo TEXT
);

-- Exames: criada uma tabela por especialização (mapeamento do MR do grupo)
CREATE TABLE Exame_Medico_CNH (
    id SERIAL PRIMARY KEY,
    consulta_fk INTEGER NOT NULL REFERENCES Consulta(id_consulta) ON DELETE CASCADE,
    medico_fk INTEGER NOT NULL REFERENCES Medico(id_medico),
    resultado TEXT,
    usa_oculos BOOLEAN,
    pcd BOOLEAN,
    data_exame DATE,
    unidade_fk INTEGER REFERENCES UnidadeAtendimento(id_unidade),
    detran_fk INTEGER REFERENCES Detran(id_detran)
);

CREATE TABLE Exame_Psicotecnico (
    id SERIAL PRIMARY KEY,
    consulta_fk INTEGER NOT NULL REFERENCES Consulta(id_consulta) ON DELETE CASCADE,
    medico_fk INTEGER NOT NULL REFERENCES Medico(id_medico),
    resultado TEXT,
    info_extra TEXT,
    data_exame DATE,
    unidade_fk INTEGER REFERENCES UnidadeAtendimento(id_unidade),
    detran_fk INTEGER REFERENCES Detran(id_detran)
);

CREATE TABLE Exame_Toxicologico (
    id SERIAL PRIMARY KEY,
    consulta_fk INTEGER NOT NULL REFERENCES Consulta(id_consulta) ON DELETE CASCADE,
    medico_fk INTEGER NOT NULL REFERENCES Medico(id_medico),
    resultado TEXT,
    data_exame DATE,
    unidade_fk INTEGER REFERENCES UnidadeAtendimento(id_unidade),
    detran_fk INTEGER REFERENCES Detran(id_detran)
);

CREATE TABLE Exame_Admissional (
    id SERIAL PRIMARY KEY,
    contrato_fk INTEGER NOT NULL REFERENCES Contrato(numero_contrato) ON DELETE CASCADE,
    medico_fk INTEGER NOT NULL REFERENCES Medico(id_medico),
    resultado TEXT,
    data_exame DATE
);

-- CNH
CREATE TABLE CNH (
    numero_cnh SERIAL PRIMARY KEY,
    cidadao_fk INTEGER UNIQUE NOT NULL REFERENCES Cidadao(id_cidadao),
    tipo VARCHAR(10),
    data_emissao DATE,
    data_vencimento DATE,
    detran_fk INTEGER NOT NULL REFERENCES Detran(id_detran)
);

-- relacionamento N:N: hospitais que acessam prontuarios
CREATE TABLE RelProntuarioHospital (
    prontuario_fk INTEGER REFERENCES Prontuario(id_prontuario),
    hospital_fk INTEGER REFERENCES Hospital(id_hospital),
    data_acesso TIMESTAMP,
    PRIMARY KEY (prontuario_fk, hospital_fk)
);

-- tabelas auxiliares multivalorados (substancias, ametropias)
CREATE TABLE Substancia (
    id SERIAL PRIMARY KEY,
    exame_toxic_fk INTEGER REFERENCES Exame_Toxicologico(id),
    nome TEXT
);

CREATE TABLE Ametropia (
    id SERIAL PRIMARY KEY,
    exame_cnh_fk INTEGER REFERENCES Exame_Medico_CNH(id),
    descricao TEXT
);

-- Índices e constraints adicionais (exemplos)
CREATE INDEX idx_consulta_cid ON Consulta(cidadao_fk);
CREATE INDEX idx_examecnh_consulta ON Exame_Medico_CNH(consulta_fk);