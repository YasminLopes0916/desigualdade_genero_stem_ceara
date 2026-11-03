# Desigualdade de Gênero em STEM no Ceará (2010–2022)

### Uma Análise Exploratória dos Dados do INEP

![UFC](https://img.shields.io/badge/UFC-Estatística-blue)
![Status](https://img.shields.io/badge/status-conclu%C3%ADdo-brightgreen)
![Linguagem](https://img.shields.io/badge/linguagem-R-276DC3)

---

## Sobre o projeto

Este repositório reúne os scripts e os resultados da análise exploratória desenvolvida no âmbito da disciplina de **Análise Exploratória de Dados (AED)**, do curso de **Bacharelado em Estatística da Universidade Federal do Ceará (UFC)**, como parte do projeto **Estatística em Diversas Áreas de Atuação**.

O trabalho resultou em um artigo sobre a participação feminina nos cursos de **STEM** (Ciências, Tecnologia, Engenharia e Matemática) nas instituições de ensino superior do Ceará, entre **2010 e 2022**. A análise também contempla comparações com os demais estados do Nordeste e com a média nacional.

---

## Pergunta de pesquisa

> Como se configura a participação feminina nos cursos de Computação/TI, Matemática e no conjunto das áreas STEM nas instituições de ensino superior do Ceará entre 2010 e 2022, e de que forma esse cenário se compara aos demais estados do Nordeste e à média nacional?

---

## Estrutura do repositório

```text
desigualdade_genero_stem_ceara/
├── data/
│   ├── raw/                 # Microdados brutos do INEP (não versionados)
│   └── processed/           # Dados tratados e filtrados (.rds, não versionado)
├── scripts/
│   ├── 00_setup.R           # Instalação de pacotes
│   ├── 01_carregamento.R    # Leitura e empilhamento dos 13 anos
│   ├── 02_harmonizacao.R    # Correspondência CINE e criação de categorias
│   ├── 03_filtragem.R       # Filtros, corte de 10 matrículas e agregação de Matemática
│   ├── 04_descritiva.R      # Medidas-resumo (OE1)
│   ├── 05_series_temporais.R # Séries temporais e núcleo estável (OE2)
│   ├── 06_visualizacoes.R   # Gráficos (OE1, OE2, OE3, OE4)
│   ├── 07_outliers.R        # Limites e tabela de outliers (OE5)
│   ├── 08_histograma_ramo.R # Histogramas e ramo-e-folhas (OE1)
│   ├── 09_barras_empilhadas.R # Gráfico de barras 100% empilhadas (OE4)
│   └── 10_comparacao_regional.R # Comparação regional (OE3)
├── output/
│   ├── figures/             # Gráficos exportados (.png)
│   └── *.csv                # Tabelas geradas (não versionadas)
├── docs/
│   └── artigo_final.pdf     # Versão final do artigo
└── README.md
Fonte dos dados
Os dados utilizados são provenientes do Censo da Educação Superior, realizado pelo Instituto Nacional de Estudos e Pesquisas Educacionais Anísio Teixeira (INEP).

Os microdados estão disponíveis publicamente no portal oficial do INEP:
🔗 https://www.gov.br/inep/pt-br/acesso-a-informacao/dados-abertos/microdados/censo-da-educacao-superior

Os arquivos brutos não estão versionados neste repositório devido ao seu tamanho. Para reproduzir a análise a partir dos dados originais, é necessário realizar o download dos arquivos correspondentes no portal do INEP.

Período analisado: 2010–2022 (13 edições).

Tratamento dos dados: os microdados são submetidos a etapas de carregamento, harmonização, filtragem e organização, conforme documentado nos scripts disponíveis no diretório scripts/.

Decisões metodológicas principais:

Definição de STEM: UNESCO/ISCED-F 2013 (áreas CINE 05, 06 e 07).

Corte de 10 matrículas por célula Curso-IES-Ano (com análise de sensibilidade em 50).

Agregação da Matemática (EaD + Presencial) devido à oferta residual de EaD.

Unidade de análise: curso ofertado (UF do local de oferta).

Tecnologias e ferramentas
Linguagem: R (versão 4.6.1)

Ambiente de desenvolvimento: Visual Studio Code

Pacotes principais: tidyverse (dplyr, readr, ggplot2, etc.) e here

Como reproduzir a análise
Baixe os microdados do Censo da Educação Superior (2010–2022) no portal do INEP e coloque-os em data
/raw/
, organizados por ano.

Instale os pacotes necessários:

r
source("scripts/00_setup.R")
Rode os scripts na ordem:

r
source("scripts/01_carregamento.R")
source("scripts/02_harmonizacao.R")
source("scripts/03_filtragem.R")
source("scripts/04_descritiva.R")
source("scripts/05_series_temporais.R")
source("scripts/06_visualizacoes.R")
source("scripts/07_outliers.R")
source("scripts/08_histograma_ramo.R")
source("scripts/09_barras_empilhadas.R")
source("scripts/10_comparacao_regional.R")
Os resultados (figuras e tabelas) serão gerados em output/.

Nota: O arquivo data/processed/ceara_final.rds (dados processados) não está versionado. Ele é gerado pelo script 03_filtragem.R.

Autoria e vínculo institucional
Autora: Yasmin Lopes Teixeira

Orientadora: Profa. Maria Jacqueline Batista

Instituição: Universidade Federal do Ceará (UFC)

Programa: Iniciação Acadêmica (BIA) — PNAES/PRAE