# Arquivo: 05-lista-solucoes.R
# Autor: Prof. Washington S. da Silva
# Data: 19/05/2026
# Objetivo: Gabarito da Lista de Exercícios 5
#           Exercícios obrigatórios: Binomial e Poisson
#           Estudo complementar opcional: Normal


# Configurações globais --------------------------------------

options(digits = 5, scipen = 999)

library(tidyverse)


# Exercício 1 ------------------------------------------------
# Campanha de e-mail marketing

# Parâmetros do modelo:
# n_emails é o número de contatos realizados em cada semana.
# prob_conversao é a taxa histórica usada como estimativa de p.
# n_semanas é o número de semanas plausíveis simuladas no computador.
n_emails <- 600
prob_conversao <- 0.07
n_semanas <- 5000


# Item a) Simule 5.000 semanas de campanha --------------------

# Fixa a semente para que a simulação possa ser reproduzida.
set.seed(123)

# Simula o número de conversões em cada semana plausível.
# Cada valor do vetor conversoes representa uma semana simulada da campanha.
conversoes <- rbinom(
  n = n_semanas,
  size = n_emails,
  prob = prob_conversao
)

# Mostra os dez primeiros valores simulados.
head(conversoes, 10)


# Item b) Média, desvio-padrão e quantis 5% e 95% -------------

# Centro da distribuição: número médio de conversões por semana.
media_conversoes <- mean(conversoes)
media_conversoes

# Oscilação típica em torno da média: o desvio-padrão resume
# o quanto as semanas costumam variar.
dp_conversoes <- sd(conversoes)
dp_conversoes

# Quantis 5% e 95%: faixa central de aproximadamente 90% das semanas.
faixa_central_conversoes <- quantile(conversoes, c(0.05, 0.95))
faixa_central_conversoes


# Item c) Proporção de semanas com menos de 35 conversões -----

# Proporção de semanas com menos de 35 conversões.
# A expressão conversoes < limite retorna TRUE/FALSE; mean() calcula a proporção.
prob_baixo_desempenho <- mean(conversoes < 35)
prob_baixo_desempenho


# Item d) Proporção de semanas com 55 conversões ou mais ------

# Proporção de semanas com 55 conversões ou mais.
prob_alto_desempenho <- mean(conversoes >= 55)
prob_alto_desempenho


# Item e) Interpretação ---------------------------------------

# Interpretação:
# Com os parâmetros usados, a média simulada fica próxima de 42 conversões
# por semana, que é o valor esperado teórico 600 * 0,07.
# Na simulação, uma semana com menos de 35 conversões ocorre em cerca de 12%
# das semanas. Portanto, uma única semana abaixo desse limite ainda parece uma
# variação plausível do processo, não um sinal forte de problema por si só.
# Semanas com 55 conversões ou mais são menos frequentes (cerca de 3%), mas
# também podem ocorrer dentro da variabilidade esperada.
# O resultado ficaria mais preocupante se o baixo desempenho se repetisse por
# várias semanas ou viesse acompanhado de evidências externas.


# Exercício 2 ------------------------------------------------
# Atendimento em hora de pico

# Parâmetros do modelo:
# lambda é o número médio de clientes por hora de pico.
# capacidade é a capacidade atual da unidade por hora de pico.
# n_horas é o número de horas de pico simuladas.
lambda <- 18
capacidade <- 22
n_horas <- 10000


# Item a) Simule 10.000 horas de pico -------------------------

# Fixa a semente para que a simulação possa ser reproduzida.
set.seed(456)

# Simula muitos cenários plausíveis de atendimento em hora de pico.
# Cada valor do vetor clientes representa uma hora de pico simulada.
clientes <- rpois(
  n = n_horas,
  lambda = lambda
)

# Mostra os dez primeiros valores simulados.
head(clientes, 10)


# Item b) Média e variância simuladas -------------------------

# Média e variância simuladas.
# Na distribuição de Poisson, média e variância teóricas são iguais a lambda.
media_clientes <- mean(clientes)
media_clientes

variancia_clientes <- var(clientes)
variancia_clientes


# Item c) Proporção de horas acima da capacidade atual --------

# Proporção de horas em que a demanda excede a capacidade atual.
prob_saturacao_atual <- mean(clientes > capacidade)
prob_saturacao_atual


# Item d) Capacidade que cobre 95% das horas simuladas --------

# Capacidade que cobre aproximadamente 95% das horas simuladas.
# Esta é uma referência para dimensionar a equipe no horário de pico.
# Se esse valor ficar próximo de uma das capacidades testadas depois,
# isso reforça sua plausibilidade como política operacional.
capacidade_95 <- quantile(clientes, 0.95)
capacidade_95

# Observação:
# se o quantil não for inteiro, a capacidade operacional deve ser
# arredondada para cima, pois não é possível atender uma fração de cliente.


# Item e) Excedente médio na capacidade atual -----------------

# Clientes excedentes médios por hora na capacidade atual.
# if_else() calcula o excedente quando há saturação e zero caso contrário.
excedente_medio_atual <- mean(
  if_else(clientes > capacidade, clientes - capacidade, 0)
)
excedente_medio_atual


# Item f) Comparação das capacidades 20, 22 e 25 --------------

# Comparação de políticas de capacidade para apoiar a decisão gerencial.
capacidades <- c(20, 22, 25)

# Proporção de horas em que cada capacidade fica saturada.
prob_saturacao <- c(
  mean(clientes > 20),
  mean(clientes > 22),
  mean(clientes > 25)
)

# Excedente médio acima da capacidade, considerando todas as horas simuladas.
excedente_medio <- c(
  mean(if_else(clientes > 20, clientes - 20, 0)),
  mean(if_else(clientes > 22, clientes - 22, 0)),
  mean(if_else(clientes > 25, clientes - 25, 0))
)

# Capacidade ociosa, considerando todas as horas simuladas.
ociosidade_media <- c(
  mean(if_else(clientes < 20, 20 - clientes, 0)),
  mean(if_else(clientes < 22, 22 - clientes, 0)),
  mean(if_else(clientes < 25, 25 - clientes, 0))
)

# Organiza os resultados em uma tabela.
politicas_capacidade <- tibble(
  capacidade = capacidades,
  prob_saturacao = prob_saturacao,
  excedente_medio = excedente_medio,
  ociosidade_media = ociosidade_media
)

# Exibe a tabela usada para comparar saturação, excedente e ociosidade.
politicas_capacidade


# Item g) Interpretação ---------------------------------------

# Interpretação:
# A capacidade de 20 clientes por hora tem menor ociosidade, mas gera saturação
# elevada: cerca de 27% das horas simuladas ficam acima da capacidade.
# A capacidade atual de 22 clientes por hora reduz a saturação, mas ainda deixa
# cerca de 15% das horas simuladas acima da capacidade.
# A capacidade de 25 clientes por hora reduz a saturação para cerca de 5%, mas
# aumenta a capacidade ociosa média.
# Além disso, 25 clientes por hora coincide com o quantil de 95% da simulação,
# ou seja, atende aproximadamente 95% das horas simuladas.
# Se a prioridade for reduzir espera e preservar a qualidade do atendimento no
# pico, a capacidade de 25 parece mais adequada. Se o custo da ociosidade pesar
# mais e a unidade aceitar mais saturação, a capacidade atual de 22 também pode
# ser defendida. A simulação não decide sozinha: ela quantifica o trade-off.


# Exercício 3 (opcional) ------------------------------------
# Estudo complementar: controle orçamentário

# Esta seção resolve o exercício opcional da lista.
#
# Parâmetros do modelo:
# mu é a variação percentual média do custo em relação ao orçamento.
# sigma é o desvio-padrão dessa variação, em pontos percentuais.
# n_periodos é o número de meses plausíveis simulados no computador.
mu <- 1.5
sigma <- 4
n_periodos <- 10000

# Fixa a semente para que a simulação possa ser reproduzida.
set.seed(789)

# Simula muitos cenários plausíveis de variação percentual do custo.
# Cada valor do vetor variacao representa um mês simulado.
variacao <- rnorm(
  n = n_periodos,
  mean = mu,
  sd = sigma
)

# Média e desvio-padrão simulados.
# Esses valores devem ficar próximos dos parâmetros mu = 1,5 e sigma = 4.
media_variacao <- mean(variacao)
media_variacao

dp_variacao <- sd(variacao)
dp_variacao

# Proporção de meses com custo mais de 8% acima do orçamento.
# Esta métrica estima a frequência de estouros relevantes de orçamento.
prob_acima_8 <- mean(variacao > 8)
prob_acima_8

# Proporção de meses com custo abaixo do orçamento.
# Valores negativos indicam custo realizado menor que o custo orçado.
prob_abaixo_orcamento <- mean(variacao < 0)
prob_abaixo_orcamento

# Quantis 5% e 95%: faixa central de aproximadamente 90% dos meses.
faixa_central_variacao <- quantile(variacao, c(0.05, 0.95))
faixa_central_variacao

# Comparação de limites de alerta para investigação gerencial.
limites_alerta <- c(5, 8, 12)

# Proporção de meses em que cada limite seria acionado.
# Limites menores geram alertas mais frequentes.
prob_alerta <- c(
  mean(variacao > 5),
  mean(variacao > 8),
  mean(variacao > 12)
)

# Excedente médio acima de cada limite de alerta,
# considerando todos os meses simulados.
# if_else() registra o excesso acima do limite e zero quando não há alerta.
excedente_medio <- c(
  mean(if_else(variacao > 5, variacao - 5, 0)),
  mean(if_else(variacao > 8, variacao - 8, 0)),
  mean(if_else(variacao > 12, variacao - 12, 0))
)

# Organiza os resultados em uma tabela.
politicas_alerta <- tibble(
  limite_alerta = limites_alerta,
  prob_alerta = prob_alerta,
  excedente_medio = excedente_medio
)

politicas_alerta

# Interpretação:
# O limite de 5% aciona alertas em uma parcela relativamente alta dos meses.
# Isso pode gerar revisões frequentes demais para a equipe de gestão.
# O limite de 12% quase não aciona alertas, mas pode deixar estouros relevantes
# avançarem sem investigação.
# Como o objetivo declarado é investigar aproximadamente 5% a 10% dos meses, o
# limite de 8% é a alternativa mais compatível com esse critério nos resultados
# simulados. Como nos exercícios anteriores, a simulação não decide sozinha:
# ela quantifica a frequência dos alertas e o excedente médio para apoiar a
# escolha do limite.
