# ============================================================
# 09_barras_empilhadas.R
# Gráfico de barras 100% empilhadas (OE4)
# Autora: Yasmin Lopes Teixeira
# Projeto: Desigualdade de Gênero em STEM no Ceará (2010-2022)
# ============================================================

library(tidyverse)
library(here)

# --- 1. Carregar os dados ---
ceara_final <- readRDS(here("data", "processed", "ceara_final.rds"))

# --- 2. Calcular a composição por categoria e modalidade ---
composicao <- ceara_final |> 
  group_by(categoria_stem, modalidade_agregada) |> 
  summarise(
    total_matriculas = sum(QT_MAT),
    matriculas_fem = sum(QT_MAT_FEM),
    matriculas_masc = sum(QT_MAT) - sum(QT_MAT_FEM),
    .groups = "drop"
  ) |> 
  mutate(
    prop_fem = matriculas_fem / total_matriculas * 100,
    prop_masc = matriculas_masc / total_matriculas * 100
  )

print(composicao)

# --- 3. Preparar os dados no formato longo (para o gráfico empilhado) ---
composicao_longo <- composicao |> 
  select(categoria_stem, modalidade_agregada, prop_fem, prop_masc) |> 
  pivot_longer(
    cols = c(prop_fem, prop_masc),
    names_to = "sexo",
    values_to = "proporcao"
  ) |> 
  mutate(
    sexo = if_else(sexo == "prop_fem", "Mulheres", "Homens")
  )

# --- 4. Gráfico de barras 100% empilhadas ---
grafico_empilhado <- composicao_longo |> 
  ggplot(aes(x = categoria_stem, y = proporcao, fill = sexo)) +
  geom_col(position = "fill") +
  facet_wrap(~ modalidade_agregada, ncol = 1) +
  scale_fill_manual(values = c("Mulheres" = "#E64B35", "Homens" = "#4DBBD5")) +
  scale_y_continuous(labels = scales::percent_format(scale = 1)) +
  labs(
    title = "Composição de matrículas por sexo, categoria e modalidade",
    subtitle = "Ceará, 2010-2022",
    x = "Categoria",
    y = "Proporção de matrículas (%)",
    fill = "Sexo"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.position = "bottom"
  )

print(grafico_empilhado)
ggsave(
  here("output", "figures", "barras_empilhadas.png"),
  grafico_empilhado,
  width = 10, height = 8, dpi = 300
)

# --- 5. Salvar a tabela de composição em CSV ---
write_csv(composicao, here("output", "composicao_sexo_categoria.csv"))