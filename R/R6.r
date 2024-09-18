#' @importFrom R6 R6Class
#'
testR6 = R6::R6Class(
  classname = "testR6",
  private = list(
    name = "",
    n = NULL,
    data = NULL, # data.frame(x = stats::rnorm(n = 1000)),
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
    changeN = function(newN) {
      private$n <- newN
      private$invalidate()
    },
    getN = function() {
      private$n
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
