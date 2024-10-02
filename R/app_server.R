#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {

  my_person <- Person$new(name = "Rico")
  person_name <- shiny::reactiveVal(my_person$name)

  shiny::observeEvent(input$change_name, {
    shiny::req(my_person)

    print("Before click (R6): ")
    print(my_person)
    print(paste0("Before click (reativeVal): ", person_name()))

    my_person$changeName(newName = "Henk")
    # this is needed to make it work
    person_name(my_person$name)

    print("After click (R6): ")
    print(my_person)
    print(paste0("After click (reactiveVal): ", person_name()))
  })


  output$person_name <- shiny::renderText({
    shiny::req(person_name)

    person_name()
  })
}
