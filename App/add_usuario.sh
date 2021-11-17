
add_usuario(){
    erro='Login e senha nao pode ser vazio'
    local login="${1:?$erro}"
    local senha="${2:?$erro}"
    sql="INSERT INTO $TABELA (login, senha) VALUES ( '$login', '$senha_encrypt')"
    sqlite3 "$BANCO" "$sql"
   
    _window 4  "SUCESSO" "\nQuer cadastrar outro usuario? " "$login cadastrado com  sucesso."

}
