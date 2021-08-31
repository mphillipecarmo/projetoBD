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