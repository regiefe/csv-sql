#!/usr/bin/env bash

BANCO='database/usuario.db'
TABELA='login'

source Lib/_crud

_encrypt(){
    senha_encrypt=$(msg="$@" | shasum | cut -d' ' -f1) 
}

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
    read -p "Digite o login para atualiza a senha: " login
    [ -n "$login" ] || {
        msg="Login  invalido"
        return 1
    }
    read -p "Confirma a senha antiga: " senha_antiga
    _encrypt "$senha_antiga"
    [ "$(sqlite3 $BANCO "SELECT * FROM $TABELA WHERE senha='$senha_encrypt'")" ] || {
        msg="Login o senha invalido"
        exit 1
    } 
    read -s -p  "Digite a nova senha: " senha_nova
    echo
    read -s -p  "Confirmar a nova: " 
    echo
    [ -n "$senha_nova" -a "$senha_nova" == "$REPLY"  ] || {
        msg="Senha invalida"
        return 1
    }
    _encrypt "$senha_nova"
    sqlite3 $BANCO "UPDATE $TABELA SET senha='$senha_encrypt'  WHERE login='$login'" 
    msg="'$login' senha atualizada."

}
atualiza_senha
#remover
#cadastrar
