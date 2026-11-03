# ============================================================
# 06_visualizacoes.R
# Visualizações (OE1, OE2, OE4)
# Autora: Yasmin Lopes Teixeira
# Projeto: Desigualdade de Gênero em STEM no Ceará (2010-2022)
# ============================================================

library(tidyverse)
library(here)

# --- 1. Carregar os dados ---
serie_ponderada <- read_csv(here("output", "serie_ponderada.csv"), show_col_types = FALSE)
ceara_final <- readRDS(here("data", "processed", "ceara_final.rds"))

# --- 2. Gráfico de linha: evolução por categoria ---
# Filtra apenas as categorias com série completa (Computação, Engenharia, Outros STEM)
# Matemática é agregada (EaD + Presencial), então aparece como linha única
grafico_linha <- serie_ponderada |> 
  ggplot(aes(x = ano, y = prop_fem, color = categoria_stem)) +
  geom_line(linewidth = 1) +
  geom_point(size = 2) +
  facet_wrap(~ modalidade_agregada, ncol = 1, scales = "free_y") +
  labs(
    title = "Evolução da proporção de mulheres em STEM no Ceará (2010-2022)",
    subtitle = "Por categoria e modalidade",
    x = "Ano",
    y = "Proporção de mulheres (%)",
    color = "Categoria"
  ) +
  theme_minimal() +
  theme(legend.position = "bottom")

print(grafico_linha)
ggsave(here("output", "figures", "grafico_linha.png"), grafico_linha, width = 10, height = 8, dpi = 300)

# --- 3. Boxplot: distribuição por categoria e modalidade ---
grafico_box <- ceara_final |> 
  ggplot(aes(x = categoria_stem, y = prop_fem, fill = modalidade_agregada)) +
  geom_boxplot(outlier.alpha = 0.3) +
  labs(
    title = "Distribuição da proporção de mulheres por categoria e modalidade",
    subtitle = "Ceará, 2010-2022 (cursos com 10+ matrículas)",
    x = "Categoria",
    y = "Proporção de mulheres (%)",
    fill = "Modalidade"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

print(grafico_box)
ggsave(here("output", "figures", "grafico_box.png"), grafico_box, width = 10, height = 6, dpi = 300)

# --- 4. Gráfico de barras: proporção agregada por categoria ---
grafico_barras <- ceara_final |> 
  group_by(categoria_stem, modalidade_agregada) |> 
  summarise(
    prop_fem = sum(QT_MAT_FEM) / sum(QT_MAT) * 100,
    .groups = "drop"
  ) |> 
  ggplot(aes(x = categoria_stem, y = prop_fem, fill = modalidade_agregada)) +
  geom_col(position = "dodge") +
  labs(
    title = "Proporção agregada de mulheres por categoria e modalidade",
    subtitle = "Ceará, 2010-2022",
    x = "Categoria",
    y = "Proporção de mulheres (%)",
    fill = "Modalidade"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

print(grafico_barras)
ggsave(here("output", "figures", "grafico_barras.png"), grafico_barras, width = 10, height = 6, dpi = 300)