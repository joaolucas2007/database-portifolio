Use StreamingDB
Go
--Começando a usar Porcedures para otimização de pesquisar e relatórios

--Estrutura básica de um Procedure
/*
Create Procedure
As
Begin
Comando sql
End
*/
 
CREATE PROCEDURE RelatorioAssinaturasPorMes -- Nome do Procedure
    @Ano INT -- Declaração do que o usuário vai enviar nesse contexto o ano
AS
BEGIN -- ínicio do procedure
-- Código SQL
    SELECT 
        YEAR(DataAssinatura) AS Ano, -- Selecionando o ano da data assinatura
        MONTH(DataAssinatura) AS Mes, -- Selecionando o mês 
        COUNT(*) AS TotalAssinaturas -- Contando quantas assinaturas tem 
    FROM ClientesAssinaturas -- da tabela assinatura
    WHERE YEAR(DataAssinatura) = @Ano -- agora usamos o ano para filtrar!
    GROUP BY YEAR(DataAssinatura), MONTH(DataAssinatura); -- agrupando ano e mês
END; -- finalizando o procedure
GO
-- após executar ele está salvo no nosso Banco de dados
EXEC RelatorioAssinaturasPorMes @Ano = 2026; -- executamos filtrando por ano que é o parâmetro la encima

-- Criando um procedure
Create Procedure ConsultarClienteFormaPagamamento
@Pagamento VarChar(20) -- Criando a váriavel que vai definir o procedure
As
Begin
Select * From Clientes -- Assim trazemos todos os dados dos clientes que o exec está filtrando 
Where FormaPagamento = @Pagamento -- Aqui a consulta será feita de acordo com o que o cliente digitar na forma de paagmento
End
Go
Exec ConsultarClienteFormaPagamamento @Pagamento =  'Pix' -- Pode ser no pix Somente os dados dos clientes que pagam no pix
Exec ConsultarClienteFormaPagamamento @Pagamento =  'Boleto' -- Boleto mesma coisa com boleto



Create Procedure FiltrarSeriesPorPlataformaENota
@PlataformaId Int,
@NotaMinima Decimal(3,1)
As
Begin
Select TituloSerie, NotaImdb From Series
Where IdPlataforma = @PlataformaId and NotaImdb >= @NotaMinima
End
Go
Exec FiltrarSeriesPorPlataformaENota 
@PlataformaId = 1, -- Dessa forma filtramos por plataforma e pela nota da série
@NotaMinima = 4.7

--O Parâmetro com Valor Padrão (Default)
--Usando um valor padrão caso o usuário não digite um valor
Create Procedure ConsultarFilmesPorPlataformaPadrao
@IdPlataforma Int = 1 -- Assim o valor padrão da plataforma é 1
As
Begin
Select TituloFilme, IdPlataforma From Filmes
Where IdPlataforma = @IdPlataforma
End
Go
Exec ConsultarFilmesPorPlataformaPadrao -- Nesse caso não precisamos colocar nenhum valor apenas executar vai trazer todos os filmes da plataforma 1
Exec ConsultarFilmesPorPlataformaPadrao @IdPlataforma = 2 -- também podemos escolher qual plataforma queremos

--Lógica Condicional
-- Agora usando lógica condicional, se o usuário digitar uma plataforma trazemos as séries dessa plataforma, se não digitar nada trazemos todas as séries
Create Procedure RelatorioSeriesFlexivel
@PlataformaId Int = Null
As
Begin
Select TituloSerie From Series
Where (@PlataformaId Is Null Or IdPlataforma = @PlataformaId)
End
Go
Exec RelatorioSeriesFlexivel -- Se não declararmos nenhum parâmetro traz todas as séries do Banco de Dados
Exec RelatorioSeriesFlexivel @PlataformaId = 2 -- Também podemos declarar da onde queremos as séries

--Procedure que Insere Dados
Create Procedure CadastrarPlataforma
@NovaPlataforma VarChar(30)
As
Begin
-- Usandoo Begin Try e End Try para respeitar a regra do unique de nome plataforma
    Begin Try 
    Insert Into Plataformas (NomePlataforma)
    Values (@NovaPlataforma)
    End Try

    Begin Catch -- Se der erro mandamos uma mensagem personalizada
    Throw 50001, 'Essa Plataforma já está cadastrada',1
    End Catch
End
    Exec CadastrarPlataforma @NovaPlataforma =  'Netflix' -- Testando a medida de segurança
    Exec CadastrarPlataforma @NovaPlataforma = 'Hbo' -- Inserindo uma plataforma nova

Select IdPlataforma, nomePlataforma From Plataformas -- Testando para ver se inseriua nova plataforma

-- Desafio 1: Procedure com Múltiplos JOINs e Agrupamento (Média Complexidade)

Create Procedure RelatorioDadosDAserie -- Criando um relatório completo da série pesquisada pelo usuário
@NomeSerie VarChar(75) As
Begin
        Select P.NomePlataforma, S.TituloSerie, Count(E.IdEpisodio) As QuantidadeEpisodios,Sum(E.DuracaoEpisodio) As TotalTempoSerie
        From Series S
        Inner Join Plataformas P
        On S.IdPlataforma = P.IdPlataforma
        Inner Join Episodios E
        On S.IdSerie = e.IdSerie
        Where S.TituloSerie = @NomeSerie
        Group By P.NomePlataforma, S.TituloSerie
End
Exec RelatorioDadosDAserie @NomeSerie = 'Wandinha' -- Exemplo 1
Exec RelatorioDadosDAserie @NomeSerie = 'Breaking Bad' -- Exemplo 2



--Desafio 2: Lógica Condicional Avançada com Subquery
-- Usando if else 
Create Procedure RelatorioFilmesTop
@CompararPlataforma Bit = 0 -- Bit aceita 0 ou 1 o valor por padrão é 0
As Begin
        If @CompararPlataforma = 0 -- Se valor for 0 vai trazer a média que de nota de todos os filmes cadastrados
        Begin
            Select TituloFilme, NotaImdb From Filmes
            Where NotaImdb > (Select Avg(NotaImdb) From Filmes)
        End
        Else
        Begin 
        Select F1.TituloFilme, F1.NotaImdb 
        From Filmes F1 -- se o valor for 1 traz a média dos fiomes da plataforma dele
        Where NotaImdb>(Select Avg(F2.NotaImdb) From Filmes F2 Where F1.IdPlataforma = F2.IdPlataforma)
        End
    End
Go
Exec RelatorioFilmesTop @CompararPlataforma = 1 -- Trazendo filmes com a nota maior do que a média da plataforma dele
Exec RelatorioFilmesTop @CompararPlataforma = 0 -- Trazendo Fimes com a média maior que a média de todos os filmes cadastrados

--Desafio 3: Windows Function
Create Procedure RelatorioFaturamentoAcomulado
As
Begin
    With FaturamentoPorMes As (
    Select Year(DataAssinatura) As Ano,
    Month(DataAssinatura) As Mes,
    Sum(A.ValorAssinatura) As TotalMes
    From Assinaturas A
    Inner Join ClientesAssinaturas CS
    On A.IdAssinatura = CS.IdAssinatura
    Group By Year(DataAssinatura), Month(DataAssinatura)
    )
    Select
    Ano, Mes, TotalMes,
    Sum(TotalMes) Over (Order By Ano, Mes) As FaturamentoAcomulado
    From FaturamentoPorMes
End
Go
Exec RelatorioFaturamentoAcomulado