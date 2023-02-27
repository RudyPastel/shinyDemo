#' Get income data set
#'
#' Some formatting is applied as well.
#'
#'
#' @includeRmd ./inst/documentation/dataDictionary.Rmd
#'
#' @return
#' Returns a [base::data.frame()]
getIncomeDataSet = function(){

  # Read the raw file
  filePath =  system.file(package = 'shinyDemo', 'extdata', config::get('dataset'))
  incomeDistribution <- readr::read_csv(file = filePath, show_col_types = FALSE, col_types = 'c')

  # A basic check in case the user provides a new data set
  expectedColumns = c(
    'year', 'race', 'number', 'income_median', 'income_med_moe',
    'income_mean', 'income_mean_moe', 'income_bracket', 'income_distribution'
  )
  base::stopifnot(all(expectedColumns %in% names(incomeDistribution)))

  # Format income_bracket column
  orderedBrackets = c(
    "Under $15,000",
    "$15,000 to $24,999",
    "$25,000 to $34,999",
    "$35,000 to $49,999",
    "$50,000 to $74,999",
    "$75,000 to $99,999",
    "$100,000 to $149,999",
    "$150,000 to $199,999",
    "$200,000 and over"
  )
  incomeDistribution$income_bracket = factor(
    x = incomeDistribution$income_bracket,
    levels = orderedBrackets,
    labels = orderedBrackets,
    ordered = TRUE)

  # The rest is numeric
  for (columnName in setdiff(expectedColumns, c('race', 'income_bracket'))){
    incomeDistribution[[columnName]] = as.numeric(incomeDistribution[[columnName]])
  }

  # Return the formatted data set
  return(incomeDistribution)
}
