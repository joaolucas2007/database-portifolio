Use StreamingDB
Go

-- Cosultas somente relacionadas a Clientes e o que consumiram

-- Ranking de plataformas por nota média dos clientes

--Usando CTE
-- Ranking de plataformas por nota média dos clientes

With NotaMediaPlataforma As (
    Select P.NomePlataforma, CS.NotaSerieCliente As Nota
    From Series S
    Inner Join Plataformas P On S.IdPlataforma = P.IdPlataforma
    Inner Join ClientesSeries CS On CS.IdSerie = S.IdSerie

    Union All

    Select P.NomePlataforma, CF.NotaFilmeCliente As Nota
    From Filmes F
    Inner Join Plataformas P On F.IdPlataforma = P.IdPlataforma
    Inner Join ClientesFilmes CF On CF.IdFilme = F.IdFilme
)
Select
    NomePlataforma,
    Convert(Decimal(3,1), Avg(Nota)) As MediaPlataforma,
    Dense_Rank() Over (Order By Avg(Nota) Desc) As RankingPlataforma
From NotaMediaPlataforma
Group By NomePlataforma
Order By RankingPlataforma
Go

-- Ranking de gêneros por nota média dos clientes

With NotaMediaGenero As (
    Select G.NomeGenero, CS.NotaSerieCliente As Nota
    From Series S
    Inner Join ClientesSeries CS On S.IdSerie = CS.IdSerie
    Inner Join SeriesGeneros SG On S.IdSerie = SG.IdSerie
    Inner Join Generos G On G.IdGenero = SG.IdGenero

    Union All

   Select G.NomeGenero, CF.NotaFilmeCliente As Nota
    From Filmes F
    Inner Join ClientesFilmes CF On F.IdFilme = CF.iDFilme
    Inner Join FilmesGeneros FG On F.IdFilme = FG.IdFilme
    Inner Join Generos G On G.IdGenero = FG.IdGenero
)
Select NomeGenero, 
Convert(Decimal(3,1), Avg(Nota))  As MediaGenero,
Dense_Rank () Over ( Order By Avg(Nota) Desc) As RankingGenero
From NotaMediaGenero
Group By NomeGenero
Order By RankingGenero
Go


-- Mostrando qual plataforma foi mais consumida
With PlataformaMaisConsumida As (
    Select P.NomePlataforma, CS.IdClienteSerie As TotalAssistido
    From Series S
    Inner Join Plataformas P On S.IdPlataforma = P.IdPlataforma
    Inner Join ClientesSeries CS On CS.IdSerie = S.IdSerie

    Union All

    Select P.NomePlataforma, CF.IdClienteFilme As TotalAssistido
    From Filmes F
    Inner Join Plataformas P On F.IdPlataforma = P.IdPlataforma
    Inner Join ClientesFilmes CF On CF.IdFilme = F.IdFilme
)
Select  NomePlataforma, Count(TotalAssistido) As TotalVisualizacao,
Dense_Rank() Over(Order By Count(TotalAssistido) Desc) As RankingPlataforma
From PlataformaMaisConsumida
Group By NomePlataforma
Order By RankingPlataforma Desc
Go
--Plataformas que mais geraram renda
Select P.NomePlataforma, 
Sum(A.ValorAssinatura) As TotalganhoPlataforma, 
Dense_Rank() Over(Order By Sum(A.valorAssinatura) Desc) As RankingPlataforma
From Plataformas P
Inner Join Assinaturas A
On A.IdPlataforma = P.IdPlataforma
Inner Join ClientesAssinaturas CS
On A.IdAssinatura = CS.IdAssinatura
Group By P.IdPlataforma, P.NomePlataforma
Go