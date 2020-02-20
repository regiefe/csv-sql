DROP TABLE indices;
CREATE TABLE indices (
    pessoa_id INTEGER,
    cargos_id INTEGER, 
    FOREIGN KEY (pessoa_id) REFERENCES pessoa(id), 
    FOREIGN KEY (cargos_id) REFERENCES cargos(id)
);

INSERT INTO indices (
    pessoa_id, 
    cargos_id
) SELECT pessoa.id, cargos.id FROM pessoa JOIN cargos ;
.table
select * from indices;    

