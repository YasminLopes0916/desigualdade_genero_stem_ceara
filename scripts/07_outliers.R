# ============================================================
# 07_outliers.R
# Identificação de valores atípicos (OE5)
# Critério: Bussab & Morettin (limites de 1,5 x IQR)
# Autora: Yasmin Lopes Teixeira
# Projeto: Desigualdade de Gênero em STEM no Ceará (2010-2022)
# ============================================================

library(tidyverse)
library(here)

# --- 1. Carregar os dados de cursos ---
ceara_final <- readRDS(here("data", "processed", "ceara_final.rds"))

# --- 2. Ler os arquivos de IES de todos os anos (para trazer NO_IES) ---
ler_ies <- function(ano) {
  pasta_ano <- here("data", "raw", as.character(ano))
  
  arquivos <- list.files(
    pasta_ano,
    full.names = TRUE,
    recursive = TRUE,
    ignore.case = TRUE
  )
  
  # Aceita os dois padrões de nome: CADASTRO_IES (2010-2021) e ED_SUP_IES (2022)
  arquivo_ies <- arquivos[str_detect(basename(arquivos), "CADASTRO_IES|ED_SUP_IES")]
  
  if (length(arquivo_ies) == 0) {
    warning(paste("Nenhum arquivo de IES encontrado em:", pasta_ano))
    return(NULL)
  }
  
  read_delim(
    arquivo_ies[1],
    delim = ";",
    locale = locale(encoding = "latin1"),
    col_types = cols(.default = "c")
  ) |> 
    select(CO_IES, NO_IES) |> 
    mutate(ano = ano)
}

# Empilha todos os anos e remove duplicatas (mantém o nome mais recente de cada IES)
ies <- map_dfr(2010:2022, ler_ies) |> 
  arrange(desc(ano)) |> 
  distinct(CO_IES, .keep_all = TRUE) |> 
  select(CO_IES, NO_IES)

# --- 3. Calcular os limites por categoria e modalidade ---
limites <- ceara_final |> 
  group_by(categoria_stem, modalidade_agregada) |> 
  summarise(
    q1 = quantile(prop_fem, 0.25, na.rm = TRUE),
    q3 = quantile(prop_fem, 0.75, na.rm = TRUE),
    iqr = q3 - q1,
    li = q1 - 1.5 * iqr,
    ls = q3 + 1.5 * iqr,
    .groups = "drop"
  )

print(limites, n = 20)

# --- 4. Identificar os outliers ---
outliers <- ceara_final |> 
  left_join(limites, by = c("categoria_stem", "modalidade_agregada")) |> 
  filter(prop_fem < li | prop_fem > ls) |> 
  mutate(
    tipo_outlier = if_else(prop_fem < li, "Inferior (poucas mulheres)", "Superior (muitas mulheres)"),
    limite_excedido = if_else(prop_fem < li, li, ls),
    diferenca_pp = if_else(prop_fem < li, li - prop_fem, prop_fem - ls)
  ) |> 
  left_join(ies, by = "CO_IES") |> 
  select(
    ano, NO_IES, NO_CURSO, categoria_stem, modalidade_agregada,
    QT_MAT, QT_MAT_FEM, prop_fem, li, ls, tipo_outlier, limite_excedido, diferenca_pp
  ) |> 
  arrange(desc(diferenca_pp))

print(outliers, n = 50)

# --- 5. Resumo dos outliers ---
resumo_outliers <- outliers |> 
  count(categoria_stem, modalidade_agregada, tipo_outlier, sort = TRUE)

print(resumo_outliers, n = 20)

# --- 6. Salvar as tabelas em CSV ---
write_csv(limites, here("output", "limites_outliers.csv"))
write_csv(outliers, here("output", "outliers_ceara.csv"))
write_csv(resumo_outliers, here("output", "resumo_outliers.csv"))