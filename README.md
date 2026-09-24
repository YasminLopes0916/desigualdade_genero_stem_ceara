# Desigualdade de Gênero nos Cursos de Exatas e Tecnologia no Ceará
### Uma Análise Exploratória dos Dados do INEP (2010–2024)

![UFC](https://img.shields.io/badge/UFC-Estatística-blue)
![Status](https://img.shields.io/badge/status-em%20desenvolvimento-yellow)
![Linguagem](https://img.shields.io/badge/linguagem-R-276DC3)

---

## 📋 Sobre o projeto

Este repositório contém os scripts e dados processados referentes ao artigo
científico produzido com base na disciplina de **Análise Exploratória de
Dados (AED)** do curso de **Bacharelado em Estatística da UFC**, como parte
do projeto *Estatística em Diversas Áreas de Atuação*.

A pesquisa investiga a participação feminina nos cursos de Computação/TI,
Matemática e Estatística nas instituições de ensino superior do Ceará entre
2010 e 2024, comparando esse panorama com os demais estados do Nordeste
e com a média nacional.

---

## ❓ Pergunta de Pesquisa

> Como se configura a participação feminina nos cursos de Computação/TI,
> Matemática e Estatística nas IES do Ceará entre 2010 e 2024, e de que
> forma esse cenário se compara aos demais estados do Nordeste e à média
> nacional?

---

## 🗂️ Estrutura do Repositório   desigualdade-genero-stem-ceara/
├── data/
│ ├── raw/ # Microdados brutos do INEP (não versionados)
│ └── processed/ # Dados tratados e filtrados
├── scripts/
│ ├── 01_carregamento.R
│ ├── 02_limpeza.R
│ ├── 03_descritiva.R
│ └── 04_visualizacoes.R
├── output/
│ └── figures/ # Gráficos exportados
├── docs/
│ └── dicionario_variaveis.md
└── README.md

## 🗄️ Fonte dos Dados

Os microdados utilizados são do **Censo da Educação Superior** do INEP
(Instituto Nacional de Estudos e Pesquisas Educacionais Anísio Teixeira),
disponíveis publicamente em:
🔗 https://www.gov.br/inep/pt-br/acesso-a-informacao/dados-abertos/microdados/censo-da-educacao-superior

> Os arquivos brutos não estão versionados neste repositório devido ao
> tamanho. Faça o download diretamente no portal do INEP.

---

## 🛠️ Ferramentas

- **Linguagem:** R
- **Pacotes:** tidyverse, readr, ggplot2, dplyr

---

## 👩‍🔬 Autoria

- **Autora:** Yasmin Lopes Teixeira
- **Orientadora:** Profa. Maria Jacqueline Batista
- **Instituição:** Universidade Federal do Ceará (UFC)
- **Programa:** Iniciação Acadêmica (BIA) — PNAES/PRAE
