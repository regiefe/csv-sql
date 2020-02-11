#!/usr/bin/env bash
BANCO='database/agenda.db'
TABELA='usuario'
source lib_db
_find outro
_all
echo
_all login
_insert outro 'isso+aqui+é+um+teste' 23 M
echo
echo
_update outro 'Isso+vou+alterado' 23 M
echo
_find outro
echo
_delete outro

