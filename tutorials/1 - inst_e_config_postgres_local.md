# 1. Configuração do PostgreSQL Local
## 1.1 Instale o PostgreSQL na sua máquina

### No macOS ou Linux, você pode usar o Homebrew ou o gerenciador de pacotes correspondente.
`brew install postgresql`

## 1.2 Inicie o serviço PostgreSQL
`brew services start postgresql`

### Verifique se está rodando:
`psql --version`

## 1.3 Acesse o banco PostgreSQL
`psql postgres`

## 1.4 Crie o banco e os usuários
### Dentro do terminal psql:

#### -- Criar o banco de dados para o Airflow
`CREATE DATABASE airflow;`

#### -- Criar o usuário admin para o PostgreSQL
`CREATE USER admin WITH PASSWORD 'admin';`
`ALTER USER admin WITH SUPERUSER;`

#### -- Criar o usuário para o Airflow
`CREATE USER airflow WITH PASSWORD 'airflow';`
`GRANT ALL PRIVILEGES ON DATABASE airflow TO airflow;`

## Saia do psql
`\q`