#' @importFrom R6 R6Class
#'
testR6 = R6::R6Class(
  classname = "testR6",
  public = list(
    initialize = function(name) {
      self$name <- name
    },
    #-------------------------------------------------------- general stuff ----
    name = NA,
    n = NA,
    data = NA
  )
)
