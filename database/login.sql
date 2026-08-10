DROP TABLE login;
CREATE TABLE login (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    login VARCHAR(50) NOT NULL,
    senha VARCHAR(100) NOT NULL
);
INSERT INTO login (login, senha) VALUES 
  ('teste','$2y$10$.CWHSqkOxSaxidCv00y/Lexa76.bGywET3zVEvCYN53lZj5kpcIju'),
  ('regi','$2y$10$.CWHSqkOxSaxidCv00y/Lexa76.bGywET3zVEvCYN53lZj5kpcIju'),
  ('heitor','$2y$10$.CWHSqkOxSaxidCv00y/Lexa76.bGywET3zVEvCYN53lZj5kpcIju');
.mode column
.header on
SELECT * FROM login;
