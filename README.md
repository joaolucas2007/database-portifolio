# StreamingDB

Sistema de banco de dados desenvolvido em SQL Server para simular uma plataforma de streaming, com foco em modelagem relacional, consultas SQL e Business Intelligence.

---

# 🎯 Objetivo

O objetivo deste projeto é consolidar conhecimentos em SQL Server por meio do desenvolvimento de um banco de dados completo, aplicando conceitos utilizados no mercado de trabalho, desde a modelagem até a geração de dashboards no Power BI.

---

# 🛠 Tecnologias Utilizadas

- SQL Server
- T-SQL
- Power BI
- Git
- GitHub

---

# 📚 Conceitos Aplicados

- Modelagem Relacional
- Normalização
- Primary Key e Foreign Key
- Constraints (CHECK, UNIQUE e IDENTITY)
- CRUD
- INNER JOIN e LEFT JOIN
- GROUP BY e HAVING
- CASE
- Subqueries
- CTE
- Window Functions
- Views
- Procedures
- Triggers

---

# 📁 Estrutura do Projeto
StreamingDB
│
├── DashBoard
│   ├── 01_DashBoard_StreamingDB.pbix
│   └── Dashboard-Cliente-02.pbix
│
├── Imagens-DER-BI
│   ├── dashboard_01.png
│   ├── Dashboard_02.png
│   └── DER-StreamingDB_V5.png
│
├── scripts
│   ├── 01_Schema.sql
│   ├── 02_Crud.sql
│   ├── 03_Relatorio_Negocio.sql
│   ├── 04_Relatorio_PowerBI.sql
│   ├── 05_Relatorio_PowerBi_Clientes.sql
│   └── 06_Procedures.sql
│
└── README.md

---
# 📊 Dashboards

O projeto conta com relatórios interativos desenvolvidos no Power BI utilizando os dados do banco StreamingDB.

### Dashboard 01 - Geral

- 📈 **Evolução de Assinaturas:** Acompanhamento mensal do volume de assinaturas.
- 💳 **Formas de Pagamento:** Distribuição por Boleto, Cartão de Crédito e Pix.
- 🎬 **Média de Notas por Gênero:** Avaliação média das séries por gênero.
- 💰 **Receita por Plataforma:** Faturamento total gerado por plataforma.

![Dashboard Geral](./StreamingDB/Imagens-DER-BI/dashboard_01.png)

---

### Dashboard 02 - Análise de Plataformas e Clientes

- ⭐ **Ranking por Nota Média:** Avaliação das plataformas com base no feedback dos usuários.
- 📺 **Plataformas mais Consumidas:** Volume de consumo por plataforma.
- 💵 **Valor Ganho por Plataforma:** Porcentagem de receita e faturamento comparativo.
- 🏷️ **Ranking de Gêneros:** Avaliação média detalhada por categoria de conteúdo.

![Dashboard Clientes](./StreamingDB/Imagens-DER-BI/Dashboard_02.png)
---

# 🗺 Modelo Entidade-Relacionamento

![DER](./StreamingDB/Imagens-DER-BI/DER-StreamingDB_V5.png)

---

# 📬 Contato

📧 Email: joao.lucas.devsql@gmail.com

💼 LinkedIn: www.linkedin.com/in/joão-lucas-freire-da-silva-a1b139420