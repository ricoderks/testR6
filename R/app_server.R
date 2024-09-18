#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  r6 <- testR6$new(name = "test1")$reactive()

  # this will not give any plot
  # shiny::observe({
  #   shiny::req(r6)
  #
  #   r6()$changeData(data.frame(x = stats::rnorm(n = 1000)))
  # })

  mod_settings_server(id = "settings",
                      r6 = r6)

  mod_viz_server(id = "viz1",
                 r6 = r6)
  mod_viz_server(id = "viz2",
                 r6 = r6)
}
