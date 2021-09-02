SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema zombies
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `zombies` ;
CREATE SCHEMA IF NOT EXISTS `zombies` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `zombies` ;

-- -----------------------------------------------------
-- Table `zombies`.`zombie`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `zombies`.`zombie` ;

CREATE TABLE IF NOT EXISTS `zombies`.`zombie` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `born` DATETIME NULL,
  `previousName` VARCHAR(45) NULL,
  `pictureUrl` VARCHAR(200) NULL,
  `bittenBy` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_zombie_bittenBy_idx` (`bittenBy` ASC),
  CONSTRAINT `fk_zombie_bittenBy`
    FOREIGN KEY (`bittenBy`)
    REFERENCES `zombies`.`zombie` (`id`)
    ON DELETE SET NULL
    ON UPDATE SET NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zombies`.`person`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `zombies`.`person` ;

CREATE TABLE IF NOT EXISTS `zombies`.`person` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `alive` BOOLEAN NOT NULL DEFAULT 1,
  `eatenBy` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_person_eatenByZombie_idx` (`eatenBy` ASC),
  CONSTRAINT `fk_person_eatenByZombie`
    FOREIGN KEY (`eatenBy`)
    REFERENCES `zombies`.`zombie` (`id`)
    ON DELETE SET NULL
    ON UPDATE SET NULL)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- lista ultimo dia
SELECT * from usuario usr inner join emprestimo emp on usr.cpf = emp.usuario;

SELECT nome ,telefone, emal, status, diasbloqueado from usuario where CPF = '63362774024';
SELECT lvr.nome, lvr.autor,lvr.volume,lvr.ano, emp.dataemprestimo, emp.renova from livro lvr left join emprestimo emp on lvr.id = emp.id_livro where emp.usuario = '63362774024';
DROP VIEW IF EXISTS emprestimo_nome;
CREATE VIEW emprestimo_nome AS SELECT usr.nome, usr.emal ,emp.usuario, emp.dataemprestimo, emp.id_livro from emprestimo emp inner join usuario usr on usr.CPF = emp.usuario;

select lvr.nome, lvr.autor, emp.nome, emp.emal, emp.usuario,emp.dataemprestimo from emprestimo_nome emp inner join livro lvr on lvr.id = emp.id_livro order by emp.dataemprestimo;

UPDATE emprestimo set renova = renova - 1, dataemprestimo = CURDATE()  where usuario = '63362774024' and id_livro = 1;
<td>{{usuario}}</td>
                        <td>{{CPF}}</td>
                        <td>{{livro}}</td>
                        <td>{{id}}</td>
                        <td>{{status}}</td>
DROP VIEW IF EXISTS reserva_nome;
CREATE VIEW reserva_nome AS SELECT usr.nome, usr.emal ,res.usuario, res.data, res.status ,res.id_livro from reservas res inner join usuario usr on usr.CPF = res.usuario;
select res.nome,res.usuario as CPF, lvr.nome as livro, lvr.id, res.status res.data from reserva_nome res inner join livro lvr on lvr.id = res.id_livro order by res.data