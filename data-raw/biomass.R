## code to prepare `biomass` dataset goes here

usethis::use_data(biomass, overwrite = TRUE)

biomass <- read_csv("data-raw/FunCaB_clean_biomass_2015-2021.csv") |>
  filter(year == 2015,
         round == 1,
         siteID %in% c("Gudmedalen", "Ulvehaugen", "Skjelingahaugen", "Lavisdalen")) |>
  select(year, siteID, blockID, plotID, treatment, removed_fg, biomass)



description_table <- readxl::read_excel("data-raw/data_description.xlsx")
