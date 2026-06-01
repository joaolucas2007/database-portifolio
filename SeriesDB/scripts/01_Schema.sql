Create Database SeriesDB
Go

Use SeriesDB
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
NomeGenero VarChar(20) Not Null
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