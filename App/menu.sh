#!/usr/bin/env bash

arquivo(){
  _window 0 'pega arquivo' 'Escolha um arquivo ' 'Pega arquivo'
  sleep $transicao
}

troca_senha(){
  tamanho='0 0'
  atualiza_senha
}

cadastrar(){
  _window 0 'Exporta' 'Cadastro de usuario' 
  sleep $transicao
}
exporta(){
  _window 0 'Exporta' 'Escolha a tabela que vai ser exportada' 
  sleep $transicao
}

sair(){
  _window 4 '' 'Ja vai embora?'  

  if [ "$?" -eq 0 ] ; then
    _window 0 'saida' "\n   Até logo"
    sleep $transicao
    return 0
  else
    menu
  fi
}

menu(){
  while : ; do
    escolha="$(dialog                     \
      --stdout                            \
      --nocancel                          \
      --ok-label 'confirme'               \
      --title 'Menu'                      \
      --menu "Usuario: '$login'"          \
      0 0 10                              \
      '' ''                               \
      Arquivo   'Arquivo CSV'             \
      Troca_senha   'Trocar a senha'      \
      Cadastrar   'Cadastro de usuario'   \
      Exporta   'Exporta para planilha'   \
      Sair    'Sair do sistema'              
    )"

    case "$escolha" in 
      Arquivo ) arquivo ;;
      Troca_senha )  troca_senha ;;
      Cadastrar)  cadastrar;;
      Exporta )  exporta;;
      Sair ) sair && break ;;
    esac
  done
}
