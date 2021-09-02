-- Gerado por Oracle SQL Developer Data Modeler 21.1.0.092.1221
--   em:        2021-08-28 17:55:47 BRT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema biblioteca
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `biblioteca` ;
CREATE SCHEMA IF NOT EXISTS `biblioteca` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `biblioteca` ;

CREATE TABLE aluno (
    cpf        VARCHAR(11) NOT NULL,
    matricula  VARCHAR(10)
);

ALTER TABLE aluno ADD CONSTRAINT aluno_pk PRIMARY KEY ( cpf );

ALTER TABLE aluno ADD CONSTRAINT aluno__un UNIQUE ( matricula );

CREATE TABLE emprestimo (
    id_livro        INTEGER NOT NULL,
    usuario         VARCHAR(11) NOT NULL,
    dataemprestimo  DATE NOT NULL,
    renova          INTEGER CHECK (renova >= 0 and renova <= 3) 
);

CREATE TABLE funcionario (
    cpf       VARCHAR(11) NOT NULL,
    registro  INT NOT NULL AUTO_INCREMENT PRIMARY KEY 
);

-- ALTER TABLE funcionario ADD CONSTRAINT funcionario_pk PRIMARY KEY ( cpf );

ALTER TABLE funcionario ADD CONSTRAINT funcionario__un UNIQUE ( registro );

CREATE TABLE livro (
    id          INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    nome        VARCHAR(50) NOT NULL,
    autor       VARCHAR(50) NOT NULL,
    editora     VARCHAR(50),
    volume      INTEGER,
    edicao      INTEGER,
    categoria   VARCHAR(50),
    descricao   VARCHAR(200),
    ano         INTEGER,
    quantidade  INTEGER
);

-- ALTER TABLE livro ADD CONSTRAINT livro_pk PRIMARY KEY ( nome,
--                                                        autor );

ALTER TABLE livro ADD CONSTRAINT livro__un UNIQUE ( id );

CREATE TABLE reservas (
    usuario   VARCHAR(11) NOT NULL,
    id_livro  INTEGER NOT NULL,
    data      DATE,
    status    VARCHAR(10)
);

CREATE TABLE usuario (
    nome      VARCHAR(50),
    cpf       VARCHAR(11) NOT NULL,
    telefone  VARCHAR(11),
    emal      VARCHAR(100),
    status    VARCHAR(10),
    diasbloqueado  INTEGER
);
ALTER TABLE usuario ADD CONSTRAINT usuario_ck_1 CHECK ( diasbloqueado >= 0 );

ALTER TABLE usuario ADD CONSTRAINT usuario_pk PRIMARY KEY ( cpf );

ALTER TABLE aluno
    ADD CONSTRAINT aluno_usuario_fk FOREIGN KEY ( cpf )
        REFERENCES usuario ( cpf )
            ON DELETE CASCADE;

ALTER TABLE emprestimo
    ADD CONSTRAINT emprestimo_livro_fk FOREIGN KEY ( id_livro )
        REFERENCES livro ( id );

ALTER TABLE emprestimo
    ADD CONSTRAINT emprestimo_usuario_fk FOREIGN KEY ( usuario )
        REFERENCES usuario ( cpf );

ALTER TABLE funcionario
    ADD CONSTRAINT funcionario_usuario_fk FOREIGN KEY ( cpf )
        REFERENCES usuario ( cpf )
            ON DELETE CASCADE;

ALTER TABLE reservas
    ADD CONSTRAINT reservas_livro_fk FOREIGN KEY ( id_livro )
        REFERENCES livro ( id );

ALTER TABLE reservas
    ADD CONSTRAINT reservas_usuario_fk FOREIGN KEY ( usuario )
        REFERENCES usuario ( cpf );


DROP VIEW IF EXISTS emprestimo_nome;
CREATE VIEW emprestimo_nome AS SELECT usr.nome, usr.emal ,emp.usuario, emp.dataemprestimo, emp.id_livro from emprestimo emp inner join usuario usr on usr.CPF = emp.usuario;

-- Relatório do Resumo do Oracle SQL Developer Data Modeler:
-- 
-- CREATE TABLE                             6
-- CREATE INDEX                             0
-- ALTER TABLE                             13
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0