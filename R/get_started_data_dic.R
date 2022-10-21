#' Make data dictionary directory and description file
#' @description Function to make a new directory for the data dictionary directory and a template for the description file. This function should be run first, before making a data dictionary. It only has to be run once.
#'
#' @return a directory and a empty description table
#'
#' @importFrom tibble tibble
#' @importFrom readr write_csv
#'
#' @examples
#' get_started()
#'
#' @export
#'

# A fu
get_started <- function(){

  # create a directory data dic
  dir.create("data_dic")

  # make template for description table
  description_table <- tibble(TableID = character(),
           Variable_name = character(),
           Description = character(),
           Unit = character(),
           "How measured" = character())

  # write table
  write_csv(x = description_table, file = "data_dic/description_table.csv")


}
