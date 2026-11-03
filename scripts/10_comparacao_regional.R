# ============================================================
# 10_comparacao_regional.R
# Comparação regional (OE3): Ceará vs. Nordeste vs. Brasil
# Autora: Yasmin Lopes Teixeira
# Projeto: Desigualdade de Gênero em STEM no Ceará (2010-2022)
# ============================================================

library(tidyverse)
library(here)

# --- 1. Carregar o dataframe com todos os estados ---
cursos <- readRDS(here("data", "processed", "cursos_com_categoria.rds"))

# --- 2. Aplicar os filtros (áreas 05/06/07, mínimo 10 matrículas, agregação de Matemática) ---
# Converter colunas numéricas
cursos <- cursos |> 
  mutate(
    QT_MAT = as.numeric(QT_MAT),
    QT_MAT_FEM = as.numeric(QT_MAT_FEM)
  )

# Filtrar as áreas 05/06/07 e as UFs do Nordeste + Brasil
# Códigos IBGE das UFs do Nordeste: 21 (MA), 22 (PI), 23 (CE), 24 (RN), 25 (PB), 26 (PE), 27 (AL), 28 (SE), 29 (BA)
ufs_nordeste <- c("21", "22", "23", "24", "25", "26", "27", "28", "29")

dados_uf <- cursos |> 
  filter(
    !is.na(categoria_stem),
    CO_UF %in% ufs_nordeste | is.na(CO_UF),  # inclui Brasil (CO_UF NA)
    QT_MAT >= 10
  ) |> 
  mutate(
    modalidade_agregada = if_else(categoria_stem == "Matemática", "Matemática (EaD + Presencial)", 
                                   if_else(TP_MODALIDADE_ENSINO == "1", "Presencial", "EaD"))
  )

# --- 3. Calcular a proporção por UF, categoria, modalidade e ano ---
serie_uf <- dados_uf |> 
  group_by(ano, CO_UF, categoria_stem, modalidade_agregada) |> 
  summarise(
    total_matriculas = sum(QT_MAT),
    prop_fem = sum(QT_MAT_FEM) / sum(QT_MAT) * 100,
    .groups = "drop"
  )

# --- 4. Criar a tabela cruzada (UFs nas linhas, anos nas colunas) ---
# Para Computação/TI Presencial (como exemplo)
tabela_cruzada <- serie_uf |> 
  filter(categoria_stem == "Computação/TI", modalidade_agregada == "Presencial") |> 
  select(ano, CO_UF, prop_fem) |> 
  pivot_wider(names_from = ano, values_from = prop_fem)

print(tabela_cruzada)

# --- 5. Gráfico de linhas múltiplas (Ceará vs. Nordeste vs. Brasil) ---
# Calcular o Brasil (soma de todas as UFs + linhas sem UF)
serie_brasil <- dados_uf |> 
  group_by(ano, categoria_stem, modalidade_agregada) |> 
  summarise(
    total_matriculas = sum(QT_MAT),
    prop_fem = sum(QT_MAT_FEM) / sum(QT_MAT) * 100,
    .groups = "drop"
  ) |> 
  mutate(regiao = "Brasil")

# Calcular o Ceará e o Nordeste (sem Ceará)
serie_regional <- dados_uf |> 
  filter(CO_UF %in% c("21", "22", "23", "24", "25", "26", "27", "28", "29")) |> 
  mutate(
    regiao = if_else(CO_UF == "23", "Ceará", "Nordeste (sem Ceará)")
  ) |> 
  group_by(ano, regiao, categoria_stem, modalidade_agregada) |> 
  summarise(
    total_matriculas = sum(QT_MAT),
    prop_fem = sum(QT_MAT_FEM) / sum(QT_MAT) * 100,
    .groups = "drop"
  )

# Empilhar as três regiões
serie_regional_completa <- bind_rows(serie_regional, serie_brasil)

# Gráfico para Computação/TI Presencial
grafico_regional <- serie_regional_completa |> 
  filter(categoria_stem == "Computação/TI", modalidade_agregada == "Presencial") |> 
  ggplot(aes(x = ano, y = prop_fem, color = regiao)) +
  geom_line(linewidth = 1) +
  geom_point(size = 2) +
  labs(
    title = "Evolução da proporção de mulheres em Computação/TI Presencial",
    subtitle = "Ceará vs. Nordeste (sem Ceará) vs. Brasil",
    x = "Ano",
    y = "Proporção de mulheres (%)",
    color = "Região"
  ) +
  theme_minimal()

print(grafico_regional)
ggsave(here("output", "figures", "grafico_regional_computacao.png"), grafico_regional, width = 10, height = 6, dpi = 300)
# --- 6. Salvar as tabelas em CSV ---
write_csv(serie_uf, here("output", "serie_por_uf.csv"))
write_csv(tabela_cruzada, here("output", "tabela_cruzada_computacao.csv"))
write_csv(serie_regional, here("output", "serie_regional.csv"))

# --- 7. Gráficos adicionais para Engenharia e Outros STEM (Presencial) ---

# Função auxiliar para gerar o gráfico de uma categoria
gerar_grafico_regional <- function(cat, mod, nome_arquivo, titulo) {
  grafico <- serie_regional_completa |> 
    filter(categoria_stem == cat, modalidade_agregada == mod) |> 
    ggplot(aes(x = ano, y = prop_fem, color = regiao)) +
    geom_line(linewidth = 1) +
    geom_point(size = 2) +
    labs(
      title = titulo,
      subtitle = "Ceará vs. Nordeste (sem Ceará) vs. Brasil",
      x = "Ano",
      y = "Proporção de mulheres (%)",
      color = "Região"
    ) +
    theme_minimal()
  
  print(grafico)
  ggsave(here("output", "figures", nome_arquivo), grafico, width = 10, height = 6, dpi = 300)
}

# Engenharia Presencial
gerar_grafico_regional(
  cat = "Engenharia",
  mod = "Presencial",
  nome_arquivo = "grafico_regional_engenharia.png",
  titulo = "Evolução da proporção de mulheres em Engenharia Presencial"
)

# Outros STEM Presencial
gerar_grafico_regional(
  cat = "Outros STEM",
  mod = "Presencial",
  nome_arquivo = "grafico_regional_outros_stem.png",
  titulo = "Evolução da proporção de mulheres em Outros STEM Presencial"
)