DROP TABLE login;
CREATE TABLE login (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    login VARCHAR(50) NOT NULL,
    senha VARCHAR(100) NOT NULL
);
INSERT INTO login (login, senha) VALUES 
  ('teste','a8fdc205a9f19cc1c7507a60c4f01b13d11d7fd0'),
  ('regi','c4f9375f9834b4e7f0a528cc65c055702bf5f24a'),
  ('maria','a8fdc205a9f19cc1c7507a60c4f01b13d11d7fd0');
.mode column
.header on
SELECT * FROM login;
