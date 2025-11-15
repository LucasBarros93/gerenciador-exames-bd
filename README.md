# gerenciador-exames-bd

## Estrutura do Projeto

```
gerenciamento_exames/
│
├── sql/
│   ├── 01_criar_tabelas.sql
│   ├── 02_criar_indices.sql
│   ├── 03_restricoes_integridade.sql
│   ├── 04_dados_iniciais.sql
│   └── schema.sql 
│
├── src/
│   ├── __init__.py
│   ├── config.py
│   ├── database.py
│   ├── models/
│   │   ├── cidadao.py
│   │   ├── medico.py
│   │   ├── hospital.py
│   │   ├── exame.py
│   │   ├── consulta.py
│   │   ├── crm.py
│   │   └── prontuario.py
│   ├── repositories/
│   │   ├── cidadao_repository.py
│   │   ├── medico_repository.py
│   │   ├── hospital_repository.py
│   │   ├── exame_repository.py
│   │   └── consulta_repository.py
│   ├── services/
│   │   ├── autenticacao_service.py
│   │   ├── exame_service.py
│   │   ├── consulta_service.py
│   │   └── validacao_service.py
│   ├── routes/
│   │   ├── cidadao_routes.py
│   │   ├── hospital_routes.py
│   │   ├── exame_routes.py
│   │   ├── governo_routes.py
│   │   └── auth_routes.py
│   └── utils/
│       └── utils.py
│
├── tests/
│   └── test.py
│
├── main.py
├── requirements.txt
└── README.md
```
Sugestão da IA, não sei o que é metade disso ai

## Explicação da estrutura
### Pasta sql/ - Scripts de Banco de Dados 

Escopo: Centraliza todos os scripts SQL do PostgreSQL, organizados em ordem de execução
Relação: Estes arquivos são executados uma única vez durante a configuração inicial do banco. A aplicação Python fará leitura/escrita neste banco. 

### Pasta src/ - Código-Fonte Principal 

Este é o coração da aplicação[2]. Aqui fica toda a lógica da aplicação. Vou detalhar cada subpasta: 
#### config.py - Configurações Globais 

Escopo: Define variáveis de ambiente e configurações da aplicação. 
Relação: É importado por database.py para conectar ao banco e pela aplicação principal para definir comportamentos. 

#### database.py - Gerenciador de Conexão 

Escopo: Estabelece e gerencia a conexão com PostgreSQL
Relação: É utilizado por todos os repositories. Cada repository recebe uma instância do Database para executar operações. 

### Pasta models/ - Definições de Dados 

Escopo: Definem a estrutura das entidades do sistema (não são modelos ORM, mas representações das tabelas)[3]. 
Relação: São usados pelos repositories para estruturar dados antes de salvar no banco ou depois de recuperar. 

### Pasta repositories/ - Acesso a Dados 

Escopo: Implementam o padrão Repository, abstraindo operações SQL
Relação:  
- Recebem uma instância de Database no construtor
- Usam models/ para estruturar dados
- São consumidos pelos services/
     
### Pasta services/ - Lógica de Negócio 

Escopo: Implementam as regras de negócio da aplicação. Orquestram múltiplos repositories
Relação: 
- Recebem múltiplos repositories (injeção de dependência)
- Implementam a lógica que a aplicação precisa
- São chamados pelos routes/
     
### Pasta routes/ - Endpoints da API 

Escopo: Define os endpoints HTTP que os usuários acessam[2]. 
Relação: 
- Recebem requests HTTP dos usuários
- Chamam services/ para processar
- Retornam responses HTTP

### Pasta utils/ - Utilitários 

Escopo: Funções auxiliares compartilhadas pela aplicação. 
Relação: Importados por services/ e routes/ conforme necessário. 

### Pasta tests/ - Testes Automatizados 

Escopo: Testes unitários e de integração
Relação: Executados durante desenvolvimento para garantir que services/ e repositories/ funcionam corretamente. 

### Arquivos Raiz 

#### main.py - Inicializa a aplicação Flask 
#### env - Variáveis de ambiente  
#### requirements.txt - Dependências Python
