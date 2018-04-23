# Import animalTFDB data

library(tidyverse)
library(magrittr)

# 180423 -----------------------------------------------------------
site <- "http://bioinfo.life.hust.edu.cn/AnimalTFDB/download_index/"
file <- "Homo_sapiens_transcription_factors_gene_list.txt"
url <- paste0(site,file)
animaltfdb.180423 <- read_tsv(url)
animaltfdb.180423 %<>% set_tidy_names(syntactic = T)
devtools::use_data(animaltfdb.180423)
