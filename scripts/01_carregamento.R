# ============================================================
# 01_carregamento.R
# Leitura dos microdados do Censo da Educação Superior (INEP)
# Período: 2010-2022
# Autora: Yasmin Lopes Teixeira
# ============================================================

# --- 1. Carregar pacotes ---
library(tidyverse)
library(here)
library(janitor)

# --- 2. Definir o vetor de anos ---
anos <- 2010:2022

# --- 3. Função de leitura para um ano ---
ler_curso <- function(ano) {
  
  pasta_ano <- here("data", "raw", as.character(ano))
  
  arquivos <- list.files(
    pasta_ano,
    full.names = TRUE,
    recursive = TRUE,
    ignore.case = TRUE
  )
  
  arquivo_curso <- arquivos[str_detect(basename(arquivos), "CURSOS")]
  
  if (length(arquivo_curso) == 0) {
    warning(paste("Nenhum arquivo de CURSOS encontrado em:", pasta_ano))
    return(NULL)
  }
  
  dados <- read_delim(
    arquivo_curso[1],
    delim = ";",
    locale = locale(encoding = "latin1"),
    col_types = cols(.default = "c")
  )
  
  # Corrigir o nome da coluna em 2020 (e em qualquer ano que tenha CO_CINE_ROTULO2)
  if ("CO_CINE_ROTULO2" %in% names(dados)) {
    dados <- dados |>
      rename(CO_CINE_ROTULO = CO_CINE_ROTULO2)
  }
  
  # Limpar aspas do código CINE (padrão do INEP desde a Nota Informativa)
  dados <- dados |>
    mutate(CO_CINE_ROTULO = str_remove_all(CO_CINE_ROTULO, '"'))
  
  dados <- dados |> mutate(ano = ano)
  
  return(dados)
}

# --- 4. Ler todos os anos e empilhar ---
cursos <- map_dfr(anos, ler_curso)

# --- 5. Inspeção inicial ---
glimpse(cursos)
dim(cursos)
names(cursos)
class(cursos$CO_CINE_ROTULO)
unique(cursos$CO_CINE_ROTULO)[1:5]
cursos |> count(ano)

# --- 6. Salvar o dataframe limpo para reutilizar ---
saveRDS(cursos, here("data", "processed", "cursos_2010_2022.rds"))