#' Make data dictionary directory and description file
#' @description Function to make a new directory for the data dictionary directory and a template for the description file. This function should be run first, before making a data dictionary. It only has to be run once.
#' @param path path file for creating directory for data dictionary
#'
#' @return a directory and a empty description table
#'
#' @importFrom tibble tibble
#' @importFrom readr write_csv
#'
#' @examples
#' temp <- tempdir()
#' get_started(path = temp)
#'
#' @export
#'

# A function to create a directory and
get_started <- function(path = "data_dic"){

  # create a directory data dic
  dir.create(path)

  # make template for description table
  description_table <- tibble(TableID = character(),
           Variable_name = character(),
           Description = character(),
           Unit = character(),
           "How measured" = character())

  # write table
  write_csv(x = description_table, file = paste0(path, "/description_table.csv"))

}
