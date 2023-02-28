#' Validate an income data set
#'
#' Controls that data set `incomeDataSet` fulfills the expectations of \pkg{shinyDemo}.
#' When adding a new data set, future users will have confidence that it will work.
#'
#' @param incomeDataSet
#'
#' @export
#'
#' @includeRmd ./inst/documentation/dataDictionary.Rmd
#'
#' @return Throws an error if the data set can not be used. Emits some warnings
#' in case it has some mild defects. Returns `TRUE` invisibly.
validateIncomeData = function(incomeDataSet){
  # Check that incomeDataSet is a data frame
  base::stopifnot(is.data.frame(incomeDataSet))

  # Check that required columns are presents
  expectedColumns = c(
    'year', 'race', 'number', 'income_median', 'income_med_moe',
    'income_mean', 'income_mean_moe', 'income_bracket', 'income_distribution'
  )
  missingColumn = setdiff(expectedColumns, names(incomeDataSet))
  if (length(missingColumn) > 0){
    base::stop(
      'Required column(s) ',
      paste(missingColumn, collapse = ', '),
      ' is/are missing.'
    )
  }
  base::stopifnot(all(expectedColumns %in% names(incomeDataSet)))

  # Check that columns are loaded with the expected class
  for (columnName in c('race','income_bracket')){
    if (!is.character(incomeDataSet[[columnName]])){
      base::stop(
        'Columns race and income_bracket must be character vectors. ',
        columnName, ' is not.'
      )
    }
  }

  numericColumns = setdiff(expectedColumns, c('race','income_bracket'))
  for (columnName in numericColumns){
    if (!is.numeric(incomeDataSet[[columnName]])){
      base::stop(
        sprintf(fmt = 'Columns %s must be numeric.', paste(numericColumns, collapse = ', ')),
        columnName, ' is not.'
      )
    }
  }

  # Check that required race and income_bracket categories are available.

  requiredIncomeBrackets =  c(
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
  unexpectedBracket = setdiff(incomeDataSet$income_bracket, requiredIncomeBrackets)
  if (length(unexpectedBracket) > 0 ){
    base::stop(
      'Unknown income bracket(s): ',
      paste(unexpectedBracket, collapse = ', '),
      '.'
    )
  }

  expectedRaces = c(
    "All Races",
    "White Alone",
    "White Alone, Not Hispanic",
    "Hispanic (Any Race)",
    "Asian Alone or in Combination",
    "Asian Alone",
    "Black Alone or in Combination",
    "Black Alone"
  )
  unexpectedRace = setdiff(incomeDataSet$race, expectedRaces)
  if (length(unexpectedRace) > 0 ){
    base::stop(
      'Unknown race(s): ',
      paste(unexpectedRace, collapse = ', '),
      '.'
    )
  }

  # Warn against missing data
  for (columnName in expectedColumns){
    if (any(is.na(incomeDataSet[[columnName]]))){
      base::warning(
        'Column ', columnName, ' contains missing value(s) at index ',
        paste(head(is.na(incomeDataSet[[columnName]]), 10), collapse = ', '),
        '.'
      )
    }
  }

  # Conclude
  return(invisible(TRUE))
}
