# Desigualdade de gênero nos cursos de Exatas e Tecnologia no Ceará
### Uma Análise Exploratória dos Dados do INEP (2010–2024)

![UFC](https://img.shields.io/badge/UFC-Estatística-blue)
![Status](https://img.shields.io/badge/status-em%20desenvolvimento-yellow)
![Linguagem](https://img.shields.io/badge/linguagem-R-276DC3)

---

## Sobre o projeto

Este repositório reúne os scripts e os dados processados utilizados na análise exploratória 
desenvolvida no âmbito da disciplina de **Análise Exploratória de Dados (AED)**, do curso de
**Bacharelado em Estatística da Universidade Federal do Ceará (UFC)**, como parte do projeto
**Estatística em Diversas Áreas de Atuação**.

O trabalho está relacionado à elaboração de um artigo sobre a participação feminina nos cursos 
de Computação/TI, Matemática e Estatística nas instituições de ensino superior do Ceará entre
2010 e 2024. A análise também contempla comparações com os demais estados do Nordeste e com a 
média nacional.

---

## Pergunta de pesquisa

> Como se configura a participação feminina nos cursos de Computação/TI, Matemática e Estatística
nas instituições de ensino superior do Ceará entre 2010 e 2024, e como esse cenário se compara ao
observado nos demais estados do Nordeste e na média nacional?

---

## Estrutura do repositório

```text
desigualdade-genero-stem-ceara/
├── data/
│   ├── raw/                 # Microdados brutos do INEP (não versionados)
│   └── processed/           # Dados tratados e filtrados
├── scripts/
│   ├── 01_carregamento.R
│   ├── 02_limpeza.R
│   ├── 03_descritiva.R
│   └── 04_visualizacoes.R
├── output/
│   └── figures/             # Gráficos exportados
├── docs/
│   └── dicionario_variaveis.md
└── README.md
```

## Fonte dos dados

Os dados utilizados são provenientes do **Censo da Educação Superior**, realizado pelo
Instituto Nacional de Estudos e Pesquisas Educacionais Anísio Teixeira (INEP).

Os microdados estão disponíveis publicamente no portal oficial do INEP:
🔗 https://www.gov.br/inep/pt-br/acesso-a-informacao/dados-abertos/microdados/censo-da-educacao-superior

Os arquivos brutos não estão versionados neste repositório devido ao seu tamanho. Para reproduzir a análise 
a partir dos dados originais, é necessário realizar o download dos arquivos correspondentes no portal do INEP.

**Período analisado:** 2010–2024.

**Tratamento dos dados:** os microdados são submetidos a etapas de carregamento, limpeza, filtragem e organização, 
conforme documentado nos scripts disponíveis no diretório scripts/.

---

## Tecnologias e ferramentas

- **Linguagem:** R
- **Ambiente de desenvolvimento:** Visual Studio Code.
- **Pacotes:** tidyverse e outros pacotes utilizados nos scripts, conforme as dependências efetivas do projeto.

---

## Autoria e vínculo institucional

- **Autora:** Yasmin Lopes Teixeira
- **Orientadora:** Profa. Maria Jacqueline Batista
- **Instituição:** Universidade Federal do Ceará (UFC)
- **Programa:** Iniciação Acadêmica (BIA) — PNAES/PRAE
