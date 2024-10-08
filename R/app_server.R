#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  r6 <- shiny::reactiveValues()

  r6 <- testR6$new(name = "test1")

  mod_settings_server(id = "settings",
                      r6 = r6)

  mod_viz_server(id = "viz",
                 r6 = r6)
}
