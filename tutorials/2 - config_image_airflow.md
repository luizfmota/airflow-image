# 1. Criação da Imagem do Airflow
### Você criará uma imagem Docker personalizada para o Airflow.

## 1.1 Estrutura do Projeto
### Organize os arquivos no seguinte formato:

    .
    ├── Dockerfile
    ├── requirements.txt
    ├── dags/    
    │ 	└── example_dag.py

## 1.2 Crie o arquivo `Dockerfile`
### O `Dockerfile` define a imagem personalizada do Airflow.

`# Use a imagem oficial do Airflow`
> FROM apache/airflow:2.10.4-python3.12

`# Defina as variáveis de ambiente do Airflow`
> ENV AIRFLOW_HOME=/opt/airflow
> ENV AIRFLOW__DATABASE__SQL_ALCHEMY_CONN=postgresql+psycopg2://airflow:airflow@host.docker.internal:5432/airflow
> ENV AIRFLOW__CORE__EXECUTOR=LocalExecutor
   
`# Instale dependências extras (opcional)`
> COPY requirements.txt /requirements.txt 
> RUN pip install --no-cache-dir -r /requirements.txt 
    
`# Copie as DAGs para o container`
> COPY dags /opt/airflow/dags 

`# Inicialize o banco de dados`
> RUN airflow db migrate

`# Crie o usuário admin (Substitua <sua_senha> pela senha desejada)`
> RUN airflow users create \
>     --username admin \
>     --firstname Admin \
>     --lastname User \
>     --email admin@example.com \
>     --role Admin \
>     --password admin

`# Exponha a porta 8080 para acesso à interface web do Airflow`
> EXPOSE 8080
    
`# Configure o ponto de entrada`
> CMD ["bash", "-c", "airflow db migrate && airflow webserver & airflow scheduler"]

## 1.3 Crie o arquivo requirements.txt
### Inclua dependências adicionais, se necessário. Por exemplo:

    pandas==2.2.3
    requests==2.32.3
    psycopg2-binary

## 1.4 Crie um exemplo de DAG, caso queira
### Na pasta dags/, crie um arquivo chamado exemplo_dag.py:

    from airflow import DAG
    from airflow.operators.dummy import DummyOperator
    from datetime import datetime

    with DAG(
        dag_id='example_dag',
        start_date=datetime(2024, 1, 1),
        schedule_interval=None,
        catchup=False,
    ) as dag:
        start = DummyOperator(task_id='start')
        start

# 2. Construção da Imagem do Airflow
## 2.1 Construa a imagem
### Na pasta onde está o Dockerfile, execute:

> docker build -t custom-airflow .

# 3. Executando o Airflow
## 3.1 Inicie o container
### Monte a pasta local `dags/` para que o Airflow atualize as DAGs dinamicamente:

> docker run -d --name airflow -p 8080:8080 -v $(pwd)/dags:/opt/airflow/dags custom-airflow

## 4.2 Acessar a interface do Airflow
### Abra o navegador e acesse: http://localhost:8080.
### Faça login com:

> Usuário: admin
> Senha: admin