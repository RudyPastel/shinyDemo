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
      plotOutput(outputId = NS(id,'plot'))
    )
  )
}

#' @rdname visualiseIncomeDataSelectionUi
visualiseIncomeDataPlotServer  = function(id){
  moduleServer(
    id = id,
    module = function(input, output, session){

      # Get the income data set
      incomeDataSet = reactive({getIncomeDataSet()})

      # Build the option menu
      output$option = renderUI({
        if (input$selection %in% c('medianIncome', 'meanIncome')){
          ui = radioButtons(inputId = session$ns('includeMarginOfError'),
                            label = 'Include Margin of error',
                            choices = list('Yes' = TRUE, 'No' = FALSE),
                            inline = TRUE,
                            selected = FALSE)
        } else if (input$selection %in% c('incomeDistribution')) {
          ui = sliderInput(inputId = session$ns('selectedYear'),
                           label = "Year",
                           min = min(incomeDataSet()[['year']]),
                           max = max(incomeDataSet()[['year']]),
                           value = median(unique(incomeDataSet()[['year']]), na.rm = TRUE),
                           step = 1,
                           sep = '',
                           animate = animationOptions(interval = 100)
                           )
        }else {
          ui = NULL
        }
        return(ui)
      })

      # Build the plot
      output$plot = renderPlot({
        plot(cars)
      })
    })


}
