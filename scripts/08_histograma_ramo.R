# ============================================================
# 08_histograma_ramo.R
# Histograma e ramo-e-folhas (OE1)
# Autora: Yasmin Lopes Teixeira
# Projeto: Desigualdade de Gênero em STEM no Ceará (2010-2022)
# ============================================================

library(tidyverse)
library(here)

# --- 1. Carregar os dados ---
ceara_final <- readRDS(here("data", "processed", "ceara_final.rds"))

# --- 2. Histograma geral (todos os cursos) ---
hist_geral <- ceara_final |> 
  ggplot(aes(x = prop_fem)) +
  geom_histogram(bins = 30, fill = "steelblue", color = "white") +
  geom_vline(aes(xintercept = mean(prop_fem)), color = "red", linetype = "dashed") +
  geom_vline(aes(xintercept = median(prop_fem)), color = "darkgreen", linetype = "dashed") +
  labs(
    title = "Distribuição da proporção de mulheres nos cursos STEM do Ceará",
    subtitle = "2010-2022 (linhas: média em vermelho, mediana em verde)",
    x = "Proporção de mulheres (%)",
    y = "Frequência"
  ) +
  theme_minimal()

print(hist_geral)
ggsave(here("output", "figures", "histograma_geral.png"), hist_geral, width = 8, height = 5, dpi = 300)

# --- 3. Histograma por categoria (facets) ---
hist_categoria <- ceara_final |> 
  ggplot(aes(x = prop_fem)) +
  geom_histogram(bins = 20, fill = "steelblue", color = "white") +
  facet_wrap(~ categoria_stem, ncol = 2, scales = "free_y") +
  labs(
    title = "Distribuição da proporção de mulheres por categoria STEM",
    subtitle = "Ceará, 2010-2022",
    x = "Proporção de mulheres (%)",
    y = "Frequência"
  ) +
  theme_minimal()

print(hist_categoria)
ggsave(here("output", "figures", "histograma_categoria.png"), hist_categoria, width = 10, height = 7, dpi = 300)

# --- 4. Ramo-e-folhas (subamostra: Computação/TI Presencial) ---
# O stem() gera saída no console (não é gráfico).
cat("\n--- Ramo-e-folhas: Computação/TI Presencial ---\n")
ceara_final |> 
  filter(categoria_stem == "Computação/TI", modalidade_agregada == "Presencial") |> 
  pull(prop_fem) |> 
  stem(scale = 1)

# --- 5. Ramo-e-folhas (subamostra: Computação/TI Presencial, 2022) ---
cat("\n--- Ramo-e-folhas: Computação/TI Presencial (2022) ---\n")
ceara_final |> 
  filter(categoria_stem == "Computação/TI", modalidade_agregada == "Presencial", ano == 2022) |> 
  pull(prop_fem) |> 
  stem(scale = 1)

# --- 6. Histograma da subamostra (Computação/TI Presencial) ---
hist_sub <- ceara_final |> 
  filter(categoria_stem == "Computação/TI", modalidade_agregada == "Presencial") |> 
  ggplot(aes(x = prop_fem)) +
  geom_histogram(bins = 15, fill = "steelblue", color = "white") +
  geom_vline(aes(xintercept = mean(prop_fem)), color = "red", linetype = "dashed") +
  geom_vline(aes(xintercept = median(prop_fem)), color = "darkgreen", linetype = "dashed") +
  labs(
    title = "Distribuição da proporção de mulheres: Computação/TI Presencial",
    subtitle = "Ceará, 2010-2022 (linhas: média em vermelho, mediana em verde)",
    x = "Proporção de mulheres (%)",
    y = "Frequência"
  ) +
  theme_minimal()

print(hist_sub)
ggsave(here("output", "figures", "histograma_computacao_presencial.png"), hist_sub, width = 8, height = 5, dpi = 300)