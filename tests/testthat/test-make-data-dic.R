test_that("test-numeric", {

  #### set-up ####

  # make numeric data
  num <- tibble(num = c(2.3, 5.2, 4.8))
  num2 <- tibble(var = "Gudmedalen",
                 num = c(2.3, 5.2, 4.8))

  # make character
  char <- tibble(char = c("a", "b", "c"))

  # make data with date
  date <- tibble(date = ymd("2014-04-06", "2015-12-06", "1950-04-09"))


  # make description table
  description_table <- tibble("TableID" = c("num_ID", "char_ID", "date_ID", NA_character_),
                              "Variable name" = c("num", "char", "date", "var"),
                              Description = c("Description of numeric variable",
                                              "Description of character variable",
                                              "Sampling date",
                                              "Description of variable"),
                              "Units" = c("g", NA_character_, "yyy-mm-dd", NA_character_),
                              "How measured" = c("measured", "defined", "recorded", "recorded"))

  #make range and class outcome for all variable types
  range_num = tibble("Variable name" = "num",
                     "Variable range or levels" = c("2.3 - 5.2"))

  class_num = tibble("Variable name" = "num",
                     "Variable type" = "numeric")

  range_num2 = tibble("Variable name" = c("var", "num"),
                     "Variable range or levels" = c("Gudmedalen - Gudmedalen", "2.3 - 5.2"))

  class_num2 = tibble("Variable name" = c("var", "num"),
                     "Variable type" = c("categorical", "numeric"))

  range_char = tibble("Variable name" = "char",
                      "Variable range or levels" = "a - c")

  class_char = tibble("Variable name" = "char",
                      "Variable type" = "categorical")

  range_date = tibble("Variable name" = "date",
                      "Variable range or levels" = "1950-04-09 - 2015-12-06")

  class_date = tibble("Variable name" = "date",
                      "Variable type" = "date")

  # make outcome all
  # numeric
  outcome_num <- description_table |>
    filter(TableID == "num_ID") |>
    left_join(range_num, by = "Variable name") |>
    left_join(class_num, by = "Variable name") |>
    select(TableID, "Variable name", Description, "Variable type", "Variable range or levels", Units, "How measured")

  outcome_num2 <- description_table |>
    filter(TableID == "num_ID" | is.na(TableID)) |>
    left_join(range_num2, by = "Variable name") |>
    left_join(class_num2, by = "Variable name") |>
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



  #### test make_data_dictionary ####

  # numeric
  expect_equal(outcome_num,
               make_data_dictionary(data = num,
                                    description_table = description_table,
                                    table_ID = "num_ID",
                                    keep_table_ID = TRUE))
  # 2 variables
  # expect_equal(outcome_num2,
  #              make_data_dictionary(data = num2,
  #                                   description_table = description_table,
  #                                   table_ID = "num_ID",
  #                                   keep_table_ID = TRUE))

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
})
