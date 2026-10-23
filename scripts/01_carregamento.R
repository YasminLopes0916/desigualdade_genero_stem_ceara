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
  
  # Caminho da subpasta do ano dentro de data/raw/
  pasta_ano <- here("data", "raw", as.character(ano))
  
  # Lista os arquivos CSV na pasta (o nome pode variar entre anos)
  arquivos <- list.files(
    pasta_ano,
    pattern = "\\.CSV$|\\.csv$",   # aceita maiúsculas e minúsculas
    full.names = TRUE,
    ignore.case = TRUE
  )
  
  # Se não encontrar nenhum CSV, avisa e retorna NULL
  if (length(arquivos) == 0) {
    warning(paste("Nenhum CSV encontrado em:", pasta_ano))
    return(NULL)
  }
  
  # Se houver mais de um CSV, escolhe o que contém "CURSO" no nome
  # (os microdados do INEP trazem arquivos de IES, CURSO, ALUNO, etc.)
  arquivo_curso <- arquivos[str_detect(basename(arquivos), "CURSO")]
  
  if (length(arquivo_curso) == 0) {
    warning(paste("Nenhum arquivo de CURSO encontrado em:", pasta_ano))
    return(NULL)
  }
  
  # Lê o CSV com as configurações do INEP
  dados <- read_delim(
    arquivo_curso[1],
    delim = ";",
    locale = locale(encoding = "latin1"),
    col_types = cols(.default = "c")   # lê tudo como texto (evita notação científica)
  )
  
  # Adiciona a coluna de ano
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