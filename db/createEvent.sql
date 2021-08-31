use biblioteca;
delimiter |
drop event IF EXISTS atualiza_status_aluno;
CREATE EVENT atualiza_status_aluno
    ON SCHEDULE
      EVERY 5 SECOND -- 1 DAY , somente usando para teste um tempo menor
    DO
      BEGIN
        
        DECLARE v INTEGER;
        -- atualiza quantos dias o usuario esta bloqueado
        UPDATE usuario usr inner join (SELECT CPF from usuario where diasbloqueado > 0) atr on usr.CPF = atr.CPF set diasbloqueado = diasbloqueado - 1;
         -- desbloqueia o usuario apos passar o periodo de suspensao
        UPDATE usuario usr inner join (SELECT CPF from usuario where diasbloqueado = 0) atr on usr.CPF = atr.CPF set status = 'ok';
        -- atualiza se o usuario esta bloqueado por atraso
        UPDATE usuario usr inner join (SELECT usuario from emprestimo where timestampdiff(DAY, dataemprestimo , CURDATE()) > 7) atr on usr.CPF = atr.usuario set status = 'block';        
        -- Cancela a reserva apos 2 dias
        UPDATE reservas res inner join (SELECT usuario from reserva where status = 'Retirar' and timestampdiff(DAY, data , CURDATE()) > 2) atr on res.usuario = atr.usuario set status = 'cancel';







    END |

delimiter ;