FROM alpine:latest
RUN apk update && apk upgrade &&\
apk add git sqlite dialog perl-utils
COPY . csv-sql
RUN cd csv-sql &&\
sqlite3 -box database/teste.db -cmd '.read database/login.sql' 2> /dev/null

