#' Dashboard extension as a function triplet
#'
#' To extend the dashboard abide by the three function pattern a.k.a. the
#' *triplet*. The extension is to be implemented as three functions that must
#' stick to the rules laid down in the section `The triplet rules`. In practice,
#' create a template file via [createTripletTemplate()] and build on it.
#'
#' @param tripletName The name of the triplet to create as a camelCase string without spaces.
#'        It will be the root of the function names.
#' @param path The path to the folder in which the template is to be created.
#'
#' @return
#'
#' [createTripletTemplate()] returns the path to the created file.
#'
#' @section The triplet rules:
#'
#' The extension `myExtension` will be embedded into the dashboard via three
#' functions. For convenience sake, build on a template created with
#' [createTripletTemplate()].
#'
#' 1. `myExtensionMenuItem(id)`
#'    * Expects the string argument `id`.
#'    * Returns result of a call to [shinydashboard::menuItem()].
#'    * All `inputId` are wrapped so: `inputId = shiny::NS(id, "myIdentifier")`
#' 1. `myExtensionTabItem(id)`
#'    * Expects the string argument `id`.
#'    * Returns result of a call to [shinydashboard::tabItem()].
#'    * All `inputId` are wrapped so: `inputId = shiny::NS(id, "myIdentifier")`
#' 1. `myExtensionServer(id)`
#'    * Expects the string argument `id`.
#'    * Returns result of a call to [shiny::moduleServer()].
#'    * `inputId` values are *not* wrapped: `myInputValue = input[['myIdentifier']]`
#'
#'
#' These functions are to be used in [dashboardUi()] and [dashboardServer()] with the *same* value of `id`.
#'
#' *  `myExtensionMenuItem(id)`: is called in [dashboardUi()] to create an argument to [shinydashboard::sidebarMenu()].
#' *  `myExtensionTabItem(id)` : is called in [dashboardUi()] to create an argument to [shinydashboard::tabItems()].
#' *  `myExtensionServer(id)`  : is called in [dashboardServer()].
#'
#' The triplet fundamentally defines a shiny module. Shiny modules are powerful
#' tools that enable way more that the triplet. For more about shiny modules,
#' peruse [shiny.rstudio.com](https://shiny.rstudio.com/articles/modules.html)
#' and [mastering-shiny.org](https://mastering-shiny.org/scaling-modules.html).
#'
#'
#' @family key objects
#' @docType package
#' @name triplet
NULL


#' @rdname triplet
#' @export
createTripletTemplate = function(tripletName, path){
  templateText = readLines(system.file(package = 'shinyDemo', 'templates', 'templateTriplet.R'))
  tripletName  = gsub(pattern = '[[:space:][:punct:]]', replacement = '', x = tripletName)
  templateText = gsub(pattern = "<tripletName>", replacement = tripletName, x = templateText)
  if (!dir.exists(path)){ dir.create(path = path, recursive = TRUE)}
  filePath = file.path(path, paste0(tripletName, '.R'))
  writeLines(text = templateText, con = filePath)
  return(filePath)
}
