# Arquivo: 06-distribuicoes-simulacao.R
# Autor: Joao Silva
# Data: 19/05/2026
# Objetivos:
# 1. Compreender as distribuições Bernoulli, Binomial, Poisson e Normal
#    a partir do processo gerador dos dados.
# 2. Usar simulação em R para estudar essas distribuições em
#    cenários típicos de Administração.


# 0. Configurações globais ---------------------------------------------

# Exibe números sem notação científica e com menos casas decimais.
options(digits = 5, scipen = 999)

# Carrega os pacotes usados na aula.
library(tidyverse)


# 1. Simulação Bernoulli: Lei dos Grandes Números -----------------------
# Pergunta: como a proporção simulada de defeitos muda quando n aumenta?

# Fixa a semente para reprodutibilidade.
set.seed(1)

# Probabilidade de uma peça apresentar defeito.
p_defeito <- 0.02

# Simula muitos cenários possíveis de inspeções independentes.
# Cada valor é 1 se a peça tem defeito e 0 caso contrário.
pecas <- rbinom(n = 10000, size = 1, prob = p_defeito)

# Resume a proporção de defeitos para diferentes tamanhos de simulação.
resumo_lgn <- tibble(
  # Tamanhos da simulação que serão comparados.
  n = c(100, 1000, 10000),

  # Proporção de defeitos observada nos primeiros n valores simulados.
  proporcao_defeitos = c(
    mean(pecas[1:100]),
    mean(pecas[1:1000]),
    mean(pecas[1:10000])
  ),

  # Probabilidade teórica usada para gerar os dados simulados.
  probabilidade_teorica = p_defeito
)

resumo_lgn


# 2. Simulação binomial: conversões em e-mail marketing -----------------
# Pergunta: quais conversões semanais são plausíveis para essa campanha?

# Parâmetros do modelo:
# usamos a taxa histórica como estimativa da probabilidade p.
n_emails       <- 500     # tamanho da campanha semanal
prob_conversao <- 0.08    # estimativa de p a partir da taxa histórica
n_semanas      <- 1000    # quantas semanas simular

# Fixa a semente para reprodutibilidade.
set.seed(123)

# Simula muitos cenários possíveis da campanha.
conversoes <- rbinom(
  n    = n_semanas,
  size = n_emails,
  prob = prob_conversao
)

# Confere o tamanho do vetor criado.
length(conversoes)

# Mostra as primeiras semanas simuladas.
head(conversoes, 10)

# Média e variabilidade das conversões simuladas.
media_conversoes <- mean(conversoes)
dp_conversoes    <- sd(conversoes)

media_conversoes
dp_conversoes

# Faixa central: cerca de 90% das semanas simuladas ficam entre esses valores.
faixa_central_conversoes <- quantile(conversoes, c(0.05, 0.95))
faixa_central_conversoes

# Risco de cenários adversos: semanas com menos de 30 conversões.
prob_abaixo_30 <- mean(conversoes < 30)
prob_abaixo_30

# Chance de cenários favoráveis: semanas com 50 conversões ou mais.
prob_50_ou_mais <- mean(conversoes >= 50)
prob_50_ou_mais


# 3. Simulação Poisson: atendimento em hora de pico ---------------------
# Pergunta: quais demandas por hora são plausíveis no horário de pico?

# Parâmetros do modelo.
lambda     <- 25      # média de clientes por hora de pico
capacidade <- 30      # capacidade da operação por hora
n_horas    <- 10000   # quantas horas simular

# Fixa a semente para reprodutibilidade.
set.seed(123)

# Simula muitos cenários possíveis de horas de pico.
clientes <- rpois(
  n      = n_horas,
  lambda = lambda
)

# Inspeção rápida dos valores simulados.
head(clientes, 10)
mean(clientes)   # deve ser próximo de lambda
var(clientes)    # também deve ser próximo de lambda

# Probabilidade de exceder a capacidade atual.
prob_saturacao_atual <- mean(clientes > capacidade)
prob_saturacao_atual

# Capacidade que cobre aproximadamente 95% das horas simuladas.
capacidade_95 <- quantile(clientes, 0.95)
capacidade_95

# Clientes excedentes esperados por hora.
# if_else() calcula o excedente quando há saturação e zero caso contrário.
excedente_medio_atual <- mean(
  if_else(clientes > capacidade, clientes - capacidade, 0)
)
excedente_medio_atual

# Compara políticas alternativas de capacidade.
capacidades <- c(25, 30, 35, 40)

# Proporção de horas em que cada capacidade fica saturada.
prob_saturacao <- c(
  mean(clientes > 25),
  mean(clientes > 30),
  mean(clientes > 35),
  mean(clientes > 40)
)

# Clientes acima da capacidade, considerando todas as horas simuladas.
excedente_medio <- c(
  mean(if_else(clientes > 25, clientes - 25, 0)),
  mean(if_else(clientes > 30, clientes - 30, 0)),
  mean(if_else(clientes > 35, clientes - 35, 0)),
  mean(if_else(clientes > 40, clientes - 40, 0))
)

# Capacidade ociosa, considerando todas as horas simuladas.
ociosidade_media <- c(
  mean(if_else(clientes < 25, 25 - clientes, 0)),
  mean(if_else(clientes < 30, 30 - clientes, 0)),
  mean(if_else(clientes < 35, 35 - clientes, 0)),
  mean(if_else(clientes < 40, 40 - clientes, 0))
)

# Organiza os resultados em uma tabela.
politicas_capacidade <- tibble(
  capacidade = capacidades,
  prob_saturacao = prob_saturacao,
  excedente_medio = excedente_medio,
  ociosidade_media = ociosidade_media
)

politicas_capacidade


# 4. Simulação normal: controle orçamentário ----------------------------
# Pergunta: quais variações percentuais de custo são plausíveis em meses comparáveis?

# Parâmetros do modelo.
mu <- 2              # variação média: 2% acima do orçamento
sigma <- 5           # desvio-padrão: 5 pontos percentuais
n_periodos <- 10000  # quantos períodos simular

# Fixa a semente para reprodutibilidade.
set.seed(123)

# Simula muitos cenários possíveis de variação percentual do custo.
variacao <- rnorm(
  n = n_periodos,
  mean = mu,
  sd = sigma
)

# Inspeção rápida dos valores simulados.
head(variacao, 5)
mean(variacao)       # deve ser próximo de 2
sd(variacao)         # deve ser próximo de 5

# Probabilidade de custo ficar mais de 10% acima do orçamento.
prob_acima_10 <- mean(variacao > 10)
prob_acima_10

# Probabilidade de custo ficar abaixo do orçamento.
prob_abaixo_orcamento <- mean(variacao < 0)
prob_abaixo_orcamento

# Faixa central de 90% das variações simuladas.
faixa_central_variacao <- quantile(variacao, c(0.05, 0.95))
faixa_central_variacao

# Compara três limites de alerta orçamentário.
limites_alerta <- c(5, 10, 15)

# Proporção de meses em que cada limite seria acionado.
prob_alerta <- c(
  mean(variacao > 5),
  mean(variacao > 10),
  mean(variacao > 15)
)

# Excedente médio acima de cada limite de alerta.
excedente_medio <- c(
  mean(if_else(variacao > 5, variacao - 5, 0)),
  mean(if_else(variacao > 10, variacao - 10, 0)),
  mean(if_else(variacao > 15, variacao - 15, 0))
)

# Organiza os resultados em uma tabela.
politicas_alerta <- tibble(
  limite_alerta = limites_alerta,
  prob_alerta = prob_alerta,
  excedente_medio = excedente_medio
)

politicas_alerta
