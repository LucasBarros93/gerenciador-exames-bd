CREATE TABLE IF NOT EXISTS idcidadao_cpf (
    idcidadao SERIAL PRIMARY KEY,
    cpf VARCHAR(11) NOT NULL UNIQUE,
    nome VARCHAR(50) NOT NULL,

    CHECK (LENGTH(cpf) = 11),  -- CPF deve ter 11 dígitos
    CHECK (cpf ~ '^\d{11}$'), -- CPF deve ter somente números
    CHECK (LENGTH(nome) >= 2),  -- Nome deve ter pelo menos 2 caracteres
    CHECK (nome ~ '^[A-Za-zÀ-ÿ ]+$')  -- Nome só pode ter letras e espaços
);

CREATE TABLE IF NOT EXISTS cidadao (
    idcidadao INTEGER PRIMARY KEY,
    nascimento DATE,
    eh_medico BOOLEAN NOT NULL,

    CHECK (nascimento >= '1850-01-01'),  -- Data mínima razoável
    CHECK (nascimento <= CURRENT_DATE),  -- Não pode nascer no futuro
    CHECK (EXTRACT(YEAR FROM AGE(nascimento)) >= 0),  -- Idade >= 0
    CHECK (EXTRACT(YEAR FROM AGE(nascimento)) <= 150),  -- Idade <= 150

    CONSTRAINT fk_idcidadao FOREIGN KEY (idcidadao) REFERENCES idcidadao_cpf(idcidadao) 
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS unidade_mte (
    idunidade SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    rua VARCHAR(20) NOT NULL,
    numero SMALLINT NOT NULL,
    bairro VARCHAR(20) NOT NULL,

    CHECK (LENGTH(nome) >= 2 AND LENGTH(nome) <= 50),  -- Nome válido
    CHECK (nome ~ '^[A-Za-zÀ-ÿ0-9 \-\.]+$'),  -- Nome: letras, números, espaços, hífen, ponto
    CHECK (nome !~ '^[ \-\.]|[ \-\.]$'),  -- Nome não pode começar/terminar com espaço/hífen/ponto
    
    CHECK (LENGTH(rua) >= 2 AND LENGTH(rua) <= 20),  -- Rua válida
    CHECK (rua ~ '^[A-Za-zÀ-ÿ0-9 \-\.]+$'),  -- Rua: letras, números, espaços, hífen, ponto
    
    CHECK (numero > 0 AND numero <= 32767),  -- SMALLINT válido (1 a 32767)
    
    CHECK (LENGTH(bairro) >= 2 AND LENGTH(bairro) <= 20),  -- Bairro válido
    CHECK (bairro ~ '^[A-Za-zÀ-ÿ0-9 \-\.]+$'),  -- Bairro: letras, números, espaços, hífen, ponto

    UNIQUE (nome, rua, numero, bairro)
);

CREATE TABLE IF NOT EXISTS carteira_trabalho (
    cidadao INTEGER PRIMARY KEY,
    ultimaatt DATE,
    tipo VARCHAR(20),
    unimte INTEGER,

    CHECK (ultimaatt IS NULL OR ultimaatt <= CURRENT_DATE),  -- Última atualização não pode ser no futuro
    CHECK (ultimaatt IS NULL OR ultimaatt >= '1943-05-01'),  -- CLT foi criada em 1943
    CHECK (tipo IS NULL OR tipo IN ('FÍSICA', 'DIGITAL', 'ELETRÔNICA')),  -- Tipos válidos de carteira
    CHECK (tipo IS NULL OR LENGTH(tipo) >= 2),  -- Tipo deve ter pelo menos 2 chars se preenchido

    CONSTRAINT fk_carteira_trabalho_cidadao FOREIGN KEY (cidadao) REFERENCES cidadao(idcidadao)
    ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_carteira_trabalho_unimte FOREIGN KEY (unimte) REFERENCES unidade_mte(idunidade)
    ON DELETE SET NULL ON UPDATE SET NULL
);

CREATE TABLE IF NOT EXISTS crm (
    idcrm SERIAL PRIMARY KEY,
    uf VARCHAR(2) NOT NULL,
    rua VARCHAR(20) NOT NULL,
    numero SMALLINT NOT NULL,
    bairro VARCHAR(20) NOT NULL,

    CHECK (LENGTH(uf) = 2),  -- UF deve ter exatamente 2 caracteres
    CHECK (uf ~ '^[A-Z]{2}$'),  -- UF deve ser 2 letras maiúsculas
    CHECK (uf IN ('AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO')),  -- Estados válidos
    CHECK (LENGTH(rua) >= 2 AND LENGTH(rua) <= 20),  -- Rua válida
    CHECK (numero > 0),  -- Número positivo
    CHECK (LENGTH(bairro) >= 2 AND LENGTH(bairro) <= 20),  -- Bairro válido

    UNIQUE(uf, rua, numero, bairro)
);

CREATE TABLE IF NOT EXISTS medico (
    cidadao INTEGER PRIMARY KEY,
    especializacao VARCHAR(100),
    crm INTEGER NOT NULL,

    CHECK (especializacao IS NULL OR LENGTH(especializacao) >= 2),  -- Especialização válida
    CHECK (especializacao IS NULL OR especializacao ~ '^[A-Za-zÀ-ÿ \-]+$'),  -- Só letras, espaços e hífen
    CHECK (especializacao IS NULL OR especializacao !~ '^[ \-]|[ \-]$'),  -- Não pode começar/terminar com espaço/hífen

    CONSTRAINT fk_medico_cidadao FOREIGN KEY (cidadao) REFERENCES cidadao(idcidadao) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_medico_crm FOREIGN KEY (crm) REFERENCES crm(idcrm) 
    ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE IF NOT EXISTS idempresa_cnpj (
    idempresa SERIAL PRIMARY KEY,
    cnpj VARCHAR(14) NOT NULL UNIQUE,
    nome VARCHAR(50) NOT NULL

    CHECK (LENGTH(cnpj) = 14),  -- CNPJ deve ter 14 dígitos
    CHECK (cnpj ~ '^\d{11}$'),  -- CNPJ deve ter somente números
    CHECK (LENGTH(nome) >= 2),  -- Nome deve ter pelo menos 2 caracteres
    CHECK (nome ~ '^[A-Za-zÀ-ÿ0-9 \-\.&]+$'),  -- Nome: letras, números, espaços, hífen, ponto, &
    CHECK (nome !~ '^[ \-\.]|[ \-\.]$')  -- Nome não pode começar/terminar com espaço/hífen/ponto
);

CREATE TABLE IF NOT EXISTS empresa (
    idempresa INTEGER PRIMARY KEY,
    franquia VARCHAR(30),
    rua VARCHAR(20) NOT NULL,
    numero SMALLINT NOT NULL,
    bairro VARCHAR(20) NOT NULL,
    tipo VARCHAR(20),

    CHECK (franquia IS NULL OR LENGTH(franquia) >= 2),  -- Franquia válida
    CHECK (franquia IS NULL OR franquia ~ '^[A-Za-zÀ-ÿ0-9 \-\.]+$'),  -- Franquia formato válido
    CHECK (LENGTH(rua) >= 2),  -- Rua deve ter pelo menos 2 chars
    CHECK (rua ~ '^[A-Za-zÀ-ÿ0-9 \-\.]+$'),  -- Rua formato válido
    CHECK (numero > 0),  -- Número positivo
    CHECK (LENGTH(bairro) >= 2),  -- Bairro válido
    CHECK (bairro ~ '^[A-Za-zÀ-ÿ0-9 \-\.]+$'),  -- Bairro formato válido
    CHECK (tipo IS NULL OR tipo IN ('Órgão Público', 'Empresa Privada', 'ONG', 'Educação', 'Saúde', 'Serviços')),  -- Tipos válidos

    CONSTRAINT fk_idempresa FOREIGN KEY (idempresa) REFERENCES idempresa_cnpj(idempresa) 
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS detran (
    empresa INTEGER PRIMARY KEY,
    estado VARCHAR(2) NOT NULL UNIQUE,

    CHECK (UPPER(estado) IN ('AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO')),  -- Estados válidos

    CONSTRAINT fk_detran_empresa FOREIGN KEY (empresa) REFERENCES empresa(idempresa)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS cnh (
    numero SERIAL PRIMARY KEY,
    A BOOLEAN NOT NULL,
    B BOOLEAN NOT NULL,
    C BOOLEAN NOT NULL,
    D BOOLEAN NOT NULL,
    E BOOLEAN NOT NULL,
    emissao DATE,
    vencimento DATE,
    cidadao INTEGER NOT NULL UNIQUE,
    detran INTEGER NOT NULL,

    CHECK (emissao IS NULL OR emissao <= CURRENT_DATE),  -- Emissão não pode ser futura
    CHECK (emissao IS NULL OR emissao >= '1998-01-01'),  -- CNH digital começou em 1998
    CHECK (vencimento IS NULL OR emissao IS NULL OR vencimento > emissao),  -- Vencimento após emissão
    CHECK (vencimento IS NULL OR emissao IS NULL OR EXTRACT(YEAR FROM AGE(vencimento, emissao)) <= 10),  -- CNH válida por no máximo 10 anos

    CONSTRAINT fk_cnh_cidadao FOREIGN KEY (cidadao) REFERENCES cidadao(idcidadao) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_cnh_detran FOREIGN KEY (detran) REFERENCES detran(empresa) 
    ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE IF NOT EXISTS hospital (
    empresa INTEGER PRIMARY KEY,
    nro_leitos INT,
    tipo_atendimento VARCHAR(30),

    CHECK (nro_leitos IS NULL OR nro_leitos > 0),  -- Número de leitos positivo
    CHECK (nro_leitos IS NULL OR nro_leitos <= 10000),  -- Limite razoável de leitos
    CHECK (tipo_atendimento IS NULL OR LENGTH(tipo_atendimento) >= 3),  -- Tipo válido
    CHECK (tipo_atendimento IS NULL OR tipo_atendimento IN ('Público', 'Privado', 'Filantrópico', 'Misto')),  -- Tipos válidos

    CONSTRAINT fk_hospital_empresa FOREIGN KEY (empresa) REFERENCES empresa(idempresa) 
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS agencia_saude (
    nome VARCHAR(50) PRIMARY KEY,
    rua VARCHAR(20) NOT NULL,
    numero SMALLINT NOT NULL,
    bairro VARCHAR(20) NOT NULL

    CHECK (LENGTH(nome) >= 2),  -- Nome deve ter pelo menos 3 chars
    CHECK (nome ~ '^[A-Za-zÀ-ÿ0-9 \-\.]+$'),  -- Nome formato válido
    CHECK (LENGTH(rua) >= 2),  -- Rua válida
    CHECK (numero > 0),  -- Número positivo
    CHECK (LENGTH(bairro) >= 2)  -- Bairro válido
);

CREATE TABLE IF NOT EXISTS alvara_sanitario (
    hospital INTEGER PRIMARY KEY,
    data_realizacao DATE,
    agencia_saude VARCHAR(50) NOT NULL,

    CHECK (data_realizacao IS NULL OR data_realizacao <= CURRENT_DATE),  -- Data não pode ser futura
    CHECK (data_realizacao IS NULL OR data_realizacao >= '1990-01-01'),  -- Data mínima razoável

    CONSTRAINT fk_alvara_hospital FOREIGN KEY (hospital) REFERENCES hospital(empresa) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_alvara_agencia_saude FOREIGN KEY (agencia_saude) REFERENCES agencia_saude(nome) 
    ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE IF NOT EXISTS consulta (
    id SERIAL PRIMARY KEY,
    cidadao INTEGER NOT NULL,
    hospital INTEGER NOT NULL,
    data_hora TIMESTAMP NOT NULL,
    medico INTEGER NOT NULL,

    CHECK (data_hora >= '2000-01-01 00:00:00'),  -- Data mínima razoável

    UNIQUE(cidadao, hospital, data_hora),

    CONSTRAINT fk_consulta_cidadao FOREIGN KEY (cidadao) REFERENCES cidadao(idcidadao) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_consulta_hospital FOREIGN KEY (hospital) REFERENCES hospital(empresa) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_consulta_medico FOREIGN KEY (medico) REFERENCES medico(cidadao) 
    ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE IF NOT EXISTS prontuario (
    cidadao INTEGER PRIMARY KEY,
    criacao DATE,
    ultima_att DATE,
    historico VARCHAR(200),

    CHECK (criacao IS NULL OR criacao <= CURRENT_DATE),  -- Criação não pode ser futura
    CHECK (criacao IS NULL OR criacao >= '1900-01-01'),  -- Data mínima razoável
    CHECK (ultima_att IS NULL OR ultima_att <= CURRENT_DATE),  -- Atualização não pode ser futura
    CHECK (ultima_att IS NULL OR criacao IS NULL OR ultima_att >= criacao),  -- Atualização após criação

    CONSTRAINT fk_prontuario_cidadao FOREIGN KEY (cidadao) REFERENCES cidadao(idcidadao) 
    ON DELETE CASCADE ON UPDATE CASCADE
);  

CREATE TABLE IF NOT EXISTS tratamentos (
    prontuario INTEGER,
    tratamento VARCHAR(50) NOT NULL,
    PRIMARY KEY (prontuario, tratamento),

    CHECK (LENGTH(tratamento) >= 2),  -- Tratamento deve ter pelo menos 2 chars
    CHECK (tratamento ~ '^[A-Za-zÀ-ÿ0-9 \-\.\(\)]+$'),  -- Tratamento formato válido

    CONSTRAINT fk_tratamentos_prontuario FOREIGN KEY (prontuario) REFERENCES prontuario(cidadao) 
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS alergia (
    prontuario INTEGER,
    alergia VARCHAR(30) NOT NULL,
    PRIMARY KEY (prontuario, alergia),

    CHECK (LENGTH(alergia) >= 2),  -- Alergia deve ter pelo menos 2 chars
    CHECK (alergia ~ '^[A-Za-zÀ-ÿ0-9 \-\.]+$'),  -- Alergia formato válido

    CONSTRAINT fk_alergia_prontuario FOREIGN KEY (prontuario) REFERENCES prontuario(cidadao) 
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS rel_prontuario_hospital (
    prontuario INTEGER,
    hospital INTEGER,
    PRIMARY KEY (prontuario, hospital),

    CONSTRAINT fk_rel_prontuario FOREIGN KEY (prontuario) REFERENCES prontuario(cidadao) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_rel_hospital FOREIGN KEY (hospital) REFERENCES hospital(empresa) 
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS contrato (
    numero SERIAL,
    carteira_trabalho INTEGER,
    empresa INTEGER,
    PRIMARY KEY (numero, carteira_trabalho, empresa),

    admissao DATE,
    demissao DATE,
    cargo VARCHAR(20),
    salario DECIMAL(10,2),
    inicio_ferias DATE,
    fim_ferias DATE,

    CHECK (admissao IS NULL OR admissao <= CURRENT_DATE),  -- Admissão não pode ser futura
    CHECK (admissao IS NULL OR admissao >= '1943-05-01'),  -- Após criação da CLT
    CHECK (demissao IS NULL OR admissao IS NULL OR demissao >= admissao),  -- Demissão após admissão
    CHECK (salario IS NULL OR salario > 0),  -- Salário positivo
    CHECK (salario IS NULL OR salario >= 1412.00),  -- Salário mínimo 2024
    CHECK (cargo IS NULL OR LENGTH(cargo) >= 2),  -- Cargo válido
    CHECK (cargo IS NULL OR cargo ~ '^[A-Za-zÀ-ÿ \-]+$'),  -- Cargo só letras
    CHECK (inicio_ferias IS NULL OR fim_ferias IS NULL OR fim_ferias > inicio_ferias),  -- Período de férias válido
    CHECK (inicio_ferias IS NULL OR admissao IS NULL OR inicio_ferias >= admissao),  -- Férias após admissão

    CONSTRAINT fk_contrato_carteira FOREIGN KEY (carteira_trabalho) REFERENCES carteira_trabalho(cidadao) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_contrato_empresa FOREIGN KEY (empresa) REFERENCES empresa(idempresa) 
    ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE IF NOT EXISTS unidade_atendimento (
    id_unidade SERIAL,
    detran INTEGER,
    PRIMARY KEY (id_unidade, detran),
    cidade VARCHAR(30) NOT NULL,
    rua VARCHAR(20) NOT NULL,
    numero SMALLINT NOT NULL,
    bairro VARCHAR(20) NOT NULL,

    CHECK (LENGTH(cidade) >= 2),  -- Cidade deve ter pelo menos 2 chars
    CHECK (cidade ~ '^[A-Za-zÀ-ÿ \-\.]+$'),  -- Cidade formato válido
    CHECK (LENGTH(rua) >= 2),  -- Rua válida
    CHECK (rua ~ '^[A-Za-zÀ-ÿ0-9 \-\.]+$'),  -- Rua formato válido
    CHECK (numero > 0),  -- Número positivo
    CHECK (LENGTH(bairro) >= 2),  -- Bairro válido

    CONSTRAINT fk_unidade_detran FOREIGN KEY (detran) REFERENCES detran(empresa) 
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS exame_psicotecnico (
    consulta INTEGER PRIMARY KEY,
    validade DATE,
    observacao VARCHAR(250),
    resultado BOOLEAN,
    tipo VARCHAR(100),
    unidade INTEGER,
    detran INTEGER,

    CHECK (validade IS NULL OR validade > CURRENT_DATE),  -- Validade deve ser futura
    CHECK (observacao IS NULL OR LENGTH(observacao) >= 2),  -- Observação válida
    CHECK (tipo IS NULL OR LENGTH(tipo) >= 2),  -- Tipo válido

    CONSTRAINT fk_exame_psico_consulta FOREIGN KEY (consulta) REFERENCES consulta(id) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_exame_psico_unidade FOREIGN KEY (unidade, detran) REFERENCES unidade_atendimento(id_unidade, detran) 
    ON DELETE SET NULL ON UPDATE SET NULL
);

CREATE TABLE IF NOT EXISTS exame_toxicologico (
    consulta INTEGER PRIMARY KEY,
    validade DATE,
    observacao VARCHAR(100),
    resultado BOOLEAN,
    unidade INTEGER,
    detran INTEGER,

    CHECK (validade IS NULL OR validade > CURRENT_DATE),  -- Validade deve ser futura
    CHECK (observacao IS NULL OR LENGTH(observacao) >= 2),  -- Observação válida

    CONSTRAINT fk_exame_toxic_consulta FOREIGN KEY (consulta) REFERENCES consulta(id) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_exame_toxic_unidade FOREIGN KEY (unidade, detran) REFERENCES unidade_atendimento(id_unidade, detran) 
    ON DELETE SET NULL ON UPDATE SET NULL
);

CREATE TABLE IF NOT EXISTS substancias (
    exame_toxicologico INTEGER,
    substancia VARCHAR(30),
    PRIMARY KEY (exame_toxicologico, substancia),

    CHECK (LENGTH(substancia) >= 2),  -- Substância deve ter pelo menos 2 chars
    CHECK (substancia ~ '^[A-Za-zÀ-ÿ0-9 \-\.]+$'),  -- Substância formato válido

    CONSTRAINT fk_substancias_exame FOREIGN KEY (exame_toxicologico) REFERENCES exame_toxicologico(consulta) 
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS exame_medico_cnh (
    consulta INTEGER PRIMARY KEY,
    validade DATE,
    observacao VARCHAR(100),
    resultado BOOLEAN,
    pcd BOOLEAN NOT NULL,
    usa_oculos BOOLEAN NOT NULL,
    unidade INTEGER,
    detran INTEGER,

    CHECK (validade IS NULL OR validade > CURRENT_DATE),  -- Validade deve ser futura
    CHECK (observacao IS NULL OR LENGTH(observacao) >= 2),  -- Observação válida

    CONSTRAINT fk_exame_medico_consulta FOREIGN KEY (consulta) REFERENCES consulta(id) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_exame_medico_unidade FOREIGN KEY (unidade, detran) REFERENCES unidade_atendimento(id_unidade, detran) 
    ON DELETE SET NULL ON UPDATE SET NULL
);

CREATE TABLE IF NOT EXISTS ametropias (
    exame_medico_cnh INTEGER,
    tipo VARCHAR(30),
    grau_esquerdo DECIMAL(4,2),
    grau_direito DECIMAL(4,2),
    PRIMARY KEY (exame_medico_cnh, tipo),

    CHECK (LENGTH(tipo) >= 2),  -- Tipo deve ter pelo menos 2 chars
    CHECK (tipo IN ('Miopia', 'Hipermetropia', 'Astigmatismo', 'Presbiopia')),  -- Tipos válidos
    CHECK (grau_esquerdo IS NULL OR (grau_esquerdo >= -20.00 AND grau_esquerdo <= 20.00)),  -- Grau válido
    CHECK (grau_direito IS NULL OR (grau_direito >= -20.00 AND grau_direito <= 20.00)),  -- Grau válido

    CONSTRAINT fk_ametropias_exame FOREIGN KEY (exame_medico_cnh) REFERENCES exame_medico_cnh(consulta) 
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS exame_admissional (
    consulta INTEGER PRIMARY KEY,
    validade DATE,
    observacao VARCHAR(100),
    resultado BOOLEAN,
    tipo VARCHAR(30),
    contrato INTEGER NOT NULL,
    carteira_trabalho INTEGER NOT NULL,
    empresa INTEGER NOT NULL,

    CHECK (validade IS NULL OR validade > CURRENT_DATE),  -- Validade deve ser futura
    CHECK (observacao IS NULL OR LENGTH(observacao) >= 2),  -- Observação válida
    CHECK (tipo IS NULL OR LENGTH(tipo) >= 2),  -- Tipo válido

    CONSTRAINT fk_exame_admissional_consulta FOREIGN KEY (consulta) REFERENCES consulta(id) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_exame_admissional_contrato FOREIGN KEY (contrato, carteira_trabalho, empresa) REFERENCES contrato(numero, carteira_trabalho, empresa) 
    ON DELETE CASCADE ON UPDATE CASCADE
);
