Use StreamingDB
Go
--Esse arquivo SQL, é destinado apenas para realizar consultas que para desenvolver gráficos de negócios no POWER BI

--1) Receita por plataforma 
Select P.NomePlataforma, Sum(A.ValorAssinatura) As Receita
From ClientesAssinaturas CS
Inner Join Assinaturas A On CS.IdAssinatura = A.IdAssinatura
Inner Join Plataformas P On A.IdPlataforma = P.IdPlataforma
Group By P.NomePlataforma
Go --O go Só Funciona aqui no SQL SERVER, Na hora de importar para o power bi tiramos do código

--2) Assinaturas por mês 
Select 
    Year(DataAssinatura) As Ano,
    Month(DataAssinatura) As Mes,
    Count(*) As TotalAssinaturas
From ClientesAssinaturas
Group By Year(DataAssinatura), Month(DataAssinatura)
Go

--3) Distribuição de forma de pagamento

Select FormaPagamento, Count(*) As Total
From Clientes
Group By FormaPagamento
Go

--4) Nota média das séries por gênero 

Select G.NomeGenero, Avg(S.NotaImdb) As NotaMedia
From Generos G
Inner Join SeriesGeneros SG On G.IdGenero = SG.IdGenero
Inner Join Series S On SG.IdSerie = S.IdSerie
Group By G.NomeGenero
Order By NotaMedia Desc
Go
