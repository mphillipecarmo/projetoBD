
use biblioteca;
insert into usuario values
('Graciana Liberato Neres','63362774024' , '3199999999','Graciana@gmail.com', 'Ok');
insert into aluno values
('63362774024' , '20171012');

insert into usuario values
('Kieza Caneira Botelho','54159739075' , '3199999999','Kieza@gmail.com', 'Ok');
insert into aluno values
('54159739075' , '20171013');

insert into usuario values
('Kyan Valcácer Parafita','74293506071' , '3199999999','Kyan@gmail.com', 'Ok');
insert into aluno values
('74293506071' , '20180901');

insert into usuario values
('Marcelino Madeira Mortágua','07724120064' , '3199999999','Marcelino@gmail.com', 'Ok');
insert into aluno values
('07724120064' , '20180915');

insert into usuario values
('Girisha Lopes Amorim','01296396053' , '3199999999','Girisha@gmail.com', 'Ok');
insert into aluno values
('01296396053' , '20192425');

insert into usuario values
('Tomás Sequeira Castanheda','50356080005' , '3199999999','Castanheda@gmail.com', 'Ok');
insert into funcionario values
('50356080005' , 0);

insert into usuario values
('Suéli Lacerda Franca','18467297000' , '3199999999','Lacerda@gmail.com', 'Ok');
insert into funcionario values
('18467297000' , 0);

insert into usuario values
('Dominique Meira Távora','12304365027' , '3199999999','Dominique@gmail.com', 'Ok');
insert into funcionario values
('12304365027' , 0);

insert into usuario values
('Marcus Gouveia Barrocas','58731826040' , '3199999999','Gouveia@gmail.com', 'Ok');
insert into funcionario values
('58731826040' , 0);

insert into usuario values
('Emily Cerqueira Taveiros','49453433063' , '3199999999','Emily@gmail.com', 'Ok');
insert into funcionario values
('49453433063' , 0);

-- ----------------------------------------------------------------------------------------- --
insert into livro values
(0,'1984','George Orwell' , 'Ed_Phill',1,1,
 'Aventura','aprisionado na engrenagem totalitária de uma sociedade completamente dominada pelo Estado',1949,10);


insert into livro values
(0,'O Conto da Aia','Margaret Atwood' , 'Hulu',1,1,
 'Romance','O Conto da Aia é um romance distópico que narra os acontecimentos da República de Gileade',1980,3);


insert into livro values
(0,'Orgulho e Preconceito','Jane Austen' , 'MartinClaret',1,1,
 'Romance','Quando Elizabeth Bennett conhece o senhor Darcy, de início eles se odeiam. Mas, através de várias aventuras, cada um vai descobrir o bom carácter do outro',1813,1);


insert into livro values
(0,'stewart - calculo 2','James Stewart' , 'Ed_Phill',2,8,
 'Engenharias','Dor e sofrimento',2017,5);


insert into livro values
(0,'Massacre da progamação web','Mendes e Carmos' , 'romeOfice',1,1,
 'Terror','Duas pessoas, sem nenhuma capacitação em progamação web, se encontram frente a 2 tps que usam essa tecnologia, o que será deles???',2021,2);

insert into livro values
(0,'Fisica 2','David Halliday' , 'Ed_Phill',1,1,
 'Engenharias','Gravitação, Ondas e Termodinâmica',2017,1);

insert into livro values
(0,'O Pequeno Príncipe','Antoine de Saint-Exupéry' , 'Bom_livro',1,1,
 'Fantasia','O príncipe da história vive em um pequeno planeta, onde cuida de um rosa. Decide visitar outros planetas, aprende o valor do amor e da criatividade.',2017,1);

insert into livro values
(0,'Dom Casmurro','Machado de Assis' , 'Ed_Phill',1,1,
 'Romance','história se centra na vida de Bento Santiago, que ganhou o apelido de Casmurro. Bento se apaixona e casa com uma mulher pobre chamada Capitu',2000,1);

-- --------------------------------------------------------------------------------------------------------- --

insert into emprestimo values
(1, '12304365027', '2021-01-16',0);
insert into emprestimo values

(1, '63362774024', '2021-08-25',0);
insert into emprestimo values
(2, '63362774024', '2021-08-25',0);
insert into emprestimo values
(3, '63362774024', '2021-08-25',0);
insert into emprestimo values
(4, '63362774024', '2021-08-25',0);
insert into emprestimo values
(5, '63362774024', '2021-08-25',0);

insert into emprestimo values
(1, '54159739075', '2021-08-28',0);
insert into emprestimo values
(5, '54159739075', '2021-08-28',0);


-- --------------------------------------------------------------------------------- --

insert into reservas values
('74293506071' , 3, '2021-08-28','wait');
insert into reservas values
('74293506071' , 5, '2021-08-28','wait');

insert into reservas values
('07724120064' , 6, '2021-08-28','wait');
insert into reservas values
('18467297000' , 7, '2021-08-28','wait');
insert into reservas values
('01296396053' , 8, '2021-08-28','wait');
