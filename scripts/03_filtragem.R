# ============================================================
# 03_filtragem.R
# Filtragem do Ceará, separação presencial/EaD e cálculo da proporção
# Autora: Yasmin Lopes Teixeira
# Projeto: Desigualdade de Gênero em STEM no Ceará (2010-2022)
# ============================================================

library(tidyverse)
library(here)

cursos <- readRDS(here("data", "processed", "cursos_com_categoria.rds"))

ceara <- cursos |> 
  filter(CO_UF == "23", !is.na(categoria_stem))

ceara <- ceara |> 
  mutate(
    modalidade = case_when(
      TP_MODALIDADE_ENSINO == "1" ~ "Presencial",
      TP_MODALIDADE_ENSINO == "2" ~ "EaD",
      TRUE ~ "Outro"
    )
  )

ceara <- ceara |> 
  mutate(
    QT_MAT      = as.numeric(QT_MAT),
    QT_MAT_FEM  = as.numeric(QT_MAT_FEM),
    QT_MAT_MASC = as.numeric(QT_MAT_MASC)
  )

ceara <- ceara |> 
  mutate(
    prop_fem = if_else(QT_MAT > 0, QT_MAT_FEM / QT_MAT * 100, NA_real_)
  )

saveRDS(ceara, here("data", "processed", "ceara_stem.rds"))