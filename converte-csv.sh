#!/usr/bin/env bash

BANCO='database/banco.db'
arquivo=$1
tabela=${arquivo%.csv}

echo "$(sed -n 1p $arquivo | sed  "s/;/ text, /g; s/.*/CREATE TABLE $tabela ( & text );/")" | sqlite3 "$BANCO"
echo .schema "$tabela" | sqlite3 "$BANCO"

arquivo=$(sed 1d $arquivo)
mkdir temp
echo $arquivo > temp/file
cat temp/file | sed 's/ /\n/g' > temp/newfile
echo ".import temp/newfile $tabela" | sqlite3 -separator ";" $BANCO
rm -r temp
sqlite3 $BANCO "select * from $tabela"
echo "CREATE TABLE new$tabela ( id integer primary key autoincrement, login text, nome text, idade text, sexo text )" | sqlite3 $BANCO
echo "INSERT INTO new$tabela (login, nome, idade, sexo) SELECT * FROM $tabela" | sqlite3 $BANCO
echo "DROP TABLE $tabela" | sqlite3 $BANCO
echo "ALTER TABLE new$tabela RENAME TO $tabela" | sqlite3 $BANCO
sqlite3 $BANCO "select * from $tabela"
