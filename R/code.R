#' @import S7
NULL

#' @export
foo <- new_class("foo", properties = list(x = new_property(class_integer, default = 10L)))

#' @export
bar <- function() {
  structure(list(x = 10L), class = "bar")
}

method(print, foo) <- function(x, ...) {
  cat("foo print\n")
}

#' @export
`print.bar` <- function(x, ...) {
  cat("bar print\n")
}

.onLoad <- function(...) {
  methods_register()
}

