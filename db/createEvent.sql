use biblioteca;
delimiter |

CREATE EVENT atualiza_status_aluno
    ON SCHEDULE
      EVERY 5 SECOND
    DO
      BEGIN
        DECLARE v INTEGER;
        set @atrazados=(SELECT usuario from emprestimo where timestampdiff(DAY, dataemprestimo , CURDATE()) < 7 limit 1) ;

        UPDATE usuario set status = 'ok' where CPF = from (SELECT usuario from emprestimo where timestampdiff(DAY, dataemprestimo , CURDATE()) > 7); 
    
        WHILE @atrazados IS NOT NULL DO
          UPDATE usuario set status = 'ok' where CPF = from (SELECT usuario from emprestimo where timestampdiff(DAY, dataemprestimo , CURDATE()) > 7); 

          SET @atrazados = (SELECT usuario from emprestimo where timestampdiff(DAY, dataemprestimo , CURDATE()) < 7 limit 1) ;;
        END WHILE;
    END |

delimiter ;