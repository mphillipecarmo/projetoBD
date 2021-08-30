CREATE OR REPLACE TRIGGER usr_atraso BEFORE INSERT ON emprestimo
FOR EACH ROW 
DECLARE 
    @status = SELECT status FROM ALUNO WHERE cpf = NEW.usuario
BEGIN
    IF SELECT status FROM ALUNO WHERE cpf = usuario == 'ok'
    then 

END;
