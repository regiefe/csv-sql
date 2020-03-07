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
    echo "$(date +'%Y-%m-%d H%:m%') : Criado os campo da tabela $tabela" > log/$(echo $tabela)-log
    sqlite3 "$BANCO" ".schema $tabela" >> log/$(echo $tabela)-log
    echo >> log/$(echo $tabela)-log
}
cria_tabela(){
    cria_campos
    sed 1d $arquivo > $temp
    echo ".import $temp $tabela" | sqlite3 -separator ";" $BANCO
    echo "$(date +'%Y-%m-%d H%:m%') : Gerado a  tabela $tabela" >> log/$(echo $tabela)-log
    sqlite3 $BANCO "SELECT * FROM $tabela" >> log/$(echo $tabela)-log
    echo >> log/$(echo $tabela)-log
}

cria_indice(){
    cria_tabela
    echo "CREATE TABLE new$tabela ( id INTEGER PRIMARY KEY AUTOINCREMENT, $campos )" | sqlite3 $BANCO
    echo "INSERT INTO new$tabela ( $campos ) SELECT * FROM $tabela" | sqlite3 $BANCO
    echo "DROP TABLE $tabela" | sqlite3 $BANCO
    echo "ALTER TABLE new$tabela RENAME TO $tabela" | sqlite3 $BANCO
    echo "$(date +'%Y-%m-%d H%:m%') : Gerado o indice da tabela $tabela" >> log/$(echo $tabela)-log
    sqlite3 $BANCO -header -column "SELECT * FROM $tabela" >> log/$(echo $tabela)-log
    echo >> log/$(echo $tabela)-log
}

cria_indice

relaciona(){
    tabelas=($(sqlite3 $BANCO ".table"))
    echo  ${#tabelas[@]}
: '
    PRAGMA FOREIGN_KEYS=on;
    CREATE TABLE relacao ( 
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        cargos_id INTEGER, 
        pessoa_id INTEGER, 
        FOREIGN KEY (cargos_id) REFERENCES cargos(id), 
        FOREIGN KEY (pessoa_id) REFERENCES pessoa(id) 
    );
    INSERT INTO relacao  VALUES (null, 1,1 );
    INSERT INTO relacao  VALUES (null, 1,7 );
    INSERT INTO relacao  VALUES (null, 5,2 );
    INSERT INTO relacao  VALUES (null, 2,3 );
    INSERT INTO relacao  VALUES (null, 3,5 );
    INSERT INTO relacao  VALUES (null, 7,3 );

    SELECT p.nome contratado , c.cargo 
        FROM pessoa p  
        LEFT JOIN relacao r ON p.id=r.pessoa_id  
        JOIN cargos c ON c.id=r.cargos_id;
    SELECT * FROM pessoa p LEFT JOIN cargos c  ON p.id=c.id ;
'
}
relaciona
