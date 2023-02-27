#' Describe the extension in a few words
#'
#' An extensive description of the extension.
#'
#' @template extension
#' @docType package
#' @name visualiseIncomeData
NULL

#' @rdname visualiseIncomeData
visualiseIncomeDataMenuItem = function(id){
    shinydashboard::menuItem(
        text = "Visualisation",
        tabName = shiny::NS(id, "visualiseIncomeData")
    )
}

#' @rdname visualiseIncomeData
visualiseIncomeDataTabItem = function(id){


    # Build the tab item
    shinydashboard::tabItem(
        tabName = shiny::NS(id, "visualiseIncomeData"),

        # Build the UI here
        # Remember to wrap all inputId statements as follows:
        # inputId = shiny::NS(id, "<myInputId>")
    )
}


#' @rdname visualiseIncomeData
visualiseIncomeDataServer = function(id){
    shiny::moduleServer(
        id = id,
        module =  function(input, output, session) {
            # Build the server here
            # There is no need to wrap inputId statements
        })
}

