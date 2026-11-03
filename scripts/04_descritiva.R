# ============================================================
# 04_descritiva.R
# Análise descritiva (OE1): medidas de tendência central e dispersão
# Autora: Yasmin Lopes Teixeira
# Projeto: Desigualdade de Gênero em STEM no Ceará (2010-2022)
# ============================================================

library(tidyverse)
library(here)

ceara_final <- readRDS(here("data", "processed", "ceara_final.rds"))

# --- 1. Medidas NÃO PONDERADAS (por curso) ---
# Descrevem o "curso típico": cada curso tem o mesmo peso, independentemente do tamanho.
descritiva_nao_ponderada <- ceara_final |> 
  group_by(categoria_stem, modalidade_agregada) |> 
  summarise(
    n_cursos = n(),
    media = mean(prop_fem),
    mediana = median(prop_fem),
    desvio_padrao = sd(prop_fem),
    q1 = quantile(prop_fem, 0.25),
    q3 = quantile(prop_fem, 0.75),
    min = min(prop_fem),
    max = max(prop_fem),
    .groups = "drop"
  )

print(descritiva_nao_ponderada, n = 20)

# --- 2. Medidas PONDERADAS (por matrícula) ---
# Descrevem a "estudante típica": cursos com mais matrículas têm mais peso.
descritiva_ponderada <- ceara_final |> 
  group_by(categoria_stem, modalidade_agregada) |> 
  summarise(
    n_cursos = n(),
    total_matriculas = sum(QT_MAT),
    prop_agregada = sum(QT_MAT_FEM) / sum(QT_MAT) * 100,
    .groups = "drop"
  )

print(descritiva_ponderada, n = 20)

# --- 3. Comparação entre ponderada e não ponderada ---
comparacao <- descritiva_nao_ponderada |> 
  select(categoria_stem, modalidade_agregada, n_cursos, media, mediana) |> 
  left_join(
    descritiva_ponderada |> select(categoria_stem, modalidade_agregada, prop_agregada),
    by = c("categoria_stem", "modalidade_agregada")
  )

print(comparacao, n = 20)

# --- 4. Salvar as tabelas em CSV ---
write_csv(descritiva_nao_ponderada, here("output", "descritiva_nao_ponderada.csv"))
write_csv(descritiva_ponderada, here("output", "descritiva_ponderada.csv"))
write_csv(comparacao, here("output", "comparacao_ponderada_nao_ponderada.csv"))