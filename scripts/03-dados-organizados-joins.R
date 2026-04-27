# Arquivo: 03-dados-organizados-joins.R
# Autor(a): <seu nome>
# Data: 13/04/26
# Objetivos:
# 1. Aprender a organizar dados com a função pivot_longer() do pacote tidyr
# 2. Aprender a combinar tabelas com a função left_join() do pacote dplyr


# Configurações globais ---------------------------------------------------

# Configura o número de dígitos a serem exibidos
options(digits = 5, scipen = 999)

# carrega os pacotes necessários
library(here) # para usar caminhos relativos
library(tidyverse) # carrega tidyr, tibble, dplyr...


# Organizando dados com pivot_longer() ------------------------------------

# Exemplo 1

# cria uma tibble no formato amplo
receitas <- tribble(
  ~produto, ~T1, ~T2, ~T3, ~T4,
  "Produto A", 50000, 55000, 60000, 65000,
  "Produto B", 30000, 32000, 35000, 37000,
  "Produto C", 20000, 22000, 25000, 27000
)

# exibe o objeto
receitas

# transforma receitas para o formato longo
receitas_longo <- receitas |>
  pivot_longer(
    cols = c("T1", "T2", "T3", "T4"),
    names_to = "trimestre",
    values_to = "receita"
  )

# exibe o resultado
receitas_longo


# Exemplo 2

# cria uma tibble no formato amplo
desempenho <- tribble(
  ~empresa, ~receita_T1, ~receita_T2, ~despesa_T1, ~despesa_T2,
  "Empresa A", 150000, 175000, 120000, 130000,
  "Empresa B", 250000, 270000, 200000, 220000,
  "Empresa C", 100000, 115000, 80000, 95000
)

# exibe o objeto
desempenho

# transforma desempenho para o formato longo
desempenho_longo <- desempenho |>
  pivot_longer(
    cols = -empresa,
    names_to = c("indicador", "trimestre"),
    names_sep = "_",
    values_to = "valor"
  )

# exibe o resultado
desempenho_longo


# Combinando tabelas com left_join() -------------------------------------

# Dados dos exemplos

# cria a tabela de produtos
produtos <- tribble(
  ~codigo_produto, ~nome_produto, ~preco_unitario, ~categoria,
  "P001", "Notebook Pro", 4500, "Eletrônicos",
  "P002", "Smartphone X", 2800, "Eletrônicos",
  "P003", "Monitor 24pol", 1200, "Informática",
  "P004", "Mouse Gamer", 250, "Informática",
  "P005", "Cadeira Ergonômica", 950, "Mobiliário"
)

# exibe a tabela
produtos


# cria a tabela de vendas
vendas <- tribble(
  ~id_venda, ~codigo_produto, ~id_cliente, ~data_venda,  ~quantidade,
  1,         "P001",          "C001",      "2025-04-15", 1,
  2,         "P002",          "C002",      "2025-04-16", 2,
  3,         "P003",          "C001",      "2025-04-18", 2,
  4,         "P002",          "C003",      "2025-04-20", 1,
  5,         "P006",          "C002",      "2025-04-22", 3,
  6,         "P004",          "C004",      "2025-04-23", 4
)

# exibe a tabela
vendas


# cria a tabela de clientes
clientes <- tribble(
  ~id_cliente, ~nome_cliente,    ~cidade,
  "C001",      "Empresa Alpha",  "São Paulo",
  "C002",      "Empresa Beta",   "Rio de Janeiro",
  "C003",      "João Silva",     "Belo Horizonte",
  "C005",      "Maria Oliveira", "Recife"
)

# exibe a tabela
clientes


# Exemplo 1

# combina vendas e produtos usando left_join()
vendas_produtos <- vendas |>
  left_join(produtos, by = "codigo_produto")

# exibe o objeto
vendas_produtos

# combina vendas_produtos com clientes usando left_join()
vendas_produtos_clientes <- vendas_produtos |>
  left_join(clientes, by = "id_cliente")

# exibe o objeto
vendas_produtos_clientes


# Desafio: Combine as 3 tabelas em um único pipeline usando left_join()
# e exiba o resultado final

# combinando as 3 tabelas em um pipeline
relatorio_vendas <- vendas |>
  left_join(produtos, by = "codigo_produto") |>
  left_join(clientes, by = "id_cliente")

# exibe o resultado
relatorio_vendas
