#!/bin/bash

# Nome do container
CONTAINER_NAME="airflow"

# Verifica se o container já existe
if [ $(docker ps -a -q -f name=$CONTAINER_NAME) ]; then
    # Se o container já existir, apenas o inicia
    echo "Container do Airflow já existe. Iniciando..."
    docker start $CONTAINER_NAME
else
    # Se o container não existir, cria e inicia
    echo "Iniciando nova imagem do Airflow..."
    docker run -d --name $CONTAINER_NAME -p 8080:8080 \
        -v $(pwd)/dags:/opt/airflow/dags \
        custom-airflow
    echo "Airflow iniciado..."
fi