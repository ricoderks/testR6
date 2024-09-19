#' @importFrom R6 R6Class
#'

set.seed(123)
testR6 = R6::R6Class(
  classname = "testR6",
  private = list(
    name = "",
    n1 = NULL,
    n2 = NULL,
    data = data.frame(x = stats::rnorm(n = 1000)),
    reactiveDep = NULL,
    reactiveExpr = NULL,
    invalidate = function() {
      private$count <- private$count + 1
      private$reactiveDep(private$count)
      invisible()
    },
    count = 0
  ),
  public = list(
    initialize = function(name) {
      private$reactiveDep <- function(x) NULL
      private$name <- name
    },
    reactive = function() {
      # Ensure the reactive stuff is initialized.
      if (is.null(private$reactiveExpr)) {
        private$reactiveDep <- reactiveVal(0)
        private$reactiveExpr <- reactive({
          private$reactiveDep()
          self
        })
      }
      private$reactiveExpr
    },
    #-------------------------------------------------------------------- n ----
    changeN1 = function(newN) {
      private$n1 <- newN
      private$invalidate()
    },
    getN1 = function() {
      private$n1
    },
    changeN2 = function(newN) {
      private$n2 <- newN
      private$invalidate()
    },
    getN2 = function() {
      private$n2
    },
    #----------------------------------------------------------------- data ----
    changeData = function(newData) {
      private$data <- newData
      private$invalidate()
    },
    getData = function()
      private$data
  )
)
