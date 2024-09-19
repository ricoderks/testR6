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
        inputId = ns("slider1"),
        label = "Set number of bins:",
        min = 0,
        max = 100,
        step = 1,
        value = 10
      ),
      shiny::sliderInput(
        inputId = ns("slider2"),
        label = "Set number of bins:",
        min = 0,
        max = 100,
        step = 1,
        value = 60
      ),
      shiny::sliderInput(
        inputId = ns("slider3"),
        label = "Set number of bins:",
        min = 0,
        max = 100,
        step = 1,
        value = 33
      )
    )
  )
}

#' settings Server Functions
#'
#' @importFrom shiny observeEvent req
#'
#' @noRd
mod_settings_server <- function(id, r6, r){
  moduleServer(id, function(input, output, session){
    ns <- session$ns

    # this will not give any plot
    # shiny::observe({
    #   shiny::req(r6)
    #
    #   r6()$changeData(data.frame(x = stats::rnorm(n = 1000)))
    # })

    shiny::observeEvent(input$slider1, {
      shiny::req(r6)

      print("Settings module (slider 1):")
      print(paste0("Before: ", r6()$getN1()))
      r6()$changeN1(input$slider1)
      print(paste0("After: ", r6()$getN1()))
    })


    shiny::observeEvent(input$slider2, {
      shiny::req(r6)

      print("Settings module (slider 2):")
      print(paste0("Before: ", r6()$getN2()))
      r6()$changeN2(input$slider2)
      print(paste0("After: ", r6()$getN2()))
    })

    shiny::observeEvent(input$slider3, {
      shiny::req(r)

      print("Settings module (slider 3):")
      print(paste0("Before: ", r$n))
      r$n <- input$slider3
      print(paste0("After: ", r$n))
    })

  })
}
