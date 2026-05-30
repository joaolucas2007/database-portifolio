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

/*Objetivo: Escreva uma consulta que entregue os as séries com a maior nota e sua data de lançamento.*/

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

/*Objetivo: Escrever uma aConsulta que me entregue o título da série, e a duração de seus episódios somados*/

Select S.TituloSerie, 
Convert(VarChar,Sum(DuracaoEpisodio)) + 'Minutos' As TempoTotal --Usando Cinverte para converter em VarChar para deixar mais acessível visualmente--
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

/*Objetivo: Escrever uma consulta que retorne o nome da série e o nome do episódio desejado, filtrandcom Like e Or*/

Select S.TituloSerie, E.TituloEpisodio
From Episodios E
Inner Join Series S
On S.IdSerie = E.IdSerie
Where E.TituloEpisodio Like 'Chapter%' 
	Or E.TituloEpisodio Like '%The%'
Go