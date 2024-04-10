#' Biomass data
#'
#' A dataset containing one year of biomass data from functional group removal experiment from four alpine sites in western Norway.
#'
#' @format A tibble with 192 rows and 7 variables:
#' \describe{
#'   \item{year}{year of sampling}
#'   \item{siteID}{unique site code}
#'   \item{blockID}{unique block code}
#'   \item{plotID}{unique plot code}
#'   \item{treatment}{functional group removal treatment}
#'   \item{removed_fg}{functional group removed}
#'   \item{biomass}{biomass value in g}
#'   ...
#' }
#' @source \url{https://osf.io/4c5v2/}
"biomass"
#'
#'
#' #' Description table
#'
#' A table describing the dataset.
#'
#' @format A tibble with 192 rows and 7 variables:
#' \describe{
#'   \item{TableID}{unique code for each dataset}
#'   \item{Variable name}{variable name}
#'   \item{Description}{variable description}
#'   \item{Units}{units for variables}
#'   \item{How measured}{how a variable was measured}
#'   ...
#' }
#' @source \url{https://osf.io/4c5v2/}
"description_table"


#' #' Block dictionary
#'
#' A table block_dictionary.
#'
#' @format A tibble with 48 rows and 2 variables:
#' \describe{
#'   \item{funder_blockID}{unique code for funder blockID}
#'   \item{funcab_blockID}{unique code for funcab blockID}
#'   ...
#' }
#' @source \url{https://osf.io/4c5v2/}
"dic"


#' #' Funder
#'
#' A random Funder dataset.
#'
#' @format A tibble with 4 rows and 3 variables:
#' \describe{
#'   \item{funder_blockID}{unique code for funder blockID}
#'   \item{var}{random variable}
#'   \item{treatment}{unique code for treatement}
#'   ...
#' }
"funder"

#' #' FunCaB
#'
#' A random FunCaB dataset.
#'
#' @format A tibble with 4 rows and 3 variables:
#' \describe{
#'   \item{funder_blockID}{unique code for funder blockID}
#'   \item{var}{random variable}
#'   \item{treatment}{unique code for treatement}
#'   ...
#' }
"funcab"
NULL
