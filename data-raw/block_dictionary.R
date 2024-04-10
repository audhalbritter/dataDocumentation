## code to prepare `data-raw/FunCab_Funder_blockID_dictionary.csv` dataset goes here

usethis::use_data(data-raw/FunCab_Funder_blockID_dictionary.csv, overwrite = TRUE)

dic <- read_csv("raw_data/FunCab_Funder_blockID_dictionary.csv")

funder <- tibble(blockID = c("Gud1", "Gud2", "Arh1", "Arh5"),
                 var = c("one", "two", "ding", "dong"),
                 treatment = c("C", "F", "FB", "FBG"))

funcab <- tibble(blockID = c("Gud5", "Gud12"),
                 var = c("tick", "tack"),
                 treatment = c("FB", "FBG"))
