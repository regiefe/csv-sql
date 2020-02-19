#!/usr/bin/env bash

BANCO='database/banco.db'
arquivo=$1
tabela=${arquivo%.csv}

cria_campos(){
    campos=$(sed -n 1p $arquivo | sed 's/;/, /g' )
    echo "$campos" | sed "s/, / text, /g;s/.*/CREATE TABLE $tabela ( & text  );/" | sqlite3 "$BANCO"
    echo .schema "$tabela" | sqlite3 "$BANCO" >> log
}

cria_tabela(){
    arquivo=$(sed 1d $arquivo)
    mkdir temp
    echo $arquivo > temp/file
    cat temp/file | sed 's/ /\n/g' > temp/newfile
    echo ".import temp/newfile $tabela" | sqlite3 -separator ";" $BANCO
    rm -r temp
    sqlite3 $BANCO "select * from $tabela" >> log
}

criar_indice(){
    echo "CREATE TABLE new$tabela ( id integer primary key autoincrement, $campos )" | sqlite3 $BANCO
    echo "INSERT INTO new$tabela ( $campos ) SELECT * FROM $tabela" | sqlite3 $BANCO
    echo "DROP TABLE $tabela" | sqlite3 $BANCO
    echo "ALTER TABLE new$tabela RENAME TO $tabela" | sqlite3 $BANCO
    echo "SELECT * FROM $tabela" | sqlite3 $BANCO >> log
}

cria_tabela_indice(){
    tabelas=($(sqlite3 $BANCO .tables))

    local i
    for ((i=0; i<${#tabelas[@]}; i++)) 
    do
        ${tabelas[$i]}_id=$(echo "select id from ${tabelas[$i]}" | sqlite3 database/banco.db) 
    done
}
cria_campos
cria_tabela
criar_indice
