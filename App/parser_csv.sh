#!/usr/bin/env bash
[ "$BANCO" ] || {
  BANCO='../database/banco.db'
}
path=$1
arquivo=$path
arquivo=${arquivo##*/}

tabela=${arquivo%.csv}
tabela=${tabela:+"t_$tabela"}

temp=$(mktemp)

cria_campos(){
  campos=$(head -n1 "$path" | tr ';' ',' ) # extrai campo(s) do csv
  #cria tabela com o nome do  csv  
  sqlite3 "$BANCO" "$(sed "s/,/ text, /g;s/.*/CREATE TABLE IF NOT EXISTS ${tabela} ( & text )/" <(echo $campos))"
  [ -d ../log ] || {
    mkdir ../log
}
# registro de log
echo "$(date +'%Y-%m-%d %H:%M') : Criado os campo da tabela ${tabela}" > ../log/$(echo ${tabela})-log
sqlite3 "$BANCO" ".schema ${tabela}" >> ../log/$(echo ${tabela})-log
echo >> ../log/$(echo ${tabela})-log
}

cria_tabela(){
  cria_campos
  sed 1d "$path"  > $temp

  sqlite3 -separator ";" $BANCO ".import $temp ${tabela}" #importa arquivo csv
  # log da tabela criada
  echo "$(date +'%Y-%m-%d %H:%M') : Gerado a  tabela ${tabela}" >> ../log/$(echo ${tabela})-log
  sqlite3 $BANCO "SELECT * FROM ${tabela}" >> ../log/$(echo ${tabela})-log
  echo >> ../log/$(echo ${tabela})-log
}

cria_indice(){
  cria_tabela
  #Gera uma novo tabela com id
  sqlite3 $BANCO "CREATE TABLE new${tabela} ( id INTEGER PRIMARY KEY AUTOINCREMENT, $campos )" 
  #Exporta os dados para a nova tabela
  sqlite3 $BANCO "INSERT INTO new${tabela} ( $campos ) SELECT * FROM ${tabela}" 
  #Apaga a tabela anterior
  sqlite3 $BANCO "DROP TABLE ${tabela}" 
  #Renomeia a nova tabela para a antiga
  sqlite3 $BANCO "ALTER TABLE new${tabela} RENAME TO ${tabela}" 
  #log da tabela com id 
  echo "$(date +'%Y-%m-%d %H:%M') : Gerado o indice da tabela ${tabela}" >> ../log/$(echo ${tabela})-log
  sqlite3 $BANCO -header -column "SELECT * FROM ${tabela}" >> ../log/$(echo ${tabela})-log
  echo >> ../log/$(echo ${tabela})-log
}
cria_indice

