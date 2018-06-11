# Import animalTFDB data

library(tidyverse)
library(magrittr)
library(Organism.dplyr)

site <- "http://bioinfo.life.hust.edu.cn/AnimalTFDB/download_index/"
src <- src_organism("TxDb.Hsapiens.UCSC.hg19.knownGene")


# 180611 tfs ------------------------------------------------------
file <- "Homo_sapiens_transcription_factors_gene_list.txt"
url <- paste0(site,file)
animaltfdb.tfs.180611 <- read_tsv(url)
animaltfdb.tfs.180611 %<>%
  set_tidy_names(syntactic = T) %>%
  rename(ensembl = "Ensembl.ID", entrez = "Entrez.ID")

tfs <- tbl(src, "id") %>%
  collect() %>%
  left_join(animaltfdb.tfs.180611, ., by = c("ensembl", "entrez")) %>%
  mutate(Type = "Transcription_Factors") %>%
  dplyr::select(Type, symbol, ensembl, entrez, alias, map)

# 180611 remodelers ------------------------------------------------------
file <- "Homo_sapiens_chromatin_remodeling_factors_gene_list.txt"
url <- paste0(site,file)
animaltfdb.remod.180611 <- read_tsv(url)
animaltfdb.remod.180611 %<>%
  set_tidy_names(syntactic = T) %>%
  rename(ensembl = "Ensembl.ID", entrez = "Entrez.ID") %>%
  mutate(entrez = as.character(entrez))

remods <- tbl(src, "id") %>%
  collect() %>%
  left_join(animaltfdb.remod.180611, ., by = c("ensembl", "entrez")) %>%
  dplyr::select(Type, symbol, ensembl, entrez, alias, map)

# 180611 cofactors ------------------------------------------------------
file <- "Homo_sapiens_transcription_co-factors_gene_list.txt"
url <- paste0(site,file)
animaltfdb.cofac.180611 <- read_tsv(url)
animaltfdb.cofac.180611 %<>%
  set_tidy_names(syntactic = T) %>%
  rename(ensembl = "Ensembl.ID", entrez = "Entrez.ID") %>%
  mutate(entrez = as.character(entrez))

cofacs <- tbl(src, "id") %>%
  collect() %>%
  left_join(animaltfdb.cofac.180611, ., by = c("ensembl", "entrez")) %>%
  dplyr::select(Type, symbol, ensembl, entrez, alias, map)

animaltfdb.180611 <- bind_rows(tfs, remods, cofacs)

devtools::use_data(animaltfdb.180611)
