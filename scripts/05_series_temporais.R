# ============================================================
# 05_series_temporais.R
# Séries temporais (OE2): evolução da proporção de mulheres por ano
# Autora: Yasmin Lopes Teixeira
# Projeto: Desigualdade de Gênero em STEM no Ceará (2010-2022)
# ============================================================

library(tidyverse)
library(here)

ceara_final <- readRDS(here("data", "processed", "ceara_final.rds"))

# --- 1. Série temporal por categoria e modalidade (ponderada) ---
serie_ponderada <- ceara_final |> 
  group_by(ano, categoria_stem, modalidade_agregada) |> 
  summarise(
    n_cursos = n(),
    total_matriculas = sum(QT_MAT),
    prop_fem = sum(QT_MAT_FEM) / sum(QT_MAT) * 100,
    .groups = "drop"
  )

print(serie_ponderada, n = 100)

# --- 2. Série temporal por categoria e modalidade (não ponderada) ---
serie_nao_ponderada <- ceara_final |> 
  group_by(ano, categoria_stem, modalidade_agregada) |> 
  summarise(
    n_cursos = n(),
    media = mean(prop_fem),
    mediana = median(prop_fem),
    .groups = "drop"
  )

print(serie_nao_ponderada, n = 100)

# --- 3. Salvar as séries em CSV ---
write_csv(serie_ponderada, here("output", "serie_ponderada.csv"))
write_csv(serie_nao_ponderada, here("output", "serie_nao_ponderada.csv"))

# --- 4. Análise de robustez: núcleo estável (D7) ---
rotulos_estaveis <- ceara_final |> 
  group_by(CO_CINE_ROTULO) |> 
  summarise(n_anos = n_distinct(ano)) |> 
  filter(n_anos == 13) |> 
  pull(CO_CINE_ROTULO)

serie_estavel <- ceara_final |> 
  filter(CO_CINE_ROTULO %in% rotulos_estaveis) |> 
  group_by(ano, categoria_stem, modalidade_agregada) |> 
  summarise(
    n_cursos = n(),
    total_matriculas = sum(QT_MAT),
    prop_fem = sum(QT_MAT_FEM) / sum(QT_MAT) * 100,
    .groups = "drop"
  )

serie_estavel |> 
  filter(categoria_stem == "Computação/TI") |> 
  print(n = 100)

write_csv(serie_estavel, here("output", "serie_estavel.csv"))