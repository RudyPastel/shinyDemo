#' Describe the extension in a few words
#'
#' An extensive description of the extension.
#'
#' @template extension
#' @docType package
#' @name <tripletName>
NULL

#' @rdname <tripletName>
<tripletName>MenuItem = function(id){
    shinydashboard::menuItem(
        text = "Name of the extension as displayed in dashboard",
        tabName = shiny::NS(id, "<tripletName>")
    )
}

#' @rdname <tripletName>
<tripletName>TabItem = function(id){


    # Build the tab item
    shinydashboard::tabItem(
        tabName = shiny::NS(id, "<tripletName>"),

        # Build the UI here
        # Remember to wrap all inputId statements as follows:
        # inputId = shiny::NS(id, "<myInputId>")
    )
}


#' @rdname <tripletName>
<tripletName>Server = function(id){
    shiny::moduleServer(
        id = id,
        module =  function(input, output, session) {
            # Build the server here
            # There is no need to wrap inputId statements
        })
}

