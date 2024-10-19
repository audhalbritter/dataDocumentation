#' Create funder meta data
#' @description Function to make funder meta data.
#' @param csv_output logical; argument csv_output or not.
#' The default is csv_output = FALSE. If csv_output = TRUE a csv file is produced and saved in the project directory.
#' @param filename file name for storing csv output. Default is NULL. The path is only needed i csv_output = TRUE. The file name contains FUNDER_filename.csv, where the file name is defined by the user.csv_output = TRUE a csv file is produced and saved under the path name.
#'
#' @return a tibble and optionally a csv file
#'
#' @importFrom magrittr %>%
#' @importFrom dplyr mutate
#' @importFrom tidyr crossing
#' @importFrom readr write_csv
#' @importFrom stringr str_sub
#'
#' @examples
#' create_funder_meta_data()
#'
#' @export


create_funder_meta_data <- function(csv_output = FALSE, filename = NULL){

  siteID = c("Arhelleren",
             "Alrust",
             "Fauske",
             "Gudmedalen",
             "Hogsete",
             "Lavisdalen",
             "Ovstedalen",
             "Rambera",
             "Skjelingahaugen",
             "Ulvehaugen",
             "Veskre",
             "Vikesland")

  blockID = c(1:4)

  treatment = c("C", "F", "G", "B", "FB", "GB", "GF", "FGB")

  funder_metadata <- crossing(siteID, blockID, treatment) %>%
    mutate(plotID = paste0(str_sub(siteID, 1, 3), blockID, treatment),
           blockID = paste0(str_sub(siteID, 1, 3), blockID))

  # create csv output
  if(csv_output){

    if(is.null(filename)){
      filepath <- paste0("FUNDER_", ".csv")
      write_csv(x = funder_metadata,
                file = filepath)
    } else {
      filepath <- paste0("FUNDER_", filename, ".csv")
      write_csv(x = funder_metadata,
                file = filepath)
    }

  }

  return(funder_metadata)

}
