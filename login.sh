#!/usr/bin/env bash

BANCO='database/agenda.db'
TABELA='login'
source lib_db
encrypt(){
    senha=$(echo "$@" | shasum | cut -d' ' -f1) 
}

cor(){
    vermelho='\033[41m'
    verde='\033[42m'
    amarelo='\033[43;30m'
    azul='\033[44m'
    fim='\033[m'
}

login(){

    cor
    local linha=10
    local coluna=40
    local posicao="\033c\033[$linha;$coluna"
    for ((i = 0; i < 3; i++ )); do
        printf "$posicao"'H Login:  ' "$fim"
        read login
        stty -echo
        printf "$posicao"'H Senha:  ' 
        read senha
        encrypt $senha
        stty echo 
        [ ! $( _find "where login='$login' and senha='$senha'" ) ] || {
            echo
            echo -e "$verde Ola '$login' sua senha eh '$senha' $fim"
            se
            return
        }
            echo -e  "$vermelho Acesso negado! $fim"
    done
    exit 1
}

usuario(){
    cor
    local login senha
    echo "Cadastrar usuario"
    echo -ne "$azul login: $fim"
    read login
    echo -e "$azul senha: $fim"
    stty -echo
    read senha
    echo -ne "$amarelo Confirme a senha: $fim "
    read confirme
    stty echo
    echo
    [ "$senha" == "$confirme"   ] || {
        echo -e "$vermelho Senha incorreta $fim "
        return 1
    }

    [[ "$login" && "$senha"  ]] || {
        echo -e  "$vermelho Login ou senha esta vazio $fim"
        return 1
    }
    encrypt $senha
    _max
   #_insert $max $login $senha
}
