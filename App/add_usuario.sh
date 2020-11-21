
add_usuario(){
    local login="$1"
    local senha="$2"

    sql="INSERT INTO $TABELA (login, senha) VALUES ( '$login', '$senha_encrypt')"
    sqlite3 "$BANCO" "$sql"
  
    _window 4  "SUCESSO" "\nQuer cadastrar outro usuario? " "$login cadastrado com  sucesso."

}
