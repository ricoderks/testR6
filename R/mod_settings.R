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

    shiny::observeEvent(input$slider, {
      shiny::req(r6)

      print("Settings module:")
      print(r6)
      r6$n <- input$slider
      print(r6)
    })

  })
}
