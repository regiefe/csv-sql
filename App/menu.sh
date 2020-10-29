#!/usr/bin/env bash

transicao=1

arquivo(){
    echo 'Pegando arquivo '
    _window 0 'pega arquivo' 'Escolha um arquivo ' 'Pega arquivo'
    sleep $transicao
}
senha(){
    _window 0 'Trocando a senha' 'Digite uma nova senha ' 
    sleep $transicao
}
outro(){
    _window 0 'Nova opção ' 'Informatido de nova opcao' 
    sleep $transicao
}
menu(){
    while :  ; do
        escolha="$(dialog --stdout                    \
            --title 'Menu'                            \
            --menu "Usuario: '$login'"                \
            0 0 0                                     \
            arquivo     'Arquivo CSV'                 \
            senha       'Trocar a senha'              \
            outro       'outra Opção'                 \
            sair        'Sair do  sistema'              
            )"


        case "$escolha" in 
            arquivo ) arquivo ;;
            senha )  senha ;;
            outro )  outro;;
            sair ) break ;;
        esac
    done
}
