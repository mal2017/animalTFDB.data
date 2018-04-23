# Import animalTFDB data

library(tidyverse)

site <- "http://bioinfo.life.hust.edu.cn/AnimalTFDB/download_index/"
file <- "Homo_sapiens_transcription_factors_gene_list.txt"
url <- paste0(site,file)

raw_tfdb <- read_tsv(url)
