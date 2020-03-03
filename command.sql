relaciona(){
    CREATE TABLE relacao ( 
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        cargos_id INTEGER, 
        pessoa_id INTEGER, 
        FOREIGN KEY (cargos_id) REFERENCES cargos(id), 
        FOREIGN KEY (pessoa_id) REFERENCES pessoa(id) 
    );
    INSERT INTO relacao  VALUES (null, 3,5 );
    SELECT p.nome contratado , c.cargo 
        FROM pessoa p  
        LEFT JOIN relacao r ON p.id=r.pessoa_id  
        JOIN cargos c ON c.id=r.cargos_id;
    SELECT * FROM pessoa p LEFT JOIN cargos c  ON p.id=c.id ;
}

