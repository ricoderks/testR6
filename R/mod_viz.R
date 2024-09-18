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
#'
#' @noRd
mod_viz_server <- function(id, r6){
  moduleServer(id, function(input, output, session){
    ns <- session$ns

    output$hist <- shiny::renderPlot({
      shiny::req(r6)  # plot is not updating

      my_data <- r6$r$data

      print("Viz module")
      print(r6$r)

      my_data |>
        ggplot2::ggplot(ggplot2::aes(x = .data$x)) +
        ggplot2::geom_histogram(bins = r6$r$n)
    })

  })
}
