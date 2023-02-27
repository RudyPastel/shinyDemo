#' @param id The identifier string linking the [triplet] of functions together.
#'
#'
#' @return
#'
#' These functions are to be used in [dashboardUi()] and [dashboardServer()] with the *same* value of `id`.
#'
#' *  `MenuItem(id)`: is called in [dashboardUi()] to create an argument to [shinydashboard::sidebarMenu()].
#' *  `TabItem(id)` : is called in [dashboardUi()] to create an argument to [shinydashboard::tabItems()].
#' *  `Server(id)`  : is called in [dashboardServer()].
#'
#' To know more about how to use these functions, read the documentation of the
#' [triplet].
#'
#' @family extensions
