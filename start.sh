#!/usr/bin/env bash

source App/logar.sh 
nome=$(_ux 2 'Login' 'Digite seu nome' 'Autenticação do usuario')
senha=$(_ux 3 'Senha' 'Digite sua senha' 'Autenticação do usuario')

clear
echo "NOME: $nome SENHA: $senha"
#logar "$nome" "$senha"



