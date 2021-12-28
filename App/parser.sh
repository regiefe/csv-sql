#!/usr/bin/env bash

parser(){
  local campos=$(sed -n 1p "$1"|sed 's/;/,/g')  
  local arquivo=$(echo ${1##*/})
  local tabela=${arquivo%.csv}

  sql=$(sed "s/,/ text, /g;s/.*/CREATE TABLE IF NOT EXISTS $tabela ( id INTEGER PRIMARY KEY AUTOINCREMENT, & text  )/" <(echo $campos))
  sqlite3 "$BANCO" "$sql"
  sed 1d "$1" | nl -s ';' - > id-csv-nohead
  sqlite3 -separator ';' $BANCO ".import id-csv-nohead $tabela"
  sqlite3 -header -column $BANCO "select * from $tabela"
  rm id-csv-nohead
}

