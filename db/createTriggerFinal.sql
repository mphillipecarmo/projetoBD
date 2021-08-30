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
                    signal sqlstate '99999' set message_text = 'Erro: Usuario já reservou este livro';
           END IF;
       
       END; //
delimiter ;