FROM alpine:latest
RUN apk update && apk upgrade && \
apk add git sqlite dialog perl-utils bash && \
rm -f /var/cache/apk/*
WORKDIR /csv-sql
COPY . .
RUN sqlite3 -box database/teste.db -cmd '.read database/login.sql' 2> /dev/null

