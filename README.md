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
```
---

## Fonte dos dados

Os dados utilizados são provenientes do **Censo da Educação Superior**, realizado pelo Instituto Nacional de Estudos e Pesquisas Educacionais Anísio Teixeira (INEP).

... (restante do texto normal, com os ## e **)

---

## Autoria e vínculo institucional

- **Autora:** Yasmin Lopes Teixeira
- **Orientadora:** Profa. Maria Jacqueline Batista
- **Instituição:** Universidade Federal do Ceará (UFC)
- **Programa:** Iniciação Acadêmica (BIA) — PNAES/PRAE