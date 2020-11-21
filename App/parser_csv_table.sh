#!/usr/bin/env bash
[ -z "$BANCO" ] || {
  echo 'Tem que carragar a variavel $BANCO com o caminho do arquivo .db'   
  exit 1
}

parser_csv_table(){
  campos=$(sed -n 1p "$1"|sed 's/;/,/g')  
  tabela=$(echo ${1##*/})
  sql=$(sed "s/,/ text, /g;s/.*/CREATE TABLE IF NOT EXISTS ${tabela%.csv} ( id INTEGER PRIMARY KEY AUTOINCREMENT, & text  )/" <(echo $campos))
  sqlite3 "$BANCO" "$sql"
  sed 1d "$1" | nl -s ';' - > id-csv-nohead
  sqlite3 -separator ';' $BANCO '.import id-csv-nohead pessoa'
  sqlite3 -header -column $BANCO 'select * from pessoa'
  rm id-csv-nohead
}

