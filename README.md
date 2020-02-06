# db-sql
Biblioteca shell script para maniputar tabela no sqlte3.

# Funcionamento

Primeiro instale o banco de dadso sqlite.

Faça um clone do repositorio.

Set a variavel  BANCO com o caminho dos arquivo do banco.

Set a variavel TABELA com o nome da tabela.

Carrege o arquivo  lib_db  no seu script [ source ou .]

E chame as função:


  	_all [ campo ]  #Para mostra todos os elementos da tabela.
  
  	_find [ identificador ] #Primeiro campo da tabela tem que ser o identificandor.
  
  	_delete indentificador #Delete apenas uma dado  da tabela de cada vez.
  
  	_insert #valor dos argumentos tem que ser igual aos campos da tabela
  
   	_update #valor dos argumentos não pode ultapassar os campos da tabela.
    
    _tem #verifica se o identificador esta na tabela 
