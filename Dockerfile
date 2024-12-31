# Use a imagem oficial do Airflow

FROM apache/airflow:2.10.4-python3.12

# Defina as variáveis de ambiente do Airflow
ENV AIRFLOW_HOME=/opt/airflow
ENV AIRFLOW__DATABASE__SQL_ALCHEMY_CONN=postgresql+psycopg2://airflow:airflow@host.docker.internal:5432/airflow
ENV AIRFLOW__CORE__EXECUTOR=LocalExecutor

# Instale dependências extras (opcional)
COPY requirements.txt /requirements.txt
RUN pip install --no-cache-dir -r /requirements.txt

# Copie as DAGs para o container
COPY dags /opt/airflow/dags

# Inicialize o banco de dados
RUN airflow db migrate

# Crie o usuário admin (Substitua <sua_senha> pela senha desejada)
RUN airflow users create \
    --username admin \
    --firstname Admin \
    --lastname User \
    --email admin@example.com \
    --role Admin \
    --password admin

# Exponha a porta 8080 para acesso à interface web do Airflow
EXPOSE 8080

# Defina o comando padrão para iniciar o webserver e o scheduler
CMD ["bash", "-c", "airflow webserver & airflow scheduler"]