# gerenciador-exames-bd

## Estrutura Atual do Projeto

```
gerenciador-exames-bd/
│
├── sql/
│   ├── esquema.sql          # Schema completo do banco (tabelas, índices, etc)
│   └── dados.sql            # Dados de exemplo/teste
│
├── main.py                  # Aplicação principal (menu interativo)
└── README.md               # Este arquivo
```

## Descrição dos Arquivos

### **sql/esquema.sql**
- **Propósito**: Define toda a estrutura do banco PostgreSQL
- **Conteúdo**: 
  - Criação de todas as tabelas (Cidadao, Medico, Hospital, Exame, etc.)
  - Relacionamentos entre tabelas (foreign keys)
  - Índices para otimização
  - Constraints de integridade
- **Como usar**: `sudo -u postgres psql -d sisdocs -f sql/esquema.sql`

### **sql/dados.sql** 
- **Propósito**: Insere dados de exemplo para testes
- **Conteúdo**:
  - Cidadãos de exemplo (Maria Silva, Carlos Oliveira)
  - CRMs, médicos, hospitais
  - Prontuários, alergias, tratamentos
- **Como usar**: `sudo -u postgres psql -d sisdocs -f sql/dados.sql`

### **main.py / mainCopy.py**
- **Propósito**: Interface de linha de comando para o sistema
- **Funcionalidades**:
  - Conecta com PostgreSQL usando psycopg2
  - Menu interativo para cadastrar cidadãos
  - Consultar exames por CPF
  - Gerenciar dados do sistema
- **Como usar**: `python3 main.py`

## Configuração e Execução

### **1. Pré-requisitos**
```bash
# Instalar PostgreSQL
sudo apt install postgresql postgresql-contrib

# Instalar dependência Python
sudo apt install python3-psycopg2
```

### **2. Configurar Banco de Dados**
```bash
# Criar database
sudo -u postgres createdb sisdocs

# Definir senha do usuário postgres
sudo -u postgres psql
ALTER USER postgres PASSWORD '1402';
\q

# Executar schema
sudo -u postgres psql -d sisdocs -f sql/esquema.sql

# Inserir dados de teste (opcional)
sudo -u postgres psql -d sisdocs -f sql/dados.sql
```

### **3. Executar Aplicação**
```bash
# Definir senha como variável de ambiente
export DB_PASS=1402

# Executar programa
python3 main.py
```

## Dados de Teste Disponíveis

Após executar `dados.sql`, você pode testar com:
- **CPF**: `11122233344` (Maria Silva)
- **CPF**: `22233344455` (Carlos Oliveira - médico)

## Conexão com Banco

A aplicação se conecta usando estas configurações (definidas em `main.py`):
- **Host**: localhost
- **Porta**: 5432 
- **Database**: sisdocs
- **Usuário**: postgres
- **Senha**: definida via variável `DB_PASS` ou prompt interativo

## Arquitetura Atual

Esta é uma **aplicação simples monolítica** com:
- Interface de linha de comando (CLI)
- Conexão direta com PostgreSQL
- Operações básicas de CRUD
- Estrutura de banco normalizada

**Observação**: O README anterior mostrava uma arquitetura mais complexa com Flask, APIs REST, e separação em camadas que ainda não foi implementada neste