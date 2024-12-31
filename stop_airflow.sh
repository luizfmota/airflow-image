#!/bin/bash

# Nome do container
CONTAINER_NAME="airflow"

# Verifica se o container está ativo (em execução)
if [ $(docker ps -q -f name=$CONTAINER_NAME) ]; then
    echo "Container $CONTAINER_NAME está ativo. Encerrando..."
    docker stop $CONTAINER_NAME
    echo "Container $CONTAINER_NAME foi encerrado."
else
    echo "Container $CONTAINER_NAME não está ativo."
fi