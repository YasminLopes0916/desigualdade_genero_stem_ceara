# ============================================================
# 02_limpeza.R
# Harmonização da CINE e criação da categoria_stem
# Autora: Yasmin Lopes Teixeira
# Projeto: Desigualdade de Gênero em STEM no Ceará (2010-2022)
# ============================================================

# --- 1. Carregar pacotes e o dataframe ---
library(tidyverse)
library(here)

cursos <- readRDS(here("data", "processed", "cursos_2010_2022.rds"))

# --- 2. Definir a tabela de correspondência ---
# Uma linha por CO_CINE_ROTULO do recorte do Ceará (70 rótulos).
# categoria_stem: grupo principal (Computação/TI, Matemática, Engenharia, Outros STEM)
# subcategoria_stem: detalhamento dentro de Matemática e Outros STEM (para análise de sensibilidade)

tabela_categorias <- tribble(
  ~CO_CINE_ROTULO, ~categoria_stem, ~subcategoria_stem,
  
  # --- Área 05: Ciências naturais, matemática e estatística ---
  "0511B01", "Outros STEM",     "Biologia",
  "0512B02", "Outros STEM",     "Biotecnologia",
  "0521C01", "Outros STEM",     "Ciências ambientais",
  "0531Q01", "Outros STEM",     "Química",
  "0531Q02", "Outros STEM",     "Química industrial",
  "0532G02", "Outros STEM",     "Geologia",
  "0532G03", "Outros STEM",     "Geoprocessamento",
  "0532O01", "Outros STEM",     "Oceanografia",
  "0533F01", "Outros STEM",     "Física",
  "0541M01", "Matemática",      "Matemática pura",
  "0541M02", "Matemática",      "Matemática aplicada/computacional",
  "0542C01", "Matemática",      "Ciências atuariais",
  "0542E01", "Matemática",      "Estatística",
  "0588P01", "Outros STEM",     "Interdisciplinar (05)",
  
  # --- Área 06: Computação e TIC (todos entram em Computação/TI) ---
  "0612B01", "Computação/TI",   "Banco de dados",
  "0612D01", "Computação/TI",   "Defesa cibernética",
  "0612G01", "Computação/TI",   "Gestão da TI",
  "0612R01", "Computação/TI",   "Redes de computadores",
  "0613E01", "Computação/TI",   "Engenharia de software",
  "0613J01", "Computação/TI",   "Jogos digitais",
  "0614C01", "Computação/TI",   "Ciência da computação",
  "0614I01", "Computação/TI",   "Inteligência artificial",
  "0615S01", "Computação/TI",   "Segurança da informação",
  "0615S02", "Computação/TI",   "Sistemas de informação",
  "0615S03", "Computação/TI",   "Sistemas para internet",
  "0616E01", "Computação/TI",   "Engenharia de computação (DCN Computação)",
  "0616I01", "Computação/TI",   "Internet das coisas",
  "0617A01", "Computação/TI",   "Agrocomputação",
  "0617C01", "Computação/TI",   "Ciência de dados",
  "0617C02", "Computação/TI",   "Computação em biociências e saúde",
  "0617C03", "Computação/TI",   "Criação digital",
  "0688P01", "Computação/TI",   "Interdisciplinar (06)",
  
  # --- Área 07: Engenharia, produção e construção ---
  "0710E01", "Engenharia",      "Engenharia (não especificada)",
  "0711E05", "Engenharia",      "Engenharia química",
  "0712E01", "Engenharia",      "Engenharia ambiental",
  "0712E02", "Engenharia",      "Engenharia ambiental e sanitária",
  "0712G01", "Outros STEM",     "Gestão ambiental",
  "0712G02", "Outros STEM",     "Gestão de resíduos",
  "0712S01", "Engenharia",      "Saneamento ambiental",
  "0713E01", "Engenharia",      "Eletrotécnica industrial",
  "0713E02", "Engenharia",      "Energias renováveis",
  "0713E04", "Engenharia",      "Engenharia de energia",
  "0713E05", "Engenharia",      "Engenharia elétrica",
  "0714A01", "Engenharia",      "Automação industrial",
  "0714E03", "Engenharia",      "Engenharia biomédica",
  "0714E04", "Engenharia",      "Engenharia de computação (DCN Engenharia)",
  "0714E05", "Engenharia",      "Engenharia de controle e automação",
  "0714E07", "Engenharia",      "Engenharia de telecomunicações",
  "0714E08", "Engenharia",      "Engenharia eletrônica",
  "0714E09", "Engenharia",      "Engenharia mecatrônica",
  "0714M01", "Engenharia",      "Mecatrônica industrial",
  "0714T01", "Engenharia",      "Telemática",
  "0715E02", "Engenharia",      "Engenharia mecânica",
  "0715E03", "Engenharia",      "Engenharia metalúrgica",
  "0715M01", "Engenharia",      "Manutenção industrial",
  "0716S01", "Engenharia",      "Sistemas automotivos",
  "0721A01", "Outros STEM",     "Alimentos",
  "0721E01", "Engenharia",      "Engenharia de alimentos",
  "0721P04", "Outros STEM",     "Produção de cerveja",
  "0722E01", "Engenharia",      "Engenharia de materiais",
  "0724E01", "Engenharia",      "Engenharia de minas",
  "0724E02", "Engenharia",      "Engenharia de petróleo",
  "0724P01", "Outros STEM",     "Petróleo e gás",
  "0725E02", "Engenharia",      "Engenharia de produção",
  "0725P02", "Outros STEM",     "Produção industrial",
  "0731A02", "Outros STEM",     "Arquitetura e urbanismo",
  "0732C01", "Engenharia",      "Construção de edifícios",
  "0732C02", "Engenharia",      "Controle de obras",
  "0732E01", "Engenharia",      "Engenharia civil",
  "0732E05", "Engenharia",      "Estradas"
)

# --- 3. Aplicar a tabela ao dataframe ---
# left_join: mantém todas as linhas de cursos e adiciona as colunas de categoria.
# As linhas que não estiverem na tabela (cursos fora das áreas 05/06/07) ficarão com NA em categoria_stem.
cursos <- cursos |>
  left_join(tabela_categorias, by = "CO_CINE_ROTULO")

# --- 4. Verificação ---
# Quantos cursos ficaram sem categoria (NA)?
cursos |> 
  filter(is.na(categoria_stem)) |> 
  count(CO_CINE_AREA_GERAL, sort = TRUE)

# Quantos cursos por categoria (no Ceará)?
cursos |> 
  filter(CO_UF == "23") |> 
  count(categoria_stem, subcategoria_stem, sort = TRUE) |> 
  print(n = 100)

# --- 5. Salvar o dataframe com as novas colunas ---
saveRDS(cursos, here("data", "processed", "cursos_com_categoria.rds"))