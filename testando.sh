#!/usr/bin/env bash

BANCO='database/teste.db'
TABELA='login'
tamanho='0 0'
login='maria'
source 'App/atualiza_senha.sh'
source 'Lib/_crud'
source 'Lib/_window'

atualiza_senha
