# ============================================================
# 00_setup.R
# Instalação dos pacotes necessários para o projeto
# Autora: Yasmin Lopes Teixeira
# Projeto: Desigualdade de Gênero em STEM no Ceará (2010-2022)
# ============================================================

# Execute este script apenas uma vez antes de iniciar o projeto.
# Após a instalação, os pacotes ficam disponíveis no seu R.

# Lista de pacotes necessários
pacotes <- c(
  "tidyverse",   # manipulação e visualização de dados
  "readr",       # leitura eficiente de arquivos CSV grandes
  "janitor",     # limpeza de nomes de colunas
  "skimr",       # resumo estatístico descritivo rápido
  "writexl",     # exportação de tabelas para Excel
  "here"         # caminhos relativos à raiz do projeto
)

# Verifica quais pacotes ainda não estão instalados
novos <- pacotes[!(pacotes %in% installed.packages()[, "Package"])]

# Instala apenas os que faltam
if (length(novos)) install.packages(novos)