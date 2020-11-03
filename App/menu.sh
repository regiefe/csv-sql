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
exporta(){
    _window 0 'Exporta' 'Escolha a tabela que vai ser exportada' 
    sleep $transicao
    sqlite3 $BANCO "$sql" 
}
sair(){
    sair=$( _window 4 '' 'Quer mesmo sair agora' ) 

    [ "$?"  ] && {
      _window 0 'saida' "\n   Até logo"
      sleep $transicao
     exit 0
    }
}
menu(){
    while :  ; do
        escolha="$(dialog                             \
            --stdout                                  \
            --nocancel                                \
            --ok-label 'confirme'                     \
            --title 'Menu'                            \
            --menu "Usuario: '$login'"                \
            0 0 0                                     \
            arquivo  'Arquivo CSV'                    \
            senha    'Trocar a senha'                 \
            exporta  'Exporta tabela para planilha'   \
            sair     'Sair do  sistema'              
            )"


        case "$escolha" in 
            arquivo ) arquivo ;;
            senha )  senha ;;
            exporta )  exporta;;
            sair ) sair ;;
        esac
    done
}
