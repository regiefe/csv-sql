#!/usr/bin/env bash

## Parceamento de arquivo csv para tabela 

source App/parser_csv_table.sh
BANCO='database/teste.db'

#tamanho='0 0'
for arquivo in $(ls csv); do
  parser_csv_table "csv/$arquivo"
done
#parser_csv_table csv/pessoa.csv
#parser_csv_table csv/cargos.csv

## Troca de senha se usuario 

#TABELA='login'
#login='maria'
#source 'App/atualiza_senha.sh'
#source 'Lib/_crud'
#source 'Lib/_window'
#atualiza_senha
