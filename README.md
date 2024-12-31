### Airflow-image
##### A ideia é criar uma imagem simples do `airflow` para testes utilizando um banco `Postgres` local. Caso tenham alguma dúvida de como foi montado tudo, há 2 aquivos na pasta `tutorials` com o passo a passo do que foi feito.
##### Para testar, faça o `clone` e siga os passos abaixo:

### Faça o build do Airflow
> docker build -t custom-airflow .

### Torne os scripts executáveis:
> chmod +x start_airflow.sh

> chmod +x stop_airflow.sh

### Execute o script para iniciar o container
> ./start_airflow.sh

### Execute o script para encerrar o container
> ./stop_airflow.sh
