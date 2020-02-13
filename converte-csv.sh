#!/usr/bin/env bash

BANCO='banco.db'
arquivo='ramais.csv' 
tabela='teste'

echo "$(sed -n 1p $arquivo | sed -e "s/;/ text,/g; s/.*/create table $tabela (&);/")" | sqlite3 "$BANCO"
echo ".separator \";\""  | sqlite3 $BANCO
echo ".import $arquivo $tabela " | sqlite3 $BANCO
