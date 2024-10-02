#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @importFrom utils packageVersion
#' @importFrom bslib page_navbar nav_panel card card_header card_body
#'
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),

    bslib::page_navbar(
      title = paste0("CPM - testR6 | v", utils::packageVersion("testR6")),
      underline = TRUE,
      bslib::nav_panel(
        "Nav panel",
        bslib::card(
          bslib::card_header("test R6"),
          bslib::card_body(
            shiny::actionButton(
              inputId = "change_name",
              label = "Change to Henk"
            ),
            shiny::p("My name is:"),
            shiny::textOutput(
              outputId = "person_name"
            )
          )
        )
      )
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "testR6"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
