use biblioteca;
delimiter |
drop event IF EXISTS atualiza_status_aluno;
CREATE EVENT atualiza_status_aluno
    ON SCHEDULE
      EVERY 5 SECOND -- 1 DAY , somente usando para teste um tempo menor
    DO
      BEGIN
        
        DECLARE v INTEGER;
        UPDATE usuario usr inner join (SELECT CPF from usuario where diasbloqueado > 0) atr on usr.CPF = atr.CPF set diasbloqueado = diasbloqueado - 1;
        UPDATE usuario usr inner join (SELECT usuario from emprestimo where timestampdiff(DAY, dataemprestimo , CURDATE()) > 7) atr on usr.CPF = atr.usuario set status = 'block';        

        -- UPDATE usuario set diasbloqueado = diasbloqueado - 1;






    END |

delimiter ;