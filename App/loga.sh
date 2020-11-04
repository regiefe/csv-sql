#!/usr/bin/env bash

logar(){
  login=$1
  senha=$(echo "$2" | shasum | cut -d' ' -f1)
  sql="SELECT login, senha FROM '$TABELA' WHERE login='$login' AND senha='$senha'"
  sucesso=$(sqlite3 "$BANCO" "$sql")

 if [ -n "$sucesso" ] ; then
   _window 0 'Logado com  sucesso'  "\n Bem vindo '$1'" 'Esta logado'
   sleep $transicao
   return 0
 else
  _window 0  'Acesso negado' "\n Login ou senha invalido" 
  sleep $transicao
  exit 1
fi
}


