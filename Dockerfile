FROM alpine:latest

WORKDIR /csv-sql
COPY . .
RUN apk update && apk upgrade && \
apk add sqlite dialog perl-utils bash && \
rm -f /var/cache/apk/* && \
echo "Carregado banco de dados" && \
sqlite3 -box database/teste.db -cmd '.read database/login.sql' 2> /dev/null


