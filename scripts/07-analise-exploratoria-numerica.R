# Arquivo: 07-analise-exploratoria-numerica.R
# Autor(a): <seu nome>
# Data: 15/06/2026
# Objetivos:
# 1. Carregar e inspecionar os dados de marketing
# 2. Calcular estatísticas amostrais de centro, posição e variabilidade
# 3. Interpretar a receita semanal com base nos dados observados


# 0. Pacotes e opções globais --------------------------------------------

# Opções de exibição numérica
options(digits = 5, scipen = 999)

# Pacotes usados nesta aula
library(here)
library(tidyverse)


# 1. Carregamento dos dados ---------------------------------------------

# Caminho do arquivo de dados limpos
caminho_dados <- here("dados/limpos/dados_marketing_limpos.rds")

# Leitura dos dados de marketing
dados_marketing <- read_rds(caminho_dados)

# Estrutura dos dados carregados
glimpse(dados_marketing)


# 2. Inspeção inicial ---------------------------------------------------

# Dimensões da base
dim(dados_marketing)

# Nomes das variáveis
names(dados_marketing)

# Primeiras linhas da base
head(dados_marketing)

# Contagem de semanas por status de promoção
dados_marketing |>
  count(status_promocao)


# 3. Valores típicos da receita ------------------------------------------

# Resumo com medidas amostrais de centro
estatisticas_centro <- dados_marketing |>
  summarize(
    # Média amostral
    media = mean(receita_vendas),

    # Mediana amostral
    mediana = median(receita_vendas)
  )

# Exibe o resumo calculado
estatisticas_centro


# 4. Resumo rápido da receita --------------------------------------------

# Extrai a coluna receita_vendas como um vetor
receita <- dados_marketing |>
  pull(receita_vendas)

# Resumo amostral básico
summary(receita)


# 5. Quantis da receita --------------------------------------------------

# Quantis amostrais selecionados
quantis_receita <- dados_marketing |>
  summarize(
    # Mínimo amostral e percentil 5
    p0 = quantile(receita_vendas, 0),
    p5 = quantile(receita_vendas, 0.05),

    # Quartis amostrais
    q1 = quantile(receita_vendas, 0.25),
    mediana = quantile(receita_vendas, 0.50),
    q3 = quantile(receita_vendas, 0.75),

    # Percentil 95 e máximo amostral
    p95 = quantile(receita_vendas, 0.95),
    p100 = quantile(receita_vendas, 1)
  )

# Exibe os quantis calculados
quantis_receita


# 6. Variabilidade da receita --------------------------------------------

# Resumo com medidas amostrais de variabilidade
estatisticas_variabilidade <- dados_marketing |>
  summarize(
    # Amplitude amostral
    amplitude = max(receita_vendas) - min(receita_vendas),

    # Variância amostral
    variancia = var(receita_vendas),

    # Desvio-padrão amostral
    desvio_padrao = sd(receita_vendas),

    # Intervalo interquartil amostral
    iqr = IQR(receita_vendas)
  )

# Exibe o resumo calculado
estatisticas_variabilidade


# 7. Coeficiente de variação ---------------------------------------------

# Resumo com média, desvio-padrão e CV amostrais
cv_receita <- dados_marketing |>
  summarize(
    # Média amostral
    media = mean(receita_vendas),

    # Desvio-padrão amostral
    desvio_padrao = sd(receita_vendas),

    # CV amostral percentual
    cv_percentual = 100 * desvio_padrao / media
  )

# Exibe o coeficiente de variação
cv_receita
