#!/usr/bin/env bash

BANCO='database/banco.db'
arquivo=$1
tabela=${arquivo%.csv}
temp=$(mktemp)

cria_campos(){
    campos=$(sed -n 1p $arquivo | sed 's/;/, /g')
    echo "$campos" | sed "s/, / text, /g;s/.*/CREATE TABLE $tabela ( & text  );/" | sqlite3 "$BANCO"
    [ -d log ] || {
        mkdir log
    }
    echo "$(date +'%Y-%m-%d H%:%M') : Criado os campo da tabela $tabela" > log/$(echo $tabela)-log
    sqlite3 "$BANCO" ".schema $tabela" >> log/$(echo $tabela)-log
    echo >> log/$(echo $tabela)-log
}
cria_tabela(){
    cria_campos
    sed 1d $arquivo > $temp
    echo ".import $temp $tabela" | sqlite3 -separator ";" $BANCO
    echo "$(date +'%Y-%m-%d H%:%M') : Gerado a  tabela $tabela" >> log/$(echo $tabela)-log
    sqlite3 $BANCO "SELECT * FROM $tabela" >> log/$(echo $tabela)-log
    echo >> log/$(echo $tabela)-log
}

cria_indice(){
    cria_tabela
    echo "CREATE TABLE new$tabela ( id INTEGER PRIMARY KEY AUTOINCREMENT, $campos )" | sqlite3 $BANCO
    echo "INSERT INTO new$tabela ( $campos ) SELECT * FROM $tabela" | sqlite3 $BANCO
    echo "DROP TABLE $tabela" | sqlite3 $BANCO
    echo "ALTER TABLE new$tabela RENAME TO $tabela" | sqlite3 $BANCO
    echo "$(date +'%Y-%m-%d H%:%M') : Gerado o indice da tabela $tabela" >> log/$(echo $tabela)-log
    sqlite3 $BANCO -header -column "SELECT * FROM $tabela" >> log/$(echo $tabela)-log
    echo >> log/$(echo $tabela)-log
}

cria_indice

