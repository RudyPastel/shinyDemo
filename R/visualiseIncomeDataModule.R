#' A module to visualise the income data
#'
#' This module as three front end elements for more flexibility in the layout.
#'
#' @template id
#'
#' @return
#'
#' [visualiseIncomeDataSelectionUi()] returns a [shiny::fluidRow()].
visualiseIncomeDataSelectionUi = function(id){
  fluidRow(
    column(
      width = 12,
      selectInput(inputId = NS(id,'selection'),
                  label = 'Information',
                  choices = list(
                    'Income distribution' = 'incomeDistribution',
                    'Median income' = 'medianIncome',
                    'Mean income' = 'meanIncome',
                    'Number of households' = 'householdNumbe'
                  ),
                  selected = 'incomeDistribution')
    )
  )
}

#' @rdname visualiseIncomeDataSelectionUi
visualiseIncomeDataOptionUi  = function(id){
  fluidRow(
    column(
      width = 12,
      uiOutput(outputId = NS(id,'option'))
    )
  )
}

#' @rdname visualiseIncomeDataSelectionUi
visualiseIncomeDataPlotUi  = function(id){
  fluidRow(
    column(
      width = 12,
      uiOutput(outputId = NS(id,'plot'))
    )
  )
}

#' @rdname visualiseIncomeDataSelectionUi
visualiseIncomeDataServer  = function(id){
  moduleServer(
    id = id,
    module = function(input, output, session){

    })
}
