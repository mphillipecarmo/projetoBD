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