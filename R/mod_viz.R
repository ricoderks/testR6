#' viz UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' @importFrom bslib card
#'
mod_viz_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    bslib::card(
      shiny::plotOutput(
        outputId = ns("hist")
      )
    )
  )
}

#' viz Server Functions
#'
#' @importFrom shiny renderPlot req
#' @importFrom stats rnorm
#' @importFrom ggplot2 ggplot aes geom_histogram .data
#' @importFrom utils head
#'
#' @noRd
mod_viz_server <- function(id, r6){
  moduleServer(id, function(input, output, session){
    ns <- session$ns

    output$hist <- shiny::renderPlot({
      shiny::req(r6)

      my_data <- r6()$getData()

      print(paste0("Viz module ", id))
      print(r6()$getN())
      print(utils::head(my_data))

      my_data |>
        ggplot2::ggplot(ggplot2::aes(x = .data$x)) +
        ggplot2::geom_histogram(bins = r6()$getN())
    })

  })
}
