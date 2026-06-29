Use SeriesDB
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