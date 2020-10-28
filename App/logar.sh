#!/usr/bin/env bash

BANCO='database/usuario.db'
TABELA='login'
source Lib/_window

logar(){
  login=$1
  senha=$(echo "$2" | shasum | cut -d' ' -f1)
  sql="SELECT * FROM $TABELA WHERE login='$login' AND senha='$senha'"
  echo "$sql"
  
  logado=$(sqlite3 $BANCO "$sql") 
  [ "$logado" ] && {
    _window 1 'Logado'  "Bem vindo '$1'"
  } || {
    _window 1  'Acesso  restrito' ''
    exit 1
  }
}


