# StreamingDB

Projeto desenvolvido para praticar modelagem de banco de dados relacional e consultas SQL utilizando SQL Server.

## Sobre o Projeto

A StreamingDB simula um sistema de gerenciamento de séries, filmes e assinaturas de streaming, permitindo o cadastro, relacionamento e a análise profunda de informações de catálogo e finanças.
O projeto foi criado com o objetivo de consolidar conhecimentos em modelagem de dados, relacionamentos entre tabelas e desenvolvimento de consultas SQL avançadas orientadas a inteligência de negócios (BI).

## Diagrama Entidade-Relacionamento

![DER](../Imagens-DER-BI/DER-StreamingDB-V3.png)

## Tecnologias Utilizadas

* SQL Server
* T-SQL
* Git
* GitHub
* Power Bi

## Conceitos Aplicados

* Modelagem Relacional (1:N e N:N com tabelas de junção)
* Primary Key e Foreign Key
* Identity, Unique e Check Constraints
* Inner Join, Left Join e Operadores de Conjunto (Union All)
* Group By e Filtros Pós-Agrupamento (Having)
* Funções de Agregação (Sum, Count, Avg, Max)
* Expressões Condicionais (Case When) e Agregações Condicionais
* Subqueries (Subconsultas Independentes e Correlacionadas)

## Estrutura do Projeto

StreamingDB
│
├── Scripts
│   ├── 01_Schema_2.sql
│   ├── 02_Crud_2.sql
│   ├── 03_Relatorio_Negocio_2.sql
│   ├── 04_Relatorio_PowerBI.sql
├── Imagens-DER-BI
│   └── DER-StreamingDB-V3.png
│   ├── dashboard_01.png
└── Readme
    └── README.md

## Business Intelligence & Dashboard (Power BI)

Para complementar a análise técnica dos scripts SQL, foi desenvolvido um painel interativo no Power BI conectado ao banco de dados `StreamingDB`. O objetivo é transformar as consultas de negócios em indicadores visuais e acionáveis (KPIs).

## Indicadores Monitorados:
* **Faturamento por Plataforma**: Soma das assinaturas ativas de clientes.
* **Evolução Mensal**: Volume de novas assinaturas realizadas ao longo do tempo.
* **Engajamento de Catálogo**: Nota média das séries filtradas por gênero.
* **Perfil do Consumidor**: Distribuição das formas de pagamento preferidas pelos clientes.

![Dashboard StreamingDB](../Imagens-DER-BI/dashboard_01.png)