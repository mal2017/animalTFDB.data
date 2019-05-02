# Import humanTFDB data

library(tidyverse)
library(magrittr)
library(Organism.dplyr)

url <- "http://bioinfo.life.hust.edu.cn/static/AnimalTFDB3/download/Homo_sapiens_TF_cofactors"
src <- src_organism("TxDb.Hsapiens.UCSC.hg19.knownGene")


# 190312 human tfs ------------------------------------------------------
tfs <- read_tsv(url) %>%
  set_tidy_names(syntactic = T)

humantfdb.cofacs.190502 <- tbl(src, "id") %>%
  collect() %>%
  inner_join(.,tfs, by=c("entrez"="Entrez.ID"))

devtools::use_data(humantfdb.cofacs.190502)
