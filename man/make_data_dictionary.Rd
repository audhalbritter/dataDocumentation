% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/make_data_dic.R
\name{make_data_dictionary}
\alias{make_data_dictionary}
\title{Make data dictionary}
\usage{
make_data_dictionary(data, description_table, table_ID, keep_table_ID = FALSE)
}
\arguments{
\item{data}{dataset for making data dictionary}

\item{description_table}{a table with additional information inlcuding variable name, description, unit and how variable was measured.}

\item{table_ID}{if duplicated variable names across datasets, this variable can specify the dataset.}

\item{keep_table_ID}{logical; argument keep table_ID or not.
The default is keep_table_ID = FALSE. If keep_table_ID = TRUE, table_ID argument is kept.}
}
\value{
a tibble
}
\description{
Function to make a data dictionary from any dataset.
}
\examples{
data(description_table)
data(biomass)
data_dic <- make_data_dictionary(data = biomass,
                     description_table = description_table,
                     table_ID = "biomass",
                     keep_table_ID = FALSE)
}
