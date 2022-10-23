test_that("test-make-data-dic", {

  #### set-up ####

  # make numeric data
  num <- tibble(num = c(2.3, 5.2, 4.8))

  # make character
  char <- tibble(char = c("a", "b", "c"))

  # make data with date
  date <- tibble(date = ymd("2014-04-06", "2015-12-06", "1950-04-09"))

  # two variables
  var2 <- tibble(var = "Gudmedalen",
                 num = c(2.3, 5.2, 4.8))

  # make description table
  description_table <- tibble("TableID" = c(NA_character_, "num_ID", "char_ID", "date_ID"),
                              "Variable name" = c("var", "num", "char", "date"),
                              Description = c("Description of variable",
                                              "Description of numeric variable",
                                              "Description of character variable",
                                              "Sampling date"),
                              "Units" = c(NA_character_, "g", NA_character_, "yyy-mm-dd"),
                              "How measured" = c("recorded", "measured", "defined", "recorded"))

  #make range and class outcome for all variable types
  range_num = tibble("Variable name" = "num",
                     "Variable range or levels" = c("2.3 - 5.2"))

  class_num = tibble("Variable name" = "num",
                     "Variable type" = "numeric")

  range_char = tibble("Variable name" = "char",
                      "Variable range or levels" = "a - c")

  class_char = tibble("Variable name" = "char",
                      "Variable type" = "categorical")

  range_date = tibble("Variable name" = "date",
                      "Variable range or levels" = "1950-04-09 - 2015-12-06")

  class_date = tibble("Variable name" = "date",
                      "Variable type" = "date")

  range_var2 = tibble("Variable name" = c("var", "num"),
                      "Variable range or levels" = c("Gudmedalen - Gudmedalen", "2.3 - 5.2"))

  class_var2 = tibble("Variable name" = c("var", "num"),
                      "Variable type" = c("categorical", "numeric"))

  # make outcome all
  # numeric
  outcome_num <- description_table |>
    filter(TableID == "num_ID") |>
    left_join(range_num, by = "Variable name") |>
    left_join(class_num, by = "Variable name") |>
    select(TableID, "Variable name", Description, "Variable type", "Variable range or levels", Units, "How measured")

  # categorical
  outcome_char <- description_table |>
    filter(TableID == "char_ID") |>
    left_join(range_char, by = "Variable name") |>
    left_join(class_char, by = "Variable name") |>
    select(TableID, "Variable name", Description, "Variable type", "Variable range or levels", Units, "How measured")

  # numeric
  outcome_date <- description_table |>
    filter(TableID == "date_ID") |>
    left_join(range_date, by = "Variable name") |>
    left_join(class_date, by = "Variable name") |>
    select(TableID, "Variable name", Description, "Variable type", "Variable range or levels", Units, "How measured")

  # two variables
  outcome_num2 <- description_table |>
    filter(TableID == "num_ID" | is.na(TableID)) |>
    left_join(range_var2, by = "Variable name") |>
    left_join(class_var2, by = "Variable name") |>
    select(TableID, "Variable name", Description, "Variable type", "Variable range or levels", Units, "How measured") |>
    mutate(TableID = if_else(is.na(TableID), "num_ID", TableID))

  #### test range and class ####

  # numeric
  expect_equal(range_num, get_range(num))
  expect_equal(class_num, get_class(num))

  # categorical
  expect_equal(range_char, get_range(char))
  expect_equal(class_char, get_class(char))

  # date
  expect_equal(range_date, get_range(date))
  expect_equal(class_date, get_class(date))

  #> Test passed 🥳

  #### test make_data_dictionary ####

  # numeric
  expect_equal(outcome_num,
               make_data_dictionary(data = num,
                                    description_table = description_table,
                                    table_ID = "num_ID",
                                    keep_table_ID = TRUE))

  # categorical
  expect_equal(outcome_char,
               make_data_dictionary(data = char,
                                    description_table = description_table,
                                    table_ID = "char_ID",
                                    keep_table_ID = TRUE))

  # date
  expect_equal(outcome_date,
               make_data_dictionary(data = date,
                                    description_table = description_table,
                                    table_ID = "date_ID",
                                    keep_table_ID = TRUE))

  # 2 variables
  expect_equal(outcome_num2,
               make_data_dictionary(data = var2,
                                    description_table = description_table,
                                    table_ID = "num_ID",
                                    keep_table_ID = TRUE))

  #> Test passed 🥳
})
