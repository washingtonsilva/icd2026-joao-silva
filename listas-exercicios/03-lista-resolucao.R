# Arquivo: 03-lista.R
# Autor: Prof. Washington Silva
# Data: 14/04/2026
# Objetivo: Resolução da Lista de Exercícios 3

# Configurações globais --------------------------------------

# Configura o número de dígitos exibidos
options(digits = 5, scipen = 999)

# Carrega os pacotes necessários
library(here)
library(tidyverse)



# Exercício 1 ------------------------------------------------

## a

# define o caminho para o arquivo csv
caminho_receitas <- here("dados/brutos/receitas_trimestres.csv")

# importa o arquivo e armazena no objeto dados_receitas
dados_receitas <- read_csv(caminho_receitas)

## b

# exibe a estrutura do objeto importado
glimpse(dados_receitas)

## c

# comentário:
# a tabela está em formato desorganizado para análise porque os trimestres
# (T1, T2, T3 e T4) são valores de uma variável, mas aparecem em colunas
# separadas

## d

# transforma a tabela para o formato longo
receitas_longas <- dados_receitas |>
  pivot_longer(
    cols = c("T1", "T2", "T3", "T4"),
    names_to = "trimestre",
    values_to = "receita"
  )

# exibe a estrutura
glimpse(receitas_longas)

## e

# visualiza o objeto no RStdio
View(receitas_longas)


# Exercício 2 ------------------------------------------------

## a

# define o caminho para o arquivo csv
caminho_desempenho <- here("dados/brutos/desempenho_empresa.csv")

# importa o arquivo e armazena no objeto dados_desempenho
dados_desempenho <- read_csv(caminho_desempenho)

## b

# exibe a estrutura do objeto importado
glimpse(dados_desempenho)

## c

# comentário:
# os nomes das colunas misturam duas informações:
# 1. o tipo de indicador (receita ou despesa)
# 2. o trimestre (T1 ou T2)

## d

# transforma a tabela para o formato longo
desempenho_longo <- dados_desempenho |>
  pivot_longer(
    cols = -empresa,
    names_to = c("indicador", "trimestre"),
    names_sep = "_",
    values_to = "valor"
  )

# exibe a estrutura do objeto
glimpse(desempenho_longo)

## e

# visualiza o objeto no RStudio
View(desempenho_longo)


# Exercício 3 ------------------------------------------------

## a

# define os caminhos para os arquivos csv
caminho_produtos <- here("dados/brutos/produtos.csv")
caminho_vendas <- here("dados/brutos/vendas.csv")
caminho_clientes <- here("dados/brutos/clientes.csv")

# importa os arquivos e armazena nos objetos
dados_produtos <- read_csv(caminho_produtos)
dados_vendas <- read_csv(caminho_vendas)
dados_clientes <- read_csv(caminho_clientes)


## b

# exibe a estrutura de cada objeto importado
glimpse(dados_produtos)
glimpse(dados_vendas)
glimpse(dados_clientes)


## c

# combina dados_vendas com dados_produtos usando left_join()
vendas_produtos <- dados_vendas |>
  left_join(dados_produtos, by = "codigo_produto")

# exibe a estrutura do objeto
glimpse(vendas_produtos)

# visualiza o objeto no RStudio
View(vendas_produtos)


## d

# combina o resultado anterior com a tabela de clientes
relatorio_vendas <- vendas_produtos |>
  left_join(dados_clientes, by = "id_cliente")

# exibe a estrutura do objeto
glimpse(relatorio_vendas)

# visualiza o objeto no RStudio
View(relatorio_vendas)


## e

# seleciona apenas as variáveis solicitadas
relatorio_final <- relatorio_vendas |>
  select(
    id_venda,
    codigo_produto,
    id_cliente,
    data_venda,
    nome_produto,
    quantidade,
    nome_cliente,
    cidade
  )

# exibe a estrutura do objeto
glimpse(relatorio_final)

## f

# visualiza o objeto no RStudio
View(relatorio_final)

## g

# comentário:
# podem surgir valores NA após o uso de left_join() quando existem
# registros na tabela principal que não encontram correspondência
# na outra tabela.
# neste exemplo:
# - o produto P006 aparece em dados_vendas, mas não está em dados_produtos
# - o cliente C004 aparece em dados_vendas, mas não está em dados_clientes

## h

# refaz a combinação entre dados_vendas e dados_produtos usando inner_join()
vendas_produtos_inner <- dados_vendas |>
  inner_join(dados_produtos, by = "codigo_produto")

# exibe a estrutura do objeto
glimpse(vendas_produtos_inner)

# visualiza o objeto no RStudio
View(vendas_produtos_inner)

# comentário:
# com inner_join(), permanecem apenas as linhas que têm correspondência
# nas duas tabelas.
# por isso, a venda associada ao produto P006 não aparece no resultado

## i

# refaz a combinação entre dados_vendas e dados_produtos usando full_join()
vendas_produtos_full <- dados_vendas |>
  full_join(dados_produtos, by = "codigo_produto")

# exibe a estrutura do objeto
glimpse(vendas_produtos_full)

# visualiza o objeto no RStudio
View(vendas_produtos_full)

# comentário:
# com full_join(), são mantidas todas as linhas das duas tabelas.
# por isso, além das vendas, também aparece o produto P005,
# que está em dados_produtos, mas não aparece em dados_vendas
