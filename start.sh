#!/usr/bin/env bash

source Lib/_window
source App/loga.sh 
source App/menu.sh

BANCO='database/usuario.db'
TABELA='login'
transicao=1
tamanho='0 0'

nome=$(_window 2 'Login' 'Digite seu nome' 'Autenticação do usuario')
senha=$(_window 3 'Senha' 'Digite sua senha' 'Autenticação do usuario')

tamanho='5 40'
logar "$nome" "$senha" 

menu





