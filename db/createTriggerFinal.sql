use biblioteca;
drop TRIGGER IF EXISTS upd_check;
delimiter //
CREATE TRIGGER upd_check BEFORE insert ON emprestimo
       FOR EACH ROW    
       BEGIN
           declare s int;
           set @is_funcionario = (select cpf from funcionario where cpf = NEW.usuario);
           set @s = (select COUNT(*) from emprestimo where usuario = NEW.usuario);
           set @id_repetido = (select COUNT(*) from emprestimo where usuario = NEW.usuario and id_livro = NEW.id_livro);
           IF @id_repetido > 0 THEN
                    signal sqlstate '99999' set message_text = 'Erro: O usuario já possui uma copia deste livro';
           END IF;
           IF @is_funcionario is NULL THEN
                IF @s > 5 THEN
                    signal sqlstate '99999' set message_text = 'Erro: Aluno atingiu o limite de 5 livros emprestado';
                END IF;
           else
                IF @s > 10 THEN
                    signal sqlstate '99999' set message_text = 'Erro: Funcionario atingiu o limite de 10 livros emprestado';
                END IF;
            END IF;
       END; //
delimiter ;


-- ---------------------------------------------------------------------- --

use biblioteca;
drop TRIGGER IF EXISTS qtd_livrosDisponiveis;
delimiter //
CREATE TRIGGER qtd_livrosDisponiveis BEFORE insert ON emprestimo
       FOR EACH ROW    
       BEGIN
           declare s int;
           set @qts_livro = (select COUNT(*) from emprestimo where id_livro = NEW.id_livro);
           set @unLivros = (select quantidade from livro where id = NEW.id_livro);
           IF (@unLivros - @qts_livro ) <= 0 THEN
                    signal sqlstate '99999' set message_text = 'Erro: Sem livros disponiveis';
           END IF;
       
       END; //
delimiter ;

-- --------------------------------------------------------------------- --

use biblioteca;
drop TRIGGER IF EXISTS reserva_usuario;
delimiter //
CREATE TRIGGER reserva_usuario BEFORE UPDATE ON emprestimo
       FOR EACH ROW    
       BEGIN
           declare s int;
           set @reservas = (select COUNT(*) from reservas where id_livro = NEW.id_livro);
           IF @reservas > 0 THEN
                    signal sqlstate '99999' set message_text = 'Erro: Não é possivel renovar livro, Outro usuario possui uma reserva';
           END IF;
       
       END; //
delimiter ;

-- ---------------------------------------------------------------------------------- --
use biblioteca;
drop TRIGGER IF EXISTS reserva_disponivel;
delimiter //
CREATE TRIGGER reserva_disponivel BEFORE insert ON reservas
       FOR EACH ROW    
       BEGIN
           declare s int;
           set @qts_livro = (select COUNT(*) from emprestimo where id_livro = NEW.id_livro);
           set @unLivros = (select quantidade from livro where id = NEW.id_livro);
           IF (@unLivros - @qts_livro ) > 0 THEN
                    signal sqlstate '99999' set message_text = 'Erro: Não é possivel realizar esta reserva, Livro se encontra disponivel';
           END IF;
       
       END; //
delimiter ;


-- --------------------------------------------------------------- --
use biblioteca;
drop TRIGGER IF EXISTS limit_reservas;
delimiter //
CREATE TRIGGER limit_reservas BEFORE insert ON reservas
       FOR EACH ROW    
       BEGIN
           declare s int;
           set @qts_reservas = (select COUNT(*) from reservas where usuario = NEW.usuario);
           IF @qts_reservas > 3 THEN
                    signal sqlstate '99999' set message_text = 'Erro: Limite de reservas por usuario';
           END IF;
       
       END; //
delimiter ;

-- ------------------------------------------------------------------ --

use biblioteca;
drop TRIGGER IF EXISTS reserva_duplicada;
delimiter //
CREATE TRIGGER reserva_duplicada BEFORE insert ON reservas
       FOR EACH ROW    
       BEGIN
           declare s int;
           set @qts_reservas = (select COUNT(*) from reservas where usuario = NEW.usuario and id_livro = NEW.id_livro);
           IF @qts_reservas > 0 THEN
                    signal sqlstate '99999' set message_text = 'Erro: Usuario já possui uma reserva deste livro';
           END IF;
       
       END; //
delimiter ;

-- ----- --

use biblioteca;
drop TRIGGER IF EXISTS usuario_bloqueado;
delimiter //
CREATE TRIGGER usuario_bloqueado BEFORE insert ON emprestimo
       FOR EACH ROW    
       BEGIN
           declare s int;
           set @status_usr = (select status from usuario where CPF = NEW.usuario);
           IF @status_usr != 'ok' THEN
                    signal sqlstate '99999' set message_text = 'Erro: Usuario Bloqueado no Sistema';
           END IF;
       
       END; //
delimiter ;

-- --------------------------------------------------------------- --

use biblioteca;
drop TRIGGER IF EXISTS usuario_bloqueado_reserva;
delimiter //
CREATE TRIGGER usuario_bloqueado_reserva BEFORE insert ON reservas
       FOR EACH ROW    
       BEGIN
           declare s int;
           set @status_usr = (select status from usuario where CPF = NEW.usuario);
           IF @status_usr != 'ok' THEN
                    signal sqlstate '99999' set message_text = 'Erro: Usuario Bloqueado no Sistema';
           END IF;
       
       END; //
delimiter ;

-- ------------------------------------------------------------- --

use biblioteca;
drop TRIGGER IF EXISTS bloqueia_usuario;
delimiter //
CREATE TRIGGER bloqueia_usuario AFTER DELETE ON emprestimo
       FOR EACH ROW    
       BEGIN
           declare s int;
           -- OLD.id_livro , OLD.usuario , OLD.dataemprestimo, OLD.renova
           set @lvr_reservado = (select COUNT(*) from reservas where id_livro = OLD.id_livro);
           set @lvr_atrasado = (select timestampdiff(DAY, OLD.dataemprestimo , CURDATE()));
           
           IF @lvr_atrasado > 7 THEN
                IF @lvr_reservado > 0 THEN
                            UPDATE usuario set status = 'block' where CPF = OLD.usuario ;          
                            UPDATE usuario set diasbloqueado = 14 where CPF = OLD.usuario;
                else
                            UPDATE usuario set status = 'block' where CPF = OLD.usuario  ;         
                            UPDATE usuario set diasbloqueado = 7 where CPF = OLD.usuario;
                END IF;
            END IF;
       END; //
delimiter ;

-- ------------------------------------------------- --

use biblioteca;
drop TRIGGER IF EXISTS libera_reserva;
delimiter //
CREATE TRIGGER libera_reserva AFTER DELETE ON emprestimo
       FOR EACH ROW    
       BEGIN
           declare s int;
           -- OLD.id_livro , OLD.usuario , OLD.dataemprestimo, OLD.renova
           set @reserva_proritaria = (select usuario from reservas where OLD.id_livro order by data limit 1);

           IF @reserva_proritaria is NOT NULL THEN
                UPDATE reservas set status = 'Retirar' where usuario = @reserva_proritaria and id_livro = OLD.id_livro;
                UPDATE reservas set data = CURDATE() where usuario = @reserva_proritaria and id_livro = OLD.id_livro;
           END IF;

       END; //
delimiter ;

-- ------------------------------------------------------ --

use biblioteca;
drop TRIGGER IF EXISTS libera_usuario;
delimiter //
CREATE TRIGGER libera_usuario BEFORE UPDATE ON usuario
       FOR EACH ROW    
       BEGIN
           declare s int;
           -- OLD.id_livro , OLD.usuario , OLD.dataemprestimo, OLD.renova
           set @qts_livro = (select COUNT(*) from emprestimo where usuario = NEW.CPF);

           IF NEW.diasbloqueado = 0 THEN       
             signal sqlstate '99999' set message_text = 'usuario desbloqueado';      
                -- UPDATE usuario set status = 'ok' where CPF = NEW.CPF;
           END IF;

       END; //
delimiter ;
