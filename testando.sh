#!/usr/bin/env bash


source App/parser_csv_table.sh
BANCO='database/teste.db'
echo "$BANCO"
tamanho='0 0'

parser_csv_table csv/pessoa.csv
parser_csv_table csv/cargos.csv





#TABELA='login'
#login='maria'
#source 'App/atualiza_senha.sh'
#source 'Lib/_crud'
#source 'Lib/_window'
#atualiza_senha
