test_that("plotIncomeDistribution works", {
  expect_equal(
    object = {
      thePlot = plotIncomeDistribution(year = 2019)
      "ggplot" %in% class(thePlot)
    },
    expected = TRUE)
})


test_that("plotIncomeMedian works", {
  expect_equal(
    object = {
      thePlot = plotIncomeMedian(includeMarginOfError = TRUE)
      "ggplot" %in% class(thePlot)
    },
    expected = TRUE)
})

test_that("plotIncomeMean works", {
  expect_equal(
    object = {
      thePlot = plotIncomeMean(includeMarginOfError = TRUE)
      "ggplot" %in% class(thePlot)
    },
    expected = TRUE)
})

test_that("plotHouseholdNumber works", {
  expect_equal(
    object = {
      thePlot = plotHouseholdNumber()
      "ggplot" %in% class(thePlot)
    },
    expected = TRUE)
})

test_that("plotPlaceHolder works", {
  expect_equal(
    object = {
      thePlot = plotPlaceHolder()
      "ggplot" %in% class(thePlot)
    },
    expected = TRUE)
})
