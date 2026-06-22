# Arquivo: 04-preparacao-relatorio.R
# Autor: Joao Silva
# Data: 03/05/2026
# Objetivo: preparar a base analitica para o relatorio da atividade


# Configuracoes globais -----------------------------------------------

options(digits = 5, scipen = 999)


# Pacotes -------------------------------------------------------------

library(here)
library(tidyverse)


# Importacao dos dados brutos ----------------------------------------

# define o caminho relativo do arquivo de agencias
caminho_agencias <- here::here("dados/brutos/agencias.csv")

# importa o arquivo de agencias
dados_agencias <- readr::read_csv(caminho_agencias, show_col_types = FALSE)

# define o caminho relativo do arquivo de credito
caminho_credito <- here::here("dados/brutos/credito_trimestral.csv")

# importa o arquivo de credito
dados_credito <- readr::read_csv(caminho_credito, show_col_types = FALSE)


# Preparacao da base analitica ---------------------------------------

# reorganiza os trimestres em uma coluna de identificacao
dados_credito_longo <- dados_credito |>
  pivot_longer(
    cols = T1:T4,
    names_to = "trimestre",
    values_to = "volume_credito"
  )

# combina os dados de credito com os dados das agencias
dados_completos <- dados_credito_longo |>
  left_join(dados_agencias, by = "codigo_agencia")


# Salvamento ----------------------------------------------------------

# define o caminho relativo do arquivo de saida
caminho_saida_limpa <- here::here("dados/limpos/dados_completos_limpos.rds")

# salva a base analitica limpa para uso no relatorio
readr::write_rds(dados_completos, caminho_saida_limpa)