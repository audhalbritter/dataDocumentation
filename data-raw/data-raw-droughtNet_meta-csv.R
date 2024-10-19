## code to prepare `data-raw/droughtNet_meta.csv` dataset goes here

durin_meta <- read_csv("data-raw/droughtNet_meta.csv")

usethis::use_data(durin_meta, overwrite = TRUE)
