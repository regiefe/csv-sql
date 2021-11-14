#!/usr/bin/env bash
die(){
  printf "Erro: $1\n"
  return 1
}

logar(){
  login=${1:+${1,,}}
  senha=$(printf "${2:?'Senha invalida'}" | shasum | cut -d' ' -f1)
  [["$login" && "$senha"]] || die 'Login ou senha invalido'
  sql="SELECT login, senha FROM '$TABELA' WHERE login='$login' AND senha='$senha'"
  sucesso=$(sqlite3 "$BANCO" "$sql")

 if [ -n "$sucesso" ] ; then
   _window 0 'Logado com  sucesso'  "\n Logado com  '$login'" 'Esta logado'
   sleep $transicao
   return 0
 else
  _window 0  'Acesso negado' "\n Login ou senha invalido" 
  sleep $transicao
  return 1
fi
}


