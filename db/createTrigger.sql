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