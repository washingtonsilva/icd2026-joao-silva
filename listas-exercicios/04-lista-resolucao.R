# Arquivo: 04-lista-solucoes.R
# Autor: Prof. Washington S. da Silva
# Data: 12/05/2026
# Objetivo: Gabarito da Lista de Exercícios 4

# Configurações globais --------------------------------------

# Configura o número de dígitos exibidos
options(digits = 5, scipen = 999)

# Carrega os pacotes
library(tidyverse)


# Exercício 2 ------------------------------------------------

# a)
# Total de conjuntos diferentes de 20 números que podem ser sorteados
# entre os 100 números possíveis.
total_resultados <- choose(100, 20)
total_resultados

# b)
# Para acertar os 20 números, todos os números sorteados precisam estar
# dentro dos 50 números escolhidos na aposta.
resultados_favoraveis <- choose(50, 20)
resultados_favoraveis

# c)
# Probabilidade de acertar os 20 números.
prob_acertar_20 <- resultados_favoraveis / total_resultados
prob_acertar_20


# Exercício 3 ------------------------------------------------

# Probabilidade teórica do evento A: obter número maior ou igual a 5.
# Resultados favoráveis: 5 e 6.
prob_teorica <- 2 / 6
prob_teorica

# Simulação com n = 100

# resultados possíveis do dado
dado <- 1:6

# número de lançamentos
n <- 100

# fixa a semente para reprodutibilidade
set.seed(123)

# simula os lançamentos
lancamentos <- sample(
  x = dado,
  size = n,
  replace = TRUE,
  prob = rep(1 / 6, 6)
)

# evento A: resultado maior ou igual a 5
evento_A <- lancamentos >= 5

# número de lançamentos favoráveis ao evento A
favoraveis <- sum(evento_A)
favoraveis

# frequência relativa do evento A
freq_relativa <- mean(evento_A)
freq_relativa


# Simulação com n = 1000

# número de lançamentos
n <- 1000

# fixa a semente para reprodutibilidade
set.seed(123)

# simula os 1000 lançamentos
lancamentos <- sample(
  x = dado,
  size = n,
  replace = TRUE,
  prob = rep(1 / 6, 6)
)

# evento A: resultado maior ou igual a 5
evento_A <- lancamentos >= 5
evento_A

# número de lançamentos favoráveis ao evento A
favoraveis <- sum(evento_A)
favoraveis

# frequência relativa do evento A
freq_relativa <- mean(evento_A)
freq_relativa


# Simulação com n = 10000

# número de lançamentos
n <- 10000

# fixa a semente para reprodutibilidade
set.seed(123)

# simula os 10000 lançamentos
lancamentos <- sample(
  x = dado,
  size = n,
  replace = TRUE,
  prob = rep(1 / 6, 6)
)

# evento A: resultado maior ou igual a 5
evento_A <- lancamentos >= 5

# número de lançamentos favoráveis ao evento A
favoraveis <- sum(evento_A)
favoraveis

# frequência relativa do evento A
freq_relativa <- mean(evento_A)
freq_relativa

# Interpretação:
# A probabilidade teórica é 2/6 = 1/3, aproximadamente 0,333.
# As frequências relativas simuladas não precisam ser exatamente iguais
# à probabilidade teórica, especialmente quando n é pequeno.
# Em geral, quando n aumenta, a frequência relativa tende a se aproximar
# da probabilidade teórica.


# Exercício 5 ------------------------------------------------

# Cálculo do valor esperado com R

# parâmetros do modelo
prob_incendio <- 0.01
indenizacao <- 150000
carregamento <- 0.25

# valor esperado de indenização por residência
valor_esperado <- prob_incendio * indenizacao

# exibe o resultado
valor_esperado

# prêmio anual por residência com acréscimo
premio <- valor_esperado * (1 + carregamento)

# exibe o resultado
premio

# a)
# O valor esperado de indenização é R$ 1.500 por residência por ano.
# Ele representa a média teórica das indenizações por residência em
# uma carteira grande de riscos semelhantes.

# b)
# O valor esperado não significa que toda residência terá indenização de
# R$ 1.500. Para uma residência individual, a indenização será R$ 0 se
# não houver incêndio ou R$ 150.000 se houver incêndio.

# c)
# O cálculo é simplificado. Ele ignora despesas administrativas, impostos,
# corretagem, inadimplência, capital regulatório, resseguro, eventos extremos
# e possíveis erros na estimativa da probabilidade de incêndio.


# Exercício 6 ------------------------------------------------

# Carteira com n = 100

# fixa a semente para reprodutibilidade
set.seed(2)

# tamanho da carteira de residências seguradas
n <- 100

# simula a indenização de cada residência: 0 ou valor total da indenização
indenizacoes <- sample(
  x = c(0, indenizacao),
  size = n,
  replace = TRUE,
  prob = c(1 - prob_incendio, prob_incendio)
)

# média das indenizações por residência na carteira simulada
media_indenizacoes <- mean(indenizacoes)
media_indenizacoes

# total de indenizações pagas pela seguradora
total_indenizacoes <- sum(indenizacoes)
total_indenizacoes

# total arrecadado com os prêmios cobrados
total_premios <- n * premio
total_premios

# resultado simplificado da carteira: prêmios recebidos menos indenizações pagas
resultado_carteira <- total_premios - total_indenizacoes
resultado_carteira


# Carteira com n = 10000

# fixa a semente para reprodutibilidade
set.seed(2)

# tamanho da carteira de residências seguradas
n <- 10000

# simula a indenização de cada residência: 0 ou valor total da indenização
indenizacoes <- sample(
  x = c(0, indenizacao),
  size = n,
  replace = TRUE,
  prob = c(1 - prob_incendio, prob_incendio)
)

# média das indenizações por residência na carteira simulada
media_indenizacoes <- mean(indenizacoes)
media_indenizacoes

# total de indenizações pagas pela seguradora
total_indenizacoes <- sum(indenizacoes)
total_indenizacoes

# total arrecadado com os prêmios cobrados
total_premios <- n * premio
total_premios

# resultado simplificado da carteira: prêmios recebidos menos indenizações pagas
resultado_carteira <- total_premios - total_indenizacoes
resultado_carteira


# Carteira com n = 100000

# fixa a semente para reprodutibilidade
set.seed(2)

# tamanho da carteira de residências seguradas
n <- 100000

# simula a indenização de cada residência: 0 ou valor total da indenização
indenizacoes <- sample(
  x = c(0, indenizacao),
  size = n,
  replace = TRUE,
  prob = c(1 - prob_incendio, prob_incendio)
)

# média das indenizações por residência na carteira simulada
media_indenizacoes <- mean(indenizacoes)
media_indenizacoes

# total de indenizações pagas pela seguradora
total_indenizacoes <- sum(indenizacoes)
total_indenizacoes

# total arrecadado com os prêmios cobrados
total_premios <- n * premio
total_premios

# resultado simplificado da carteira: prêmios recebidos menos indenizações pagas
resultado_carteira <- total_premios - total_indenizacoes
resultado_carteira


# Respostas interpretativas ----------------------------------

# a)
# Quando n aumenta, a média das indenizações por residência tende a ficar
# mais próxima do valor esperado teórico, conforme previsto pela lei dos
# grandes números.

# b)
# A média das indenizações tende a se aproximar de R$ 1.500, que é o valor
# esperado de indenização por residência.

# c)
# Uma carteira maior tende a tornar a média das indenizações mais previsível
# porque a frequência relativa de incêndios tende a se aproximar da
# probabilidade teórica de 1%. Isso é uma aplicação da Lei dos Grandes Números.

# d)
# O risco não desaparece completamente. A seguradora ainda pode ser afetada por
# eventos extremos, dependência entre riscos, erro na estimativa da
# probabilidade de incêndio e custos que não foram incluídos neste modelo simples.
