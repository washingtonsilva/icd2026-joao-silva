# Arquivo: 02-lista-solucoes.R
# Autor(a): Prof. Washington Silva
# Data: 07/04/26
# Objetivo:
# 1. Resolver os exercícios da lista 2


# Configuracoes globais ---------------------------------------------------

# Configura o numero de digitos a serem exibidos
options(digits = 5, scipen = 999)

# carrega os pacotes necessarios
library(here)
library(tidyverse)
library(janitor)


# Exercicio 1 -------------------------------------------------------------

## a) os pacotes foram carregados no inicio do script (secao Configuracoes globais)


## b)

# define o caminho para o arquivo csv
caminho_csv <- here("dados/brutos/dados-marketing.csv")

# importa os dados e armazena no objeto dados_marketing
dados_marketing <- read_csv(caminho_csv)


## c)

# exibe uma visao geral dos dados
glimpse(dados_marketing)


# Exercicio 2 -------------------------------------------------------------

## a) Cada linha (observacao) do arquivo representa uma semana de
##    observacao da empresa com informacoes sobre os gastos em diferentes
##    canais de marketing (TV, radio, redes sociais e e-mail), a ocorrencia
##    de promocao, a atividade da concorrencia e a receita de vendas
##    obtida naquela semana.


## b) o objeto dados_marketing possui 156 observacoes e 9 variaveis


# Exercicio 3 -------------------------------------------------------------

## a)

# padroniza os nomes das colunas e cria um novo objeto
dados_marketing_limpos <- dados_marketing |>
  clean_names()


## b)

# mostra os nomes das variaveis após a padronização
names(dados_marketing_limpos)


# Exercicio 4 -------------------------------------------------------------

# monta uma versão mais enxuta do resultado
dados_marketing_limpos |>
  select(data, mes, gasto_tv, gasto_radio, promocao, receita_vendas)


# Exercicio 5 -------------------------------------------------------------

# cria a variavel gasto_total
dados_marketing_limpos <- dados_marketing_limpos |>
  mutate(
    gasto_total = gasto_tv + gasto_radio + gasto_redes_sociais + gasto_email
  )

# mostra as colunas solicitadas
dados_marketing_limpos |>
  select(data, mes, gasto_total, receita_vendas)

# visualiza o objeto no RStudio
View(dados_marketing_limpos)


# Exercicio 6 -------------------------------------------------------------

# cria duas novas variaveis com nomes mais descritivos
dados_marketing_limpos <- dados_marketing_limpos |>
  mutate(
    status_promocao = ifelse(promocao == 1, "Com promoção", "Sem promoção"),
    status_concorrencia = ifelse(
      atividade_concorrente == 1,
      "Com concorrência",
      "Sem concorrência"
    )
  )

# mostra as novas variaveis
dados_marketing_limpos |>
  select(promocao, status_promocao, atividade_concorrente, status_concorrencia)

# visualiza o objeto no RStudio
View(dados_marketing_limpos)


# Exercicio 7 -------------------------------------------------------------

# define o caminho relativo para salvar o arquivo rds
caminho_rds <- here("dados/limpos/dados_marketing_limpos.rds")

# salva os dados limpos no formato rds
write_rds(dados_marketing_limpos, caminho_rds)

# visualiza a base de dados no RStudio
View(dados_marketing_limpos)


# Exercicio 8 -------------------------------------------------------------

# filtra semanas com promocao e receita maior que 1000
dados_marketing_limpos |>
  filter(promocao == 1 & receita_vendas > 1000) |>
  select(data, mes, receita_vendas, status_promocao)


# Exercicio 9 -------------------------------------------------------------

# cria um objeto com o resumo dos dados por mês
resumo_mensal <- dados_marketing_limpos |>
  group_by(mes) |>
  summarise(
    receita_media = mean(receita_vendas),
    receita_total = sum(receita_vendas),
    gasto_total_medio = mean(gasto_total),
    semanas_com_promocao = sum(promocao)
  ) |>
  arrange(desc(receita_media))

# mostra o resultado ordenado
resumo_mensal

# visualiza o resultado no RStudio
View(resumo_mensal)

# os tres meses com maior receita media sao:
# mes 12, mes 11 e mes 10
