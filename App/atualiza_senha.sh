#!/usr/bin/env bash

atualiza_senha(){
  senha_antiga=$(_window 3 'Atualizando senha' 'Confirme a senha antiga:')
  logar "$login" "$senha_antiga"

  if [ $? -eq 0 ]; then
    senha_nova=$(_window 3 'Atualizando senha' 'Digite a nova senha')
    senha_reply=$(_window 3 'Atualizando senha' 'Confirme a nova senha: ')
    [ -n "$senha_nova" -a "$senha_nova" == "$senha_reply"  ] || return 1 
    _encrypt "$senha_nova"
    sql="UPDATE $TABELA SET senha='$senha_encrypt'  WHERE login='$login'" 

    sqlite3 "$BANCO" "$sql"
    tamanho='5 40'
   _window 0 'Sucesso' "\n   '$login' senha atualizada."
  else
    tamanho='5 40'
    _window 0 "Erro" "\n  Senha invalida"
   sleep 2
  fi  
}
