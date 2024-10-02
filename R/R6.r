#' @importFrom R6 R6Class
#'
Person = R6::R6Class(
  classname = "Person",
  public = list(
    initialize = function(name) {
      self$name <- name
    },
    #-------------------------------------------------------- general stuff ----
    name = "",
    #-------------------------------------------------------------- methods ----
    print = function() {
      cat("Person:", self$name, "\n")
    },
    changeName = function(newName) {
      self$name <- newName
    }
  )
)
