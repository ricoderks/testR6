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
      # shiny::req(r6)  # plot is not updating
      shiny::req(r6$n)  # plot is not updating
      # for some reason it doesn't see that r6$n gets updated in the settings module


      my_data <- data.frame(x = stats::rnorm(n = 1000))

      print("Viz module")
      print(r6)

      my_data |>
        ggplot2::ggplot(ggplot2::aes(x = .data$x)) +
        ggplot2::geom_histogram(bins = r6$n)
    })

  })
}
