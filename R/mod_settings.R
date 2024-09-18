#' settings UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList sliderInput
#' @importFrom bslib card
#'
mod_settings_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    bslib::card(
      shiny::sliderInput(
        inputId = ns("slider"),
        label = "Set number of bins:",
        min = 0,
        max = 100,
        step = 1,
        value = 50
      )
    )
  )
}

#' settings Server Functions
#'
#' @importFrom shiny observeEvent req
#'
#' @noRd
mod_settings_server <- function(id, r6){
  moduleServer(id, function(input, output, session){
    ns <- session$ns

    # this will not give any plot
    # shiny::observe({
    #   shiny::req(r6)
    #
    #   r6()$changeData(data.frame(x = stats::rnorm(n = 1000)))
    # })

    shiny::observeEvent(input$slider, {
      shiny::req(r6)

      # this is a crappy solution
      if(is.null(r6()$getN())) {
        r6()$changeData(data.frame(x = stats::rnorm(n = 1000)))
      }
      print("Settings module:")
      print(paste0("Before: ", r6()$getN()))
      r6()$changeN(input$slider)
      print(paste0("After: ", r6()$getN()))
    })

  })
}
