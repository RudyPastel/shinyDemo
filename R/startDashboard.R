#' Start the dashboard
#'
#' To modify the dashboard, expend on [startDashboard()], [dashboardUi()] and [dashboardServer()].
#'
#' @inheritParams shiny::shinyApp
#'
#' @export
#'
startDashboard = function(
  onStart = NULL,
  options = list(),
  uiPattern = "/",
  enableBookmarking = NULL){

  shiny::shinyApp(
    ui = dashboardUi(),
    server = dashboardServer(),
    onStart = onStart,
    options = options,
    uiPattern = uiPattern,
    enableBookmarking = enableBookmarking
  )
}

#' Create the dashboard's UI
#'
#' [dashboardUi()] combines  all the UI elements used in the dashboard into
#' the `ui` object expected by [shiny::shinyApp()].
#'
#' @return
#'
#' The UI definition of the app (for example, a call to fluidPage() with nested controls).
dashboardUi = function(){
  shinydashboard::dashboardPage(
    header = shinydashboard::dashboardHeader(
      title = sprintf(fmt = 'Income Distribution in USA (V %s)', utils::packageVersion(pkg = 'shinyDemo')),
      titleWidth = '100%'
    ),
    sidebar = shinydashboard::dashboardSidebar(
      shinydashboard::sidebarMenu(

      )
    ),
    body = shinydashboard::dashboardBody(
      shinydashboard::tabItems(

      )
    )
  )
}

#' Create the dashboard's server
#'
#' [dashboardServer()] defines the logic of the dashboard and is to be passed to [shiny::shinyApp()]
#' as its `server` argument.
#'
#'
#' @return
#'
#' The UI definition of the app (for example, a call to fluidPage() with nested controls).
dashboardServer = function(){
 serverFunction = function(input, output, session) {

 }
 return(serverFunction)
}


