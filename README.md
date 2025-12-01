# gerenciador-exames-bd

Sistema em Python para gerenciar exames médicos utilizando PostgreSQL como banco de dados.
A aplicação roda no terminal e permite cadastrar consultas, visualizar dados e executar consultas SQL obrigatórias do trabalho.

---

##  Estrutura do Projeto

```
gerenciamento_exames/
├── main.py
├── README.md
├── requirements.txt
├── .gitignore
├── .env.example
├── sql
│   ├── connection.py
│   ├── consultas.sql
│   ├── dados.sql
│   ├── esquema.sql
│   └── init.sql
└── src
    ├── __init__.py
    ├── commands.py
    ├── consulta.py
    ├── screen.py
    └── utils.py
```

---

##  Explicação da Estrutura

### `sql/`

Contém tudo relacionado ao banco de dados.

#### `connection.py`

Arquivo Python responsável por conectar na base usando as variáveis do `.env`.

#### `init.sql`

Criação da **DATABASE** e permissões básicas (exemplo de estrutura inicial).

#### `esquema.sql`

Criação de todas as **tabelas** do sistema.

#### `dados.sql`

Inserção de dados iniciais (exemplos para teste).

#### `consultas.sql`

Cinco consultas SQL obrigatórias do trabalho.

---

### `src/`

Contém toda a lógica da aplicação.

#### `commands.py`

Executa os comandos SQL necessários, interage com o banco e retorna resultados para a interface.

#### `consulta.py`

Implementa a classe `Consulta`, representando a tabela de mesmo nome.
*(Não confundir com consultas.sql — coincidência de nomes).*

#### `screen.py`

Implementa a lógica responsável por desenhar todas as telas e menus da aplicação no terminal.

#### `utils.py`

Funções auxiliares usadas em várias partes do projeto.

---

### `main.py`

Ponto de entrada da aplicação: inicializa telas, comandos, menus e toda a lógica principal.

### `requirements.txt`

Lista de bibliotecas Python necessárias para rodar o projeto.

### `README.md`

Você está aqui :)

### `.env.example`

Exemplo de arquivo do ambiente contendo as variáveis necessárias para conectar ao PostgreSQL.

---

## Como usar

### 1. Criar e ativar o **venv**

```sh
python3 -m venv venv
source venv/bin/activate
```

### 2. Instalar dependências

```sh
pip install -r requirements.txt
```

---

## Configurar o banco PostgreSQL

### 1. Criar a DATABASE

Execute o `init.sql`:

```sh
sudo -u postgres psql -f sql/init.sql
```

Ou:

```sh
psql -U postgres -f sql/init.sql
```

---

### 2. Criar as tabelas

```sh
psql -d <nome_da_base> -f sql/esquema.sql
```

### 3. Inserir dados iniciais (opcional)

```sh
psql -d <nome_da_base> -f sql/dados.sql
```

---

## Configurar variáveis de ambiente (.env)

Crie um arquivo `.env` na raiz:

```
DB_HOST=localhost
DB_PORT=5432
DB_NAME=gerenciador
DB_USER=grupo3
DB_PASSWORD=senha
```

Você também pode copiar o exemplo:

```sh
cp .env.example .env
```

---

## Executar o programa

Com o venv ativado:

```sh
python3 main.py
```

A interface de terminal será exibida, permitindo navegar pelas telas, cadastrar consultas, listar dados e executar as consultas pré-definidas.
