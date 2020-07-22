drop table login;
create table login (
    id integer primary key autoincrement,
    login varchar(50) not null,
    senha varchar(100) not null
);
.schema login
