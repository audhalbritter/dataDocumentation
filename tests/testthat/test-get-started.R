test_that("multiplication works", {

  ### set up ###

  # create temporary directory
  temp <- tempdir()


  ### tests ###
  get_started(path = temp)

  # test location of description file
  test_path("temp/description_table.csv")


  # # make template for description table
  # description_table <- tibble(TableID = character(),
  #                             Variable_name = character(),
  #                             Description = character(),
  #                             Unit = character(),
  #                             "How measured" = character())
  #
  # # write table
  # write_csv(x = description_table, file = paste0(temp, "/description_table.csv"))

  #expect_snapshot_output("temp/description_table.csv")

})


