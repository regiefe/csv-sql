#!/usr/bin/env bash
source Lib/_sanitize
source Lib/_encrypt

logar(){
  local login="$(_sanitize_sql "${1}")"
  local senha="$2"
  local sql="SELECT login, senha FROM '$TABELA' WHERE login='$login'"
  local resultado=$(sqlite3 "$BANCO" "$sql")
  
  if [ -n "$resultado" ]; then
    local hash=$(echo "$resultado" | cut -d'|' -f2)
    if _verificar_senha "$senha" "$hash"; then
      local sucesso="ok"
    fi
  fi

 if [ -n "$sucesso" ] ; then
   _window 0 'Logado com  sucesso'  "\n Logado com  '$login'" 'Esta logado'
   sleep $transicao
   return 0
 else
  _window 0  'Acesso negado' "\n Login ou senha invalido" 
  sleep $transicao
  return 1
fi
}


