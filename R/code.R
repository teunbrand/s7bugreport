#' @import S7
NULL

#' @export
foo <- new_class("foo", properties = list(x = new_property(class_integer, default = 10L)))

#' @export
bar <- function() {
  structure(list(x = 10L), class = "bar")
}

method(`$`, foo) <- function(x, ...) {
  cat("foo $-extraction\n")
  prop(x, ...)
}

#' @export
`$.bar` <- function(x, ...) {
  cat("bar $-extraction\n")
  .subset2(x, ...)
}

.onLoad <- function(...) {
  methods_register()
}

