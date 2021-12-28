source Lib/_encrypt
source App/atualiza_senha.sh
source App/add_usuario.sh
source App/parser.sh
source Lib/_check_login
source Lib/_check_senha

arquivo(){
  csv="$(dialog --title 'selecione um arquivo' --stdout --fselect $PWD 0 0)"
  if [[ -f $csv   ]];then
    parser "$csv"
  else
    return 1
  fi
}

troca_senha(){
  tamanho='0 0'
  atualiza_senha
}

is_login(){
    sql="SELECT * FROM $TABELA WHERE login='$1'"
    sqlite3 "$BANCO" "$sql"
    return 1
}

cadastrar(){
  tamanho='0 0'
  login=$(_window 2 'Login' 'Digite o nome do novo usuario' 'Cadastro de usuario')
  is_login $login

  if [ "$?" ]; then
    senha=$(_window 3 'Senha' 'Digite a senha do novo usuario' 'Cadastro de usuario')
    confirma=$(_window 3 'Senha' 'Confirame a senha novo usuario' 'Cadastro de usuario')
  fi

  _check_login  $login

  _check_senha "$senha" "$confirma"

  add_usuario "$login" "$senha"
    [ $? -ne 0 ] || {
        cadastrar
    }
    return 0
}

exporta(){
  _window 0 'Exporta' 'Escolha a tabela que vai ser exportada' 
  sleep $transicao
}

sair(){
  _window 4 'SAIDA' 'Ja vai embora?' 'tchau tchau' 

  if [ "$?" ] ; then
    _window 0 'saida' "\n   Até logo"
    sleep $transicao
    clear
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
      Exporta   'Exporta para planilha'   \
      Cadastrar   'Cadastro de usuario'   \
      Troca_senha   'Trocar a senha'      \
      Sair    'Sair do sistema'              
    )"

    case "$escolha" in 
      Arquivo     ) arquivo     ;;
      Exporta     ) exporta     ;;
      Cadastrar   ) cadastrar   ;;
      Troca_senha ) troca_senha ;;
      Sair ) sair && break      ;;
    esac
  done
}
