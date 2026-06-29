Create Database StreamingDB
Go

Use streamingDB
Go				--Criação Do banco de dados SeriesDB--


--Criação das Tabelas--
Create Table Plataformas
(IdPlataforma Int Primary Key Identity (1,1),
NomePlataforma VarChar(50) Not Null Unique --Unique não permita que exista duas plataformas com o mesmo nome--
)
Go
Create Table Series (
IdSerie Int Primary Key Identity (1,1),
TituloSerie VarChar (75) Not Null Unique, 
DataLancamento Date Not Null Check (DataLancamento >= '1940-01-01'),
NotaImdb Decimal (3,1) Check (NotaImdb Between 0.0 and 10.0),
IdPlataforma Int Not Null
)
Go
Create Table Episodios(
IdEpisodio Int Primary Key Identity (1,1),
NumeroEpisodio Int Not Null,
NumeroTemporada Int Not Null,
TituloEpisodio VarChar (50) Not Null,
DuracaoEpisodio Int Not Null Check (DuracaoEpisodio > 0),
IdSerie Int Not Null 
)
Go
--Usando Alter Table para ligar fazer as ligaçções por meio de foreign Key--

Alter Table Series
Add Constraint Fk_Serie_Plataformas_IdPlataforma
Foreign Key (IdPlataforma)
References Plataformas (IdPlataforma)
Go

Alter Table Episodios
Add Constraint Fk_Episodios_Series_IdSerie
Foreign Key (IdSerie)
References Series (IdSerie)
Go

--Aprofundando modelagem do banco SeriesDB--

Create Table Generos(
IdGenero Int Primary Key Identity(1,1),
NomeGenero VarChar(20) Not Null Unique
)
Go
--Criando a primeira tabela de relacionamento SeriesGeneros--
Create Table SeriesGeneros (
IdGenero Int Not Null,
IdSerie Int Not Null,
Primary Key (IdGenero, IdSerie)
)
Go

--Fazendo a ligação das tabelas com FKs--
Alter Table SeriesGeneros
Add Constraint FK_SeriesGeneros_Series
Foreign Key (IdSerie)
References Series (IdSerie)
Go

Alter Table SeriesGeneros
Add Constraint FK_SeriesGeneros_Generos
Foreign Key (IdGenero)
References Generos (IdGenero)
Go

--Iniciando a criação da tabela Filmes--
Create Table Filmes (
IdFilme Int Primary Key Identity(1,1),
TituloFilme VarChar (50) Not Null Unique ,
DataLancamento Date Not Null Check (DataLancamento >= '1940-01-01'), --Só permite cadastrar filmes lançados após 1940
NotaImdb Decimal (3,1) Not Null Check (NotaImdb Between 0.0 And 10.0), --Só permite Notas dos filmes que fiquem entre 0.0 e 10.0
IdPlataforma Int Not Null
)
Go
--Adicionando a Fk em Filmes vindo de plataforma--

Alter Table Filmes
Add Constraint Fk_Filmes_Plataformas_IdPlataforma Foreign Key (IdPlataforma)
References Plataformas (IdPlataforma)
Go

--Criando a tabela de ligação FilmesGeneros representando relação N para N--
Create Table FilmesGeneros 
(
IdFilme Int Not Null,
IdGenero Int Not Null,
Primary Key (IdFilme, IdGenero)
)
Go

--Fazendo ligação da tabela FilmesGeneros com FKs--
Alter Table FilmesGeneros
Add Constraint Fk_FilmesGeneros_Filmes_IdFilme Foreign Key (IdFilme)
References Filmes (IdFilme)
Go

Alter Table FilmesGeneros
Add Constraint Fk_FilmesGeneros_Generos_IdGenero Foreign Key (IdGenero)
References Generos (IdGenero)
Go

--Criando a tabela Assinaturas--

Create Table Assinaturas (
IdAssinatura Int Primary Key Identity (1,1),
TipoAssinatura VarChar(50) Not Null,
ValorAssinatura Decimal(6,2) Not Null, Check (ValorAssinatura > 00.00), --Só Permite inserir valores acima
QualidadeAssinatura VarChar (10) Not Null, Check (QualidadeAssinatura In ('4K', 'HD', 'FULL HD')), --Só permite inserir essas três qualidades
QuantidadeTela TinyInt Not Null, Check (QuantidadeTela Between 1 And 5),
CobrancaAssinatura VarChar(10) Not Null Check (CobrancaAssinatura In('Mensal', 'Trimestral', 'Anual')), --Só permite inserir essas três cobranças
IdPlataforma Int Not Null,
Unique (TipoAssinatura, IdPlataforma) --Não permite que a mesma plataforma tenha a mesma assinatura
)

--Adicionando fk em Assinaturas
Alter Table Assinaturas
Add Constraint Fk_Assinaturas_Plataformas_IdPlataforma Foreign Key (IdPlataforma)
References Plataformas (IdPlataforma)
