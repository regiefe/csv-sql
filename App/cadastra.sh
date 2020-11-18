#!/usr/bin/env bash
source Lib/_crud
source Lib/_encrypt

_check_login(){
    login=$*
    [ ! "$(sqlite3  $BANCO "SELECT * FROM $TABELA WHERE login='$login'")" ] || {
        msg="'$login' já foi cadastrado"
      return 1
    }
}

cadastrar(){
    local login="$1"
    local senha="$2"

    [ -n "$login" ] || {
        msg="Login  invalido"
        return 1
    }

    _check_login  $login

    [ -n "$senha" ] || {
        msg="Senha invalido"
        return 1
    }
    

    [ -n "$senha" -a "$senha" == "$REPLY"  ] || {
        msg="Senha invalida"
        return 1
    }

    _encrypt "$senha"

    sql="INSERT INTO $TABELA (login, senha) VALUES ( '$login', '$senha_encrypt')"
    sqlite3 "$BANCO" "$sql"
    msg="Cadastrado com  sucesso."
    sqlite3 -column -header $BANCO "SELECT * FROM $TABELA WHERE login='$login'"
}

remover(){
    remove="$@"
    sqlite3 -column $BANCO "SELECT login  FROM $TABELA" 
    sqlite3 -column $BANCO "DELETE FROM $TABELA WHERE login='$remove'"
    msg="'$remove' foi limado."
}

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

# atualiza_senha
# remover
# cadastrar
