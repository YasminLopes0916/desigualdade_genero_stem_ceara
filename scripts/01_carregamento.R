# ============================================================
# 01_carregamento.R
# Leitura dos microdados do Censo da Educação Superior (INEP)
# Período: 2010-2022
# Autora: Yasmin Lopes Teixeira
# ============================================================

# --- 1. Carregar pacotes ---
library(tidyverse)   # inclui readr, dplyr, purrr
library(here)        # caminhos relativos à raiz do projeto
library(janitor)     # limpeza de nomes (opcional nesta etapa)

# --- 2. Definir o vetor de anos ---
anos <- 2010:2022

# --- 3. Função de leitura para um ano ---
# Recebe um ano e retorna o dataframe do arquivo CURSO daquele ano.
ler_curso <- function(ano) {
  
  # Caminho da pasta do ano (renomeada para 2010, 2011, ...)
  pasta_ano <- here("data", "raw", as.character(ano))
  
  # Lista todos os arquivos na pasta do ano, recursivamente
  # (os CSVs estão em data/raw/<ano>/dados/)
  arquivos <- list.files(
    pasta_ano,
    full.names = TRUE,
    recursive = TRUE,
    ignore.case = TRUE
  )
  
  # Filtra o arquivo que contém "CURSOS" no nome
  # (ignora md5, IES, PDFs, XLSX, etc.)
  arquivo_curso <- arquivos[str_detect(basename(arquivos), "CURSOS")]
  
  if (length(arquivo_curso) == 0) {
    warning(paste("Nenhum arquivo de CURSOS encontrado em:", pasta_ano))
    return(NULL)
  }
  
  # Lê o CSV
  dados <- read_delim(
    arquivo_curso[1],
    delim = ";",
    locale = locale(encoding = "latin1"),
    col_types = cols(.default = "c")
  )
  
  dados <- dados |> mutate(ano = ano)
  
  return(dados)
}

# --- 4. Ler todos os anos e empilhar ---
# map_dfr aplica a função a cada ano e empilha os resultados em um único dataframe
cursos <- map_dfr(anos, ler_curso)

# --- 5. Inspeção inicial ---
# Estrutura do dataframe
glimpse(cursos)

# Dimensões (linhas x colunas)
dim(cursos)

# Nomes das colunas
names(cursos)

# Verificar se CO_CINE_ROTULO veio como texto
class(cursos$CO_CINE_ROTULO)
unique(cursos$CO_CINE_ROTULO)[1:5]

# Contagem de linhas por ano (para verificar se todos os anos foram lidos)
cursos |> count(ano)