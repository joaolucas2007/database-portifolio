Use StreamingDB
Go

--Inserindo dados na tabela Plataforma

Insert Into Plataformas (NomePlataforma)
Values
('Netflix'),
('Disney+'),
('Amazon Prime Video'),
('Paramount+')
Go

-- Inserindo dados na tabela generos

Insert Into Generos (NomeGenero)
Values
('Drama'),
('Comédia'),
('Ação'),
('Suspense'),
('Terror'),
('Fantasia'),
('Ficção Científica'),
('Documentário'),
('Crime'),
('Romance'),
('Mistério'),
('Aventura')
Go

-- Inserindo dados na tabela Series

Insert Into Series
(TituloSerie, DataLancamento, NotaImdb, IdPlataforma)
Values
('Breaking Bad','2008-01-20',9.5,1),
('The Mandalorian','2019-11-12',8.6,2),
('The Boys','2019-07-26',8.7,3),
('Yellowstone','2018-06-20',8.7,4),
('Stranger Things','2016-07-15',8.7,1),
('Dark','2017-12-01',8.7,1),
('The office','2005-03-24',9.0,1),
('Friends','1994-09-22',8.9,1),
('Narcos','2015-08-28',8.7,1),
('Wandinha','2022-11-23',8.1,1),
('The Witcher','2019-12-20',8.0,1),
('Loki','2021-06-09',8.2,2),
('Sherlock','2010-07-25',9.1,4),
('Game of Thrones','2011-04-17',9.2,4),
('House of the Dragon','2022-08-21',8.4,4),
('The Last of Us','2023-01-15',8.8,4),
('Peaky Blinders','2013-09-12',8.8,4)
Go

--Inserindo dados na tabela episódios--
Insert Into Episodios
(NumeroEpisodio, NumeroTemporada, TituloEpisodio, DuracaoEpisodio, IdSerie)
Values

(1,1,'Pilot',58,1),
(2,1,'Cat''s in the Bag...',48,1),

(1,1,'Chapter 1: The Mandalorian',39,2),
(2,1,'Chapter 2: The Child',31,2),
(3,1,'Chapter 3: The Sin',37,2),

(1,1,'The Name of the Game',60,3),
(2,1,'Cherry',61,3),
(3,1,'Get Some',57,3),

(1,1,'Daybreak',92,4),
(2,1,'Kill the Messenger',47,4),
(3,1,'No Good Horses',44,4),

(1,1,'The Vanishing of Will Byers',49,5),
(2,1,'The Weirdo on Maple Street',55,5),

(1,1,'Secrets',57,6),
(2,1,'Lies',44,6),

(1,1,'Pilot',23,7),
(2,1,'Diversity Day',22,7),

(1,1,'The One Where Monica Gets a Roommate',22,8),
(2,1,'The One with the Sonogram at the End',22,8),

(1,1,'Descenso',49,9),
(2,1,'The Sword of Simón Bolívar',51,9),

(1,1,'Wednesday''s Child Is Full of Woe',50,10),
(2,1,'Woe Is the Loneliest Number',47,10),

(1,1,'The End''s Beginning',61,11),
(2,1,'Four Marks',60,11),

(1,1,'Glorious Purpose',52,12),
(2,1,'The Variant',54,12),

(1,1,'A Study in Pink',88,13),
(2,1,'The Blind Banker',89,13),

(1,1,'Winter Is Coming',62,14),
(2,1,'The Kingsroad',56,14),

(1,1,'The Heirs of the Dragon',66,15),
(2,1,'The Rogue Prince',54,15),

(1,1,'When You''re Lost in the Darkness',81,16),
(2,1,'Infected',53,16),

(1,1,'Episode 1',58,17),
(2,1,'Episode 2',58,17);
Go

--Iserindo dados na tabela de relação entre Generos e Series
Insert Into SeriesGeneros
(IdGenero, IdSerie)
Values

-- Breaking Bad
(9,1),
(1,1),

-- The Mandalorian
(7,2),
(12,2),

-- The Boys
(3,3),
(1,3),

-- Yellowstone
(1,4),
(12,4),

-- Stranger Things
(7,5),
(11,5),

-- Dark
(7,6),
(4,6),

-- The Office
(2,7),

-- Friends
(2,8),
(10,8),

-- Narcos
(9,9),
(1,9),

-- Wandinha
(6,10),
(11,10),

-- The Witcher
(6,11),
(12,11),

-- Loki
(7,12),
(12,12),

-- Sherlock
(9,13),
(11,13),

-- Game of Thrones
(6,14),
(12,14),

-- House of the Dragon
(6,15),
(1,15),

-- The Last of Us
(7,16),
(1,16),

-- Peaky Blinders
(9,17),
(1,17)
Go

--Exemplo de atualização em tabela ja cadastrada--
Select TituloSerie, NotaImdb From Series
Go		--Sempre fazer um Select antes pppara garantir que será atualizado a série certa--

Update Series
Set NotaImdb = 8.8
Where TituloSerie = 'The Boys' --Where para filtrar o que será atualizado
Go


--Fazendo um delete na última série cadastrada--
Select IdSerie, TituloSerie From Series
Order By IdSerie Asc		--Sempre usar select para garantir que a série correta será deletada
Go

Delete From Episodios
Where IdSerie = 17		-- Primeiro removendo os registros da tabela filha para evitar erro de chave estrangeira--
Go

Delete From SeriesGeneros
Where IdSerie = 17		--Novamente removendo primeiro da tabela filha para depois remover da tabela pai

Delete From Series
Where IdSerie = 17
Go


--inseirindo dados na tabel assinatura

Insert Into Assinaturas (TipoAssinatura, ValorAssinatura, QualidadeAssinatura, QuantidadeTela, CobrancaAssinatura, IdPlataforma)
Values	('Padrão', 39.90, 'FULL HD',2,'Mensal',1),
		('Premium',59.90,'4K',4,'Mensal',1),
		('Standard',27.90,'HD',2,'Mensal',2),
		('Premium',43.90,'4K',4,'Mensal',2),
		('Prime',19.90,'FULL HD',3,'Mensal',3),
		('Premium',34.90,'4K',4,'Mensal',4);
Go

--Fazendo uma população de dados maior no Banco tornando consultas mais realistas

--adicionando mais plataformas 
Insert Into Plataformas (NomePlataforma)
Values ('Max'), ('Apple Tv+'), ('GloboPlay'), ('Star+')
Go
--Inserindo mais Series
Insert Into Series (TituloSerie, DataLancamento, NotaImdb, IdPlataforma)
Values ('Severance','2022-02-18',8.7,6),
('Ted Lasso','2020-08-14',8.8,6),
('The Bear','2022-06-23',8.5,8),
('The Penguin','2024-09-19',8.8,5),
('Chernobyl','2019-05-06',9.3,5),
('True Detective','2014-01-12',8.9,5),
('The Sopranos','1999-01-10',9.2,5),
('Ozark','2017-07-21',8.5,1),
('Black Mirror','2011-12-04',8.7,1),
('The Queen''s Gambit','2020-10-23',8.5,1);
Go

--Inserindo mais episodios

Insert Into Episodios
(NumeroEpisodio, NumeroTemporada, TituloEpisodio, DuracaoEpisodio, IdSerie)
Values

(1,1,'Good News About Hell',57,18),
(2,1,'Half Loop',56,18),
(3,1,'In Perpetuity',57,18),

(1,1,'Pilot',35,19),
(2,1,'Biscuits',30,19),
(3,1,'Trent Crimm',30,19),

(1,1,'System',45,20),
(2,1,'Hands',31,20),
(3,1,'Brigade',33,20),

(1,1,'After Hours',67,21),
(2,1,'Inside Man',58,21),

(1,1,'1:23:45',59,22),
(2,1,'Please Remain Calm',61,22),

(1,1,'The Long Bright Dark',58,23),
(2,1,'Seeing Things',56,23),

(1,1,'The Sopranos',60,24),
(2,1,'46 Long',52,24),

(1,1,'Sugarwood',60,25),
(2,1,'Blue Cat',58,25),

(1,1,'The National Anthem',44,26),
(2,1,'Fifteen Million Merits',61,26),

(1,1,'Openings',56,27),
(2,1,'Exchanges',48,27);
Go


--Inserindo filmes
Insert Into Filmes
(TituloFilme, DataLancamento, NotaImdb, IdPlataforma)
Values

('Oppenheimer','2023-07-21',8.3,5),
('Duna','2021-10-22',8.0,5),
('Duna Parte 2','2024-03-01',8.5,5),
('Interestelar','2014-11-07',8.7,5),
('Batman','2022-03-04',7.8,5),

('Resgate','2020-04-24',6.8,1),
('Alerta Vermelho','2021-11-12',6.3,1),
('Não Olhe Para Cima','2021-12-24',7.2,1),

('Soul','2020-12-25',8.0,2),
('Divertida Mente 2','2024-06-14',7.8,2),

('Top Gun Maverick','2022-05-27',8.2,4),
('Missão Impossível Acerto de Contas','2023-07-12',7.7,4);
Go

--Inserindo dados na tabela de relacionamento FilmeGeneros
Insert Into FilmesGeneros
(IdFilme, IdGenero)
Values

(1,1),
(1,8),

(2,7),
(2,12),

(3,7),
(3,12),

(4,7),
(4,1),

(5,3),

(6,3),
(6,12),

(7,3),
(7,2),

(8,2),
(8,1),

(9,2),
(9,6),

(10,2),
(10,6),

(11,3),
(11,12),

(12,3),
(12,4);
Go


--Inserindo dados na tabela de relacionamentos SeriesGeneros
Insert Into SeriesGeneros
(IdGenero, IdSerie)
Values

(7,18),
(4,18),

(2,19),
(1,19),

(1,20),
(2,20),

(9,21),
(1,21),

(8,22),
(1,22),

(9,23),
(11,23),

(9,24),
(1,24),

(9,25),
(1,25),

(7,26),
(4,26),

(1,27),
(8,27);
Go