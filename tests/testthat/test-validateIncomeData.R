test_that("validateIncomeData works", {
  expect_error(
    object = {
    incomeDataSet = cars
    validateIncomeData(incomeDataSet)
  },
  regex = 'Required column(s) year, race, number, income_median, income_med_moe, income_mean, income_mean_moe, income_bracket, income_distribution is/are missing.',
  fixed = TRUE)

  expect_error(
    object = {
      incomeDataSet = cars
      validateIncomeData(incomeDataSet)
    },
    regex = 'Required column(s) year, race, number, income_median, income_med_moe, income_mean, income_mean_moe, income_bracket, income_distribution is/are missing.',
    fixed = TRUE
    )

})
