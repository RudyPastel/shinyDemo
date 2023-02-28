test_that("validateIncomeData works", {

  # Missing expected column ----
  expect_error(
    object = {
    incomeDataSet = cars
    validateIncomeData(incomeDataSet)
  },
  regex = 'Required column(s) year, race, number, income_median, income_med_moe, income_mean, income_mean_moe, income_bracket, income_distribution is/are missing.',
  fixed = TRUE)

  # Wrong character column type ----
  expect_error(
    object = {
      incomeDataSet = read.table(
        sep = ',',
        quote = '"',
        header = TRUE,
        row.names = NULL,
        text = paste(
          'year,race,number,income_median,income_med_moe,income_mean,income_mean_moe,income_bracket,income_distribution',
          '2023,"Black",1,1,1,1,1,1,"Under $15,000"', sep = '\n'
        )
      )
      validateIncomeData(incomeDataSet)
    },
    regex = 'Columns race and income_bracket must be character vectors. income_bracket is not.',
    fixed = TRUE
    )

  # Wrong character numeric type  ----
  expect_error(
    object = {
      incomeDataSet = read.table(
        sep = ',',
        quote = '"',
        header = TRUE,
        row.names = NULL,
        text = paste(
          'year,race,number,income_median,income_med_moe,income_mean,income_mean_moe,income_distribution,income_bracket',
          '2023,"Black",1,1,"a",1,1,1,"Under $15,000"', sep = '\n'
        )
      )
      validateIncomeData(incomeDataSet)
    },
    regex = paste('Columns year, number, income_median, income_med_moe, income_mean, income_mean_moe, income_distribution must be numeric.',
                  'income_med_moe is not.'),
    fixed = TRUE
  )

  # Unknown income bracket ----
  expect_error(
    object = {
      incomeDataSet = read.table(
        sep = ',',
        quote = '"',
        header = TRUE,
        row.names = NULL,
        text = paste(
          'year,race,number,income_median,income_med_moe,income_mean,income_mean_moe,income_distribution,income_bracket',
          '2023,"Black",1,1,1,1,1,1,"Under EUR15,000"', sep = '\n'
        )
      )
      validateIncomeData(incomeDataSet)
    },
    regex = 'Unknown income bracket(s): Under EUR15,000.',
    fixed = TRUE
  )

  # Unknown race ----
  expect_error(
    object = {
      incomeDataSet = read.table(
        sep = ',',
        quote = '"',
        header = TRUE,
        row.names = NULL,
        text = paste(
          'year,race,number,income_median,income_med_moe,income_mean,income_mean_moe,income_distribution,income_bracket',
          '2023,"Black",1,1,1,1,1,1,"Under $15,000"', sep = '\n'
        )
      )
      validateIncomeData(incomeDataSet)
    },
    regex = 'Unknown race(s): Black.',
    fixed = TRUE
  )

  # Missing value warning ----
  expect_warning(
    object = {
      incomeDataSet = read.table(
        sep = ',',
        quote = '"',
        header = TRUE,
        row.names = NULL,
        colClasses = c(income_mean = 'numeric'),
        text = paste(
          'year,race,number,income_median,income_med_moe,income_mean,income_mean_moe,income_distribution,income_bracket',
          '2023,"Black Alone",1,1,1,NA,1,1,"Under $15,000"', sep = '\n'
        )
      )
      validateIncomeData(incomeDataSet)
    },
    regex = 'Column income_mean contains missing value(s) at index 1.',
    fixed = TRUE
  )

  # Nothing to declare ----
  expect_equal(
    object = {
      incomeDataSet = read.table(
        sep = ',',
        quote = '"',
        header = TRUE,
        row.names = NULL,
        text = paste(
          'year,race,number,income_median,income_med_moe,income_mean,income_mean_moe,income_distribution,income_bracket',
          '2023,"Black Alone",1,1,1,1,1,1,"Under $15,000"', sep = '\n'
        )
      )
      validateIncomeData(incomeDataSet)
    },
    expected = TRUE
  )

})
