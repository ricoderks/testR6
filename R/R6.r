#' @title R6 classes
#'
#' @description
#' Several R6 classes for testing. One main class which will have 2 nested
#' classes.
#'
#' @importFrom R6 R6Class
#' @importFrom shiny reactive reactiveVal
#'
testR6 <- R6::R6Class(
  classname = "testR6",
#------------------------------------------------------------------ private ----
  private = list(
    name = "",
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
#------------------------------------------------------------------- public ----
  public = list(
    n1 = NULL,
    n2 = NULL,
    initialize = function(name) {
      set.seed(123)
      self$n1 <- testR61$new(name = "test1")$reactive()
      self$n2 <- testR62$new(name = "test2")$reactive()

      private$reactiveDep <- function(x) NULL
      private$name <- name
    },
    reactive = function() {
      # Ensure the reactive stuff is initialized.
      if (is.null(private$reactiveExpr)) {
        private$reactiveDep <- shiny::reactiveVal(0)
        private$reactiveExpr <- shiny::reactive({
          private$reactiveDep()
          self
        })
      }
      private$reactiveExpr
    },
#--------------------------------------------------------------------- data ----
    changeData = function(newData) {
      private$data <- newData
      private$invalidate()
    },
    getData = function()
      private$data
  )
)


#-------------------------------------------------------------- sub classes ----
#------------------------------------------------------------------ class 1 ----
testR61 <- R6::R6Class(
  classname = "testR61",
#------------------------------------------------------------------ private ----
  private = list(
    name = "",
    n1 = NULL,
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
#------------------------------------------------------------------- public ----
  public = list(
    initialize = function(name) {
      private$reactiveDep <- function(x) NULL
      private$name <- name
    },
    reactive = function() {
      # Ensure the reactive stuff is initialized.
      if (is.null(private$reactiveExpr)) {
        private$reactiveDep <- shiny::reactiveVal(0)
        private$reactiveExpr <- shiny::reactive({
          private$reactiveDep()
          self
        })
      }
      private$reactiveExpr
    },
#------------------------------------------------------------------------ n ----
    changeN1 = function(newN) {
      private$n1 <- newN
      private$invalidate()
    },
    getN1 = function() {
      private$n1
    }
  )
)


#------------------------------------------------------------------ class 2 ----
testR62 <- R6::R6Class(
  classname = "testR62",
#------------------------------------------------------------------ private ----
  private = list(
    name = "",
    n2 = NULL,
    reactiveDep = NULL,
    reactiveExpr = NULL,
    invalidate = function() {
      private$count <- private$count + 1
      private$reactiveDep(private$count)
      invisible()
    },
    count = 0
  ),
#------------------------------------------------------------------- public ----
  public = list(
    initialize = function(name) {
      private$reactiveDep <- function(x) NULL
      private$name <- name
    },
    reactive = function() {
      # Ensure the reactive stuff is initialized.
      if (is.null(private$reactiveExpr)) {
        private$reactiveDep <- shiny::reactiveVal(0)
        private$reactiveExpr <- shiny::reactive({
          private$reactiveDep()
          self
        })
      }
      private$reactiveExpr
    },
#------------------------------------------------------------------------ n ----
    changeN2 = function(newN) {
      private$n2 <- newN
      private$invalidate()
    },
    getN2 = function() {
      private$n2
    }
  )
)
