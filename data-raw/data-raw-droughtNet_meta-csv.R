## code to prepare `data-raw/droughtNet_meta.csv` dataset goes here

droughNet_meta <- read_csv("data-raw/droughtNet_meta.csv")

usethis::use_data(droughNet_meta, overwrite = TRUE)
