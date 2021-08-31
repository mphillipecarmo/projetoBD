use biblioteca;
drop TRIGGER IF EXISTS cancela_reserva;
delimiter //
CREATE TRIGGER cancela_reserva AFTER UPDATE ON reservas
       FOR EACH ROW    
       BEGIN
           declare s int;
           -- OLD.id_livro , OLD.usuario , OLD.dataemprestimo, OLD.renova

           IF NEW.status = 'cancel' THEN       
             DELETE from reservas where usuario = NEW.usuario;
                -- UPDATE usuario set status = 'ok' where CPF = NEW.CPF;
           END IF;

       END; //
delimiter ;