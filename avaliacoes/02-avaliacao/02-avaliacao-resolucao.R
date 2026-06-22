# Arquivo: 02-avaliacao-gabarito.R
# Autor: Prof. Dr. Washington S. da Silva
# Data: 09/06/2026
# Objetivo: Gabarito da Avaliação 2 — Introdução à Ciência de Dados


# Configurações globais ----------------------------------------------

# exibe números sem notação científica
options(digits = 5, scipen = 999)


# Exercício 1 --------------------------------------------------------
# Experimento, evento e variável aleatória

# a) Um possível espaço amostral é: S = {renova, não renova}.
# Também seria aceitável escrever: S = {renovação, não renovação}
# ou outra redação equivalente.


# b) Um evento associado à renovação do contrato é:
# A = {renova}.
#
# Em palavras: A é o evento "o cliente renova o contrato".


# c) A probabilidade desse evento pode ser escrita como:
# P(A)
# ou
# P(cliente renova o contrato).


# d) O resultado observado não é diretamente numérico.
# Ele é qualitativo/binário: o cliente renova ou não renova.
# O resultado só passa a ser representado numericamente depois que definimos
# uma variável aleatória.


# e) Uma variável aleatória indicadora adequada é:
# X = 1 se o cliente renova o contrato;
# X = 0 se o cliente não renova o contrato.
#
# Com essa definição, o evento A = {renova} também pode ser escrito
# como X = 1. Assim, P(A) = P(X = 1).


# f) O modelo mais adequado é Bernoulli.
# Justificativa: a variável aleatória descreve uma única observação com
# dois resultados possíveis, renovação ou não renovação.


# Exercício 2 --------------------------------------------------------
# Valor esperado em uma decisão simples

# a) X pode assumir dois valores:
# X = 12, quando o cliente utiliza o cupom;
# X = 0, quando o cliente não utiliza o cupom.


# b) Como 10% dos clientes utilizam o cupom:
# Logo: P(X = 12) = 0,10.


# c) A probabilidade de não usar o cupom é complementar:
# Logo:
# P(X = 0) = 1 - P(X = 12) = 1 - 0,10
# P(X = 0) = 0,90.


# d) Valor esperado de X:
# E(X) = 12 * 0,10 + 0 * 0,90
# E(X) = 1,20


# e) Interpretação:
# O custo esperado do desconto é R$ 1,20 por cliente que recebeu o cupom.
# Isso não significa que cada cliente gerará custo de R$ 1,20.
# Individualmente, o custo será R$ 12 ou R$ 0.
# O valor esperado resume o custo médio por cliente quando pensamos em muitos
# clientes recebendo o cupom sob as mesmas condições.


# Exercício 3 --------------------------------------------------------
# Simulação com distribuição de Poisson

# a) Define os parâmetros da simulação.

# lambda é a média de clientes por hora de pico.
lambda <- 10
# capacidade é a capacidade atual da unidade por hora.
capacidade <- 13
# n_simulacoes é a quantidade de valores de X que serão simulados.
n_simulacoes <- 1000


# b) Simula 1.000 valores de X.

# A semente torna a simulação reprodutível.
set.seed(123)

# Simula X
clientes <- rpois(n = n_simulacoes, lambda = lambda)

# Cada valor do vetor clientes é uma contagem de clientes
# em uma hora de pico.
head(clientes, 10)


# c) Calcula a média simulada de clientes por hora de pico.
media_simulada <- mean(clientes)
media_simulada

# A média simulada deve ficar próxima de 10, pois lambda = 10.
# Com set.seed(123), o valor obtido é aproximadamente 9,983.


# d) Calcula a proporção de simulações em que a capacidade foi excedida.
prop_acima_capacidade <- mean(clientes > capacidade)
prop_acima_capacidade

# Com set.seed(123), a capacidade de 13 clientes foi excedida em cerca de
# 12,5% dos valores simulados.


# e) Calcula o percentil 95 da contagem de clientes por hora de pico.
percentil_95 <- quantile(clientes, 0.95)
percentil_95

# Com set.seed(123), o percentil 95 é aproximadamente 15,05.
# Como o número de clientes é uma contagem, uma interpretação operacional
# simples é que uma capacidade de aproximadamente 16 clientes por hora cobriria
# cerca de 95% das simulações.


# f) Interpretação:
# A média simulada ficou muito próxima de 10 clientes por hora, coerente com o
# modelo Poisson(lambda = 10).
# A capacidade atual de 13 clientes foi excedida em cerca de 12,5% dos valores
# simulados. Portanto, em uma hora de pico sob esse modelo, a unidade ficaria
# acima da capacidade com alguma frequência.
# O percentil 95 ficou em torno de 15 clientes. Isso indica que, em cerca de
# 95% das simulações, chegam aproximadamente até 15 ou 16 clientes.
# Assim, se a prioridade for reduzir a saturação no horário de pico, a
# capacidade atual de 13 clientes por hora parece limitada. Se a unidade
# aceitar alguma espera em parte dos horários de pico, a capacidade pode ser
# defendida, mas com risco operacional visível.
