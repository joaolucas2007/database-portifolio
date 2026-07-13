Use StreamingDB
Go

-- Agora vamos pesquisar relatórios de possíveis situações de negócios --


--Usando Join para Criar a relação--

/* Cenário: O desenvolvedor front-end precisa dos dados para montar
os cards da tela inicial do aplicativo.*/

/* Objetivo:Relação completa de episódios com suas respectivas séries e plataformas de exibição. */

Select P.NomePlataforma, S.TituloSerie, S.NotaImdb,
E.NumeroTemporada, E.NumeroEpisodio, E.TituloEpisodio
From Plataformas P
Inner Join Series S
On P.IdPlataforma = S.IdPlataforma
Inner Join Episodios E
On E.IdSerie = S.IdSerie
Order By P.NomePlataforma, S.TituloSerie Desc
Go


--Prática de filtros e ordenações--

/*Cenário: A equipe de marketing da plataforma quer fazer uma campanha
de destaque nas redes sociais usando apenas as produções que são unanimidade
entre o público,ou seja, as mais bem avaliadas.*/

/*Objetivo: Escreva uma consulta que entregue as séries com as maiores notas em suas datas de lançamentos.*/

Select TituloSerie, DataLancamento, NotaImdb
From Series
Where NotaImdb >= 8.7
Order By NotaImdb Desc
Go


--Funções de Agregação e Agrupamento--

/*Cenário: A equipe de infraestrutura e servidores da plataforma precisa saber
qual é o tempo total de vídeo que eles têm armazenado para cada série.
Isso vai ajudar o time a calcular os custos de banda de internet
e armazenamento para o próximo mês.*/

/*Objetivo: Escrever uma consulta que me entregue o título da série, e a duração de seus episódios somados*/

Select S.TituloSerie,
Sum(E.DuracaoEpisodio) As TempoTotal
From Episodios E
Inner Join Series S
On E.IdSerie = S.IdSerie
Group By S.TituloSerie
Order By TempoTotal Desc
Go


--Operadores de texto--

/*Cenário: Um usuário abriu um chamado no suporte reclamando que a barra de busca do aplicativo não está trazendo os episódios que ele quer.
Ele tentou digitar apenas o começo de uma palavra porque não lembrava o nome inteiro do episódio.
O time de qualidade precisa testar como o banco se comporta buscando palavras incompletas.*/

/*Objetivo: Escrever uma consulta que retorne o nome da série e o nome do episódio desejado, filtrando com Like e Or*/

Select S.TituloSerie, E.TituloEpisodio
From Episodios E
Inner Join Series S
On S.IdSerie = E.IdSerie
Where E.TituloEpisodio Like 'Chapter%'
    Or E.TituloEpisodio Like '%The%'
Go


/*Cenário: O gerente de conteúdo quer visualizar rapidamente quantas séries existem em cada plataforma para avaliar o tamanho do catálogo.*/

/*Objetivo: Mostrar a quantidade de séries por plataforma. */

Select P.NomePlataforma,
Count(S.IdSerie) As TotalSeries
From Plataformas P
Inner Join Series S
On P.IdPlataforma = S.IdPlataforma
Group By P.NomePlataforma
Go


/*Cenário: A equipe de conteúdo quer identificar séries com avaliação abaixo da média da empresa
para decidir quais produções precisam de mais investimento em divulgação.*/

/*Objetivo: Exibir séries com nota inferior a 8.0.*/

Select TituloSerie, NotaImdb
From Series
Where NotaImdb < 8.0
Go


/*Cenário: A equipe de servidores quer saber quais séries possuem mais episódios, pois costumam gerar mais consumo de armazenamento.*/

/*Objetivo: Mostrar a quantidade de episódios por série.*/

Select S.TituloSerie,
Count(E.IdEpisodio) As TotalEpisodios
From Episodios E
Inner Join Series S
On S.IdSerie = E.IdSerie
Group By S.TituloSerie
Order By TotalEpisodios Desc
Go


/*Cenário: O Product Manager quer identificar quais séries possuem episódios mais longos para entender padrões de consumo dos usuários.*/

/*Objetivo: Mostrar a duração média dos episódios por série.*/

Select S.TituloSerie,
Avg(E.DuracaoEpisodio) As MediaEpisodios --AVG, comando usado para fazer a média--
From Episodios E
Inner Join Series S
On S.IdSerie = E.IdSerie
Group By S.TituloSerie
Order By MediaEpisodios Desc
Go


/* Cenario: Equipe de conteúdo quer descobrir quais séries possuem mais de 5 episódios cadastrados.*/

/*Objetivo: Mostrar apenas séries com mais de 5 episódios.*/

Select S.TituloSerie,
Count(E.IdEpisodio) As TotalEpisodios
From Episodios E
Inner Join Series S
On S.IdSerie = E.IdSerie
Group By S.TituloSerie
Having Count(E.IdEpisodio) > 5 --Comando Having serve para filtrar assim como o Where, porém ele filtra após o agrupamento--
Go


/*Cenário: Equipe de qualidade quer identificar séries cuja duração total ultrapassa 300 minutos.*/

/*Objetivo: Mostrar apenas séries com mais de 300 minutos de conteúdo.*/

Select S.TituloSerie,
Sum(E.DuracaoEpisodio) As TempoTotalMinutos
From Series S
Inner Join Episodios E
On S.IdSerie = E.IdSerie
Group By S.TituloSerie
Having Sum(E.DuracaoEpisodio) > 300
Go


/* Cenário: Diretoria da plataforma quer descobrir quais plataformas possuem pelo menos 3 séries cadastradas.*/

/*Objetivo: Mostrar somente plataformas com 3 ou mais séries.*/

Select P.NomePlataforma,
Count(S.IdSerie) As TotalSeries
From Plataformas P
Inner Join Series S
On P.IdPlataforma = S.IdPlataforma
Group By P.NomePlataforma
Having Count(S.IdSerie) >= 3
Go


/*Cenário: Equipe de recomendações quer trabalhar apenas com séries que possuem nota média dos episódios acima de 45 minutos.*/

/*Objetivo: Listar séries cuja duração média dos episódios seja maior que 45.*/

Select S.TituloSerie,
Avg(E.DuracaoEpisodio) As MediaEpisodios
From Series S
Inner Join Episodios E
On S.IdSerie = E.IdSerie
Group By S.TituloSerie
Having Avg(E.DuracaoEpisodio) > 45
Go

/*Cenário: A equipe de conteúdo quer identificar quais gêneros possuem maior volume de séries cadastradas.
Isso ajudará a definir quais categorias merecem mais investimento e divulgação na plataforma.*/

/*Objetivo: Mostrar apenas os gêneros que possuem pelo menos 2 séries cadastradas.*/

Select G.NomeGenero, 
Count(SG.IdSerie) As TotalSerie
From SeriesGeneros SG
Inner Join Generos G
On G.IdGenero = SG.IdGenero
Group By G.NomeGenero
Having (Count(SG.IdSerie)) > 2
Order By TotalSerie Asc
Go


--Fazendo mais consultas agora com a tabela assinatura e a tabela filmes 
--Aprendendo novos conceitos

/*Cenário: O time de UX quer uma tela de "Busca Geral" onde o usuário digita um termo e o sistema traz tudo o que tem no catálogo, 
sejam filmes ou séries, com suas respectivas notas e plataformas.*/


/*Conceito Novo: UNION ALL — Une o resultado de duas consultas diferentes em uma única tabela virtual. 
Para funcionar, as duas consultas precisam ter a mesma quantidade de colunas e tipos de dados compatíveis.*/

Select 'Series' As Tipo, S.TituloSerie, S.NotaImdb, P.NomePlataforma
From Series S
Inner Join Plataformas P
On S.IdPlataforma = P.IdPlataforma

Union All  --Une os dados em uma unica Coluna Tipo nesse caso se é Filme ou Serie

Select 'Filmes' As Tipo, F.TituloFilme, F.NotaImdb, P.NomePlataforma
From Filmes F
Inner Join Plataformas P
On F.IdPlataforma = P.IdPlataforma
Go


/*Cenário: O gerente de parcerias quer saber se existem plataformas cadastradas no sistema 
que não possuem nenhum filme vinculado a elas,para entender
se o contrato expirou ou se houve erro de cadastro. */

/*Conceito Novo: LEFT JOIN e IS NULL — O LEFT JOIN traz todos os dados da tabela da esquerda (Plataformas),
mesmo se não houver correspondência na tabela da direita (Filmes). Quando não há correspondência, 
o SQL preenche os campos com NULL.
Filtrando por Where F.IdFilme Is Null, encontramos os "buracos".*/

Select P.NomePlataforma, F.TituloFilme
From Plataformas P
Left Join Filmes F
On P.IdPlataforma = f.IdPlataforma
Where F.IdFilme Is Null
Go

/*Cenário: O time de finanças quer um relatório classificando os planos de assinatura em faixas de 
preço: "Econômico" (até R$ 25), "Intermediário" (até R$ 45) e "Premium" (acima disso).*/

/*Conceito Novo: CASE WHEN — É o "IF/ELSE" (se/senão) do SQL. 
Permite criar colunas condicionais baseadas nos valores das linhas.*/

Select P.NomePlataforma, A.TipoAssinatura , A.ValorAssinatura,
Case 
    When ValorAssinatura <= 25.00 Then 'Econômico'
    When ValorAssinatura > 25.00 And ValorAssinatura <= 45.00 Then 'Intermediário'
    Else 'Premium'
End As CategoriaPreco
From Assinaturas A
Inner Join Plataformas P
On A.IdPlataforma = P.IdPlataforma
Order By P.NomePlataforma
Go

/*Cenário: A equipe de aquisição de conteúdo quer saber quantos títulos de Filmes
existem para cada gênero,mas só quer ver os gêneros que possuem filmes cadastrados.*/

/*O que estou exercitando: Relacionamento N para N juntando 3 tabelas
(Generos -> FilmesGeneros -> Filmes).*/

Select G.NomeGenero, Count(F.IdFilme)As TotalFilmes
From FilmesGeneros FG
Inner Join Filmes F
On FG.IdFilme = F.IdFilme
Inner Join Generos G
On FG.IdGenero = G.IdGenero
Group By G.NomeGenero
Order By G.NomeGenero Desc
Go

/*Cenário: A diretoria quer uma lista exclusiva de filmes 
que possuem a nota IMDb maior do que a média de todos os filmes do banco de dados.*/

/*Conceito Novo: Subquery (Subconsulta) — É uma consulta dentro de outra consulta. Aqui,
usamos uma subquery no Where para calcular dinamicamente a média global primeiro, 
e depois a consulta principal usa esse número para filtrar.*/

Select TituloFilme, NotaImdb
From Filmes
Where NotaImdb  > (Select Avg(NotaImdb) From Filmes)
Order By NotaImdb Desc
Go

/*O Cenário: A diretoria quer identificar quais plataformas cobram por suas assinaturas um valor médio maior
do que a média de preço de todas as assinaturas do mercado.
Eles só querem ver o nome da plataforma e a média de preço dela.*/

/* O que será praticado: INNER JOIN, GROUP BY, HAVING
e uma Subquery dentro do HAVING.*/

Select P.NomePlataforma, Avg(A.ValorAssinatura) As ValorTotal
From Plataformas P
Inner Join Assinaturas A
On P.IdPlataforma = A.IdPlataforma
Group By P.NomePlataforma
Having (Avg(A.ValorAssinatura) > (Select Avg(ValorAssinatura) From Assinaturas))
Order By P.NomePlataforma Desc
Go

/*O Cenário: O time de análise de dados quer saber quais gêneros de séries acumulam mais de 200 minutos
de conteúdo total na plataforma, para entender onde os usuários passam mais tempo.
O relatório deve mostrar o nome do gênero e o tempo total em minutos.*/

/*O que será particado: Junção de 4 tabelas
(Generos, SeriesGeneros, Series, Episodios), SUM(), GROUP BY e HAVING.*/

Select G.NomeGenero,  Convert (VarChar,Sum(E.DuracaoEpisodio)) + ' Minutos' As TempoTotal --Usando Convert somente para na hora da busca ficar melhor visualmente
From Generos G
Inner Join SeriesGeneros SG
On G.IdGenero = SG.IdGenero
Inner Join Series S
On SG.IdSerie = S.IdSerie
Inner Join Episodios E
On S.IdSerie = E.IdSerie
Group By G.NomeGenero
Having Sum(E.DuracaoEpisodio) > 200
Order By G.NomeGenero Asc
Go

/*O Cenário: O gerente de infraestrutura quer um relatório que liste o nome de cada plataforma e duas colunas personalizadas: 
uma chamada Planos_4K  (quantos planos em 4K ela oferece) e outra chamada Outros_Planos (quantos planos em HD ou Full HD ela oferece).*/

/*O que Será praticado: INNER JOIN, GROUP BY e CASE de forma avançada dentro da função COUNT() ou SUM().*/

Select P.NomePlataforma, 
Sum(Case When A.QualidadeAssinatura = '4K' Then 1 Else 0 End ) As Planos_4k, --Usando Case dentro do sum, Crio uma situação que se for verdadeira 4K soma 1 senão soma 0 
Sum (Case When A.QualidadeAssinatura <> '4K' Then 1 Else 0 End) As  Outros_Planos
From Plataformas P   
Inner Join Assinaturas A       
On P.IdPlataforma = A.IdPlataforma
Group By P.NomePlataforma
Go


/* O Cenário: Este é para testar seus limites! O time de marketing quer listar as séries que possuem 
uma nota IMDb maior do que a média da plataforma   onde ela é exibida. Exemplo: Uma série da Netflix só será
exibida se a nota dela for maior que a média de todas as séries da Netflix.

O que será praticado : Subquery Correlacionada (onde a consulta interna depende de uma coluna da consulta externa).*/

Select S.TituloSerie, S.IdPlataforma, S.NotaImdb
From Series s
Where NotaImdb > (Select Avg(NotaImdb) From Series S2 Where S2.IdPlataforma = S.IdPlataforma) --Usando essa subquery para trazzer a media por plataforma, não a média geral dos ids
Go

/* O Cenário: A diretoria precisa de um relatório estratégico de  nível. 
Eles querem saber qual plataforma possui o filme com a maior nota de todo o banco de dados 
E qual plataforma possui a série com a maior nota de todo o banco de dados. 
O resultado final deve ser consolidado em uma única tabela contendo o
Tipo ('Melhor Filme' ou 'Melhor Série'), o Nome da Plataforma,
o Título da produção e a Nota correspondente.

O que você vai praticar: Duas consultas complexas que unem tabelas,
o uso da função MAX() em subconsultas para achar o registro topo de linha, 
e o operador UNION ALL para juntar tudo. */

Select 'Melhor Serie' As Tipo, P.NomePlataforma, S.TituloSerie, S.NotaImdb
From Series S
Inner Join Plataformas P
On S.IdPlataforma = P.Idplataforma
Where NotaImdb = (Select Max(NotaImdb) From Series)

Union All

Select 'Melhor Filme' As Tipo, P.NomePlataforma, F.TituloFilme, F.NotaImdb
From Filmes F
Inner Join Plataformas P
On F.IdPlataforma = P.IdPlataforma
Where F.NotaImdb = (Select Max(NotaImdb) From Filmes)
Go

/*Cenário: financeiro quer saber quanto cada plataforma fatura, somando o valor de todas as assinaturas ativas dos clientes.*/


Select P.NomePlataforma, Sum(S.ValorAssinatura) As TotalPorPlataforma
From Assinaturas S
Inner Join Plataformas P
On S.IdPlataforma = P.IdPlataforma
Inner Join ClientesAssinaturas CS
On CS.IdAssinatura = S.IdAssinatura
Group By P.NomePlataforma
Go

/*Cenário: time de retenção quer saber quais clientes se cadastraram mas nunca assinaram nada (churn silencioso).*/
Select C.IdCliente, C.NomeCliente, Cs.IdAssinatura
From Clientes C
Left Join ClientesAssinaturas CS
On C.IdCliente = Cs.IdCliente
Where Cs.IdAssinatura Is Null
Go

/*Cenário: produtor quer saber qual plano tem mais clientes vinculados.*/

Select  A.TipoAssinatura, Count(C.IdCliente) As QtndCliente
From Clientes C
Inner Join ClientesAssinaturas CS
On C.IdCliente = CS.IdCliente
Inner Join Assinaturas A
On A.IdAssinatura = CS.IdAssinatura
Group By A.TipoAssinatura
Go


/*Cenário: marketing quer identificar clientes fiéis que trocaram de plano ou assinaram mais de uma vez, pra campanha de fidelidade.*/

Select C.IdCliente,count( A.TipoAssinatura) TotalAssinaturas
From Clientes C
Inner Join ClientesAssinaturas CS
On C.IdCliente = CS.IdCliente
Inner Join Assinaturas A
On A.IdAssinatura = CS.IdAssinatura
Group By C.IdCliente
Having (Count(A.TipoAssinatura) > 1)
Go

/*Cenário: CS quer priorizar contato com clientes "esquecidos".*/
Select NomeCliente, DataCadastro, CS.IdAssinatura
From Clientes C
Left Join ClientesAssinaturas CS
On C.IdCliente = CS.IdCliente
Where CS.IdCliente Is Null
Order By DataCadastro Asc
Go


/*Cenário: financeiro quer saber se clientes de cartão gastam mais que os de boleto, em média.*/

Select C.FormaPagamento, Convert(Decimal(6,2), Avg(A.ValorAssinatura)) As MediaAssinatura
From Clientes C
Inner Join ClientesAssinaturas CS
On C.IdCliente = CS.IdCliente
Inner Join Assinaturas A
On A.IdAssinatura = CS.IdAssinatura
Group By C.FormaPagamento
Go

/*Cenário: produto quer saber quantos clientes estão em cada faixa (Econômico/Intermediário/Premium).*/

Select 
Case
    When A.ValorAssinatura <= 25 Then 'Econômico'
    When A.ValorAssinatura Between 25 And 45 Then 'Intermediário'
    Else 'Premium'
    End As Categoria,
    Count(C.IdCliente)
From Clientes C
Inner Join ClientesAssinaturas CS
On C.IdCliente = CS.IdCliente
Inner Join Assinaturas A
On A.IdAssinatura = CS.IdAssinatura
Group By
Case
    When A.ValorAssinatura <= 25 Then 'Econômico'
    When A.ValorAssinatura Between 25 And 45 Then 'Intermediário'
    Else 'Premium'
    End    
Go


/*Cenário: financeiro quer saber se clientes de planos Premium preferem Pix, cartão ou boleto.*/

Select C.FormaPagamento, Count(C.IdCliente) As QntdClientes
From Clientes C
Inner Join ClientesAssinaturas CS
On C.IdCliente = CS.IdCliente
Inner Join Assinaturas A
On CS.IdAssinatura = A.IdAssinatura
Where A.TipoAssinatura = 'Premium'
Group By C.FormaPagamento
Go


-- Aprendendo Windows Function --

Select
S.TituloSerie, P.NomePlataforma, S.NotaImdb,
Convert(Decimal(4,2),Avg(S.NotaImdb) Over(Partition By P.NomePlataforma)) As MediaPlataforma -- O Over cria e limita o tamanho da 'Janela' o partition by define como a janela 
--vai ser Agrupada nesse caso por plataforma assim mostramos a series e nota dela e a media de nota da plataformas delas
--usamos o convert para deixar melhor a visualização
From Series S
Inner Join Plataformas P
On S.IdPlataforma = P.IdPlataforma
Go


Select S.TituloSerie, P.NomePlataforma, S.NotaImdb,
Row_Number () Over(partition By P.nomePlataforma Order By S.NotaImdb) As RankingPorPlataforma
--o Row_Number Serve para que criar uma coluna usado nessa query para criar um ranking, e ordenando por NotaImdb Criando um ranking por plataforma
--  A consulta é dividida por grupos que são as Plataformas a partir do momento que muda de plataforma o ranking reinicia 
From Series S
Inner Join Plataformas P
On S.IdPlataforma = P.IdPlataforma
Go

--A equipe quer analisar a duração dos episódios de cada série para entender a estrutura das temporadas.

Select E.TituloEpisodio, E.NumeroTemporada, S.TituloSerie, E.DuracaoEpisodio,
Row_Number () Over(Partition By S.IdSerie Order By E.DuracaoEpisodio) As RankingDuracao
From Series S
Inner Join Episodios E 
On E.IdSerie = S.IdSerie
Go



Select
E.TituloEpisodio, E.NumeroTemporada, S.TituloSerie, E.DuracaoEpisodio,
Avg(E.DuracaoEpisodio) Over(Partition By S.IdSerie, E.NumeroTemporada) As MediaSerie
--Esse Over mostra a média da série do episódio e da temporada dele 
From Series S
Inner Join Episodios E 
On E.IdSerie = S.IdSerie
Go

/*A equipe de marketing quer analisar o comportamento de gastos dos clientes. Eles querem ver uma lista com todos os clientes e as  assinaturas que
eles compraram, mas precisam entender como o valor daquela assinatura se compara com o maior valor que aquela plataforma cobra.*/
Select C.NomeCliente, P.NomePlataforma, A.TipoAssinatura, A.ValorAssinatura,
Max(A.ValorAssinatura) Over(Partition By P.IdPlataforma) As AssinaturaMaisCara,
--Usando o Max a gente mostra o valor da assinatura mais cara por da plataforma que o cliente assinou
Sum(A.ValorAssinatura) Over(Partition By P.IdPlataforma) As TotalGanho
From Clientes C
Inner Join ClientesAssinaturas CS
On C.IdCliente = CS.IdCliente
Inner Join Assinaturas A
On A.IdAssinatura = CS.IdAssinatura
Inner Join Plataformas P
On A.IdPlataforma = P.IdPlataforma
Go

-- aprendendo novos conceitos do windows function --

--usando dense_rank para fazer consultas usando o dense_rank que não deixa buracos


/*A equipe quer um ranking das assinaturas mais caras dentro de cada plataforma. 
Se duas assinaturas tiverem o mesmo preço, elas devem dividir a mesma posição 
no ranking, e o próximo número não pode ser pulado.*/

Select A.TipoAssinatura, A.ValorAssinatura , P.NomePlataforma,
Dense_Rank() Over(Partition By P.IdPlataforma Order By A.ValorAssinatura Desc) As AssinaturaMaisCara
From Assinaturas A 
Inner Join Plataformas P
On A.IdPlataforma = P.IdPlataforma
Go

--Usando Lag para buscar o valor da linha anterior --

/*Para cada série, liste os episódios ordenados por temporada e número do episódio. Mostre a 
duração do episódio atual e, em uma nova coluna chamada DuracaoEpisodioAnterior,
mostre a duração do episódio que veio logo antes dele.*/

Select S.TituloSerie, E.TituloEpisodio, E.DuracaoEpisodio,
Lag(E.DuracaoEpisodio) Over(Partition By S.IdSerie Order By E.NumeroTemporada, E.NumeroEpisodio ) As DuracaoEpisodioAnterior
From Series S
Inner Join Episodios E
On S.IdSerie = E.IdSerie
Go

--Usando Sum Mais Uma vez para somar as assinaturas--
--A cada Data vai somando e vai crescendo o total ganho com aquele tipo de assinatura--
Select a.TipoAssinatura, cs.IdClienteAssinatura, CS.DataAssinatura,
Sum(A.ValorAssinatura) Over(Partition By A.TipoAssinatura Order By CS.DataAssinatura) As SomaAssinaturas
From Assinaturas A
Inner Join ClientesAssinaturas CS
On a.IdAssinatura = CS.IdAssinatura
Go


/* Ao usarmos o Lag para ver o tempo do episódio anterior, fica nulo no episódio 1, pois não tem 
um episódio 0, agora vamos tratar isso*/

Select S.TituloSerie, E.TituloEpisodio, E.DuracaoEpisodio,
-- colocamos 1, 0, usamos LAG(coluna, offset, valor_padrao) 
Lag(E.DuracaoEpisodio, 1, 0) Over(Partition By S.IdSerie Order By E.NumeroTemporada, E.NumeroEpisodio ) As DuracaoEpisodioAnterior
From Series S
Inner Join Episodios E
On S.IdSerie = E.IdSerie
Go


