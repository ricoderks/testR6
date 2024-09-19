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
      shiny::h3(paste0("Module: ", id)),
      bslib::layout_column_wrap(
        width = 1 / 3,
        shiny::plotOutput(
          outputId = ns("hist1")
        ),
        shiny::plotOutput(
          outputId = ns("hist2")
        ),
        shiny::plotOutput(
          outputId = ns("hist3")
        )
      )
    )
  )
}

#' viz Server Functions
#'
#' @importFrom shiny renderPlot req
#' @importFrom stats rnorm
#' @importFrom ggplot2 ggplot aes geom_histogram .data labs
#' @importFrom utils head
#'
#' @noRd
mod_viz_server <- function(id, r6, r){
  moduleServer(id, function(input, output, session){
    ns <- session$ns

    output$hist1 <- shiny::renderPlot({
      shiny::req(r6)

      my_data <- r6()$getData()

      print(paste0("Viz module (slider 1): ", id))
      print(r6()$getN1())
      print(utils::head(my_data))

      my_data |>
        ggplot2::ggplot(ggplot2::aes(x = .data$x)) +
        ggplot2::geom_histogram(bins = r6()$getN1()) +
        ggplot2::labs(title = "Slider 1")
    })

    output$hist2 <- shiny::renderPlot({
      shiny::req(r6)

      my_data <- r6()$getData()

      print(paste0("Viz module (slider 2):", id))
      print(r6()$getN2())
      print(utils::head(my_data))

      my_data |>
        ggplot2::ggplot(ggplot2::aes(x = .data$x)) +
        ggplot2::geom_histogram(bins = r6()$getN2()) +
        ggplot2::labs(title = "Slider 2")
    })

    output$hist3 <- shiny::renderPlot({
      shiny::req(r)

      my_data <- r$data

      print(paste0("Viz module (slider 3):", id))
      print(r$n)
      print(utils::head(my_data))

      my_data |>
        ggplot2::ggplot(ggplot2::aes(x = .data$x)) +
        ggplot2::geom_histogram(bins = r$n) +
        ggplot2::labs(title = "Slider 3")
    })

  })
}
