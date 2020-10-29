#!/usr/bin/env bash

source Lib/_window
source App/loga.sh 
source App/menu.sh

nome=$(_window 2 'Login' 'Digite seu nome' 'Autenticação do usuario')
senha=$(_window 3 'Senha' 'Digite sua senha' 'Autenticação do usuario')

 logar "$nome" "$senha" 
 menu





