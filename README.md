# gerenciador-exames-bd

## Estrutura do Projeto

```
gerenciamento_exames/
├── main.py
├── README.md
├── requirements.txt
├── .gitignore
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

## Explicação da estrutura
### /sql
Organiza os arquivos de banco de dados do projeto, além do `connection.py`, que é responsável pela conexão da aplicação com o banco

#### init.sql
Exemplo de como criar a base

#### esquema.sql
Criação de todas as tabelas da base

#### dados.sql
Inserção inicial de dados do banco

#### consultas.sql
Cinco consultas exigidas pelo trabalho

### /src
Organiza os arquivos diretamente ligados a aplicação

#### commands.py
Execução dos comandos sql feitos pela aplicação com dados coletados do usuário

#### consulta.py
Criação da classe "consulta" relacianada a tabela de mesmo nome. Nota: não confundir com consultas.sql, o nome é só conhecidencia

#### screen.py
Implementação da classe que desenha todas as telas da aplicação

#### utils.py
Funções uteis

### main.py
Coração da aplicação, onde tudo acontece.

### requirements.txt
Bibliotecas python necessárias para a execução da aplicação

### README.md
Este arquivo...

