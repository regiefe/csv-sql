#!/usr/bin/env bash

BANCO='database/agenda.db'
TABELA='login'
source lib_db
encrypt(){
    senha=$(echo "$@" | shasum | cut -d' ' -f1) 
}

cor(){
    vermelho='\033[41m'
    verde='\033[42;30m'
    amarelo='\033[43;30m'
    azul='\033[44m'
    fim='\033[m'
}

notificar(){
    echo
    echo -e "$2 $1 $fim"
}
cor
<<<<<<< HEAD
=======
notificar "Isso é um teste $verde"
>>>>>>> b830c9fed2f7ca07414db5565fa8531d96340975

login(){
    cor
    for ((i = 0; i < 3; i++ )); do
        notificar "Login:  $azul"
        read login
        stty -echo
        notificar "Senha:  $azul"
        read senha
        encrypt $senha
        stty echo 
        [ ! $( _find "WHERE login='$login' AND senha='$senha'" ) ] || {
            echo
            notificar  "Ola '$login' sua senha eh '$senha'  $verde"
            autoriza=$login
            return
        }
            notificar "Acesso negado!  $vermelho"
            autoriza=''
    done
    exit 1
}

usuario(){
    cor
    local login senha
    notificar "Cadastrar usuario $amarelo"
    notificar "Digite o login para cadastro:  $azul"
    read login
    notificar "Digite a senha do novo usuario:   $azul"
    stty -echo
    read senha
    notificar "Confirme a senha: $fim  $amarelo"
    read confirme
    stty echo
    echo
    [ "$senha" == "$confirme"   ] || {
        notificar "Senha incorreta   $vermelho"
        echo
        return 1
    }

    [[ "$login" && "$senha"  ]] || {
        notificar  "Login ou senha esta vazio $vermelho"
        echo
        return 1
    }
    encrypt $senha
    _insert $max $login $senha
    notificar "Usuario cadastrado por $autoriza" 
}

login

[ "$autoriza" ] || {
    return 1
}
usuario
_all
