
<!-- README.md is generated from README.Rmd. Please edit that file -->

# s7bugreport

The goal of this repository is to demonstrate a potential bug found in
S7.

The bug occurs when you have an S7 class (foo) and S3 class (bar)
coexisting in a package, and both classes have `$`-extraction methods.

``` r
library(S7)
foo <- new_class("foo", properties = list(x = new_property(class_integer, default = 10L)))

bar <- function() {
  structure(list(x = 10L), class = "bar")
}

method(`$`, foo) <- function(x, ...) {
  cat("foo $-extraction\n")
  prop(x, ...)
}

`$.bar` <- function(x, ...) {
  cat("bar $-extraction\n")
  .subset2(x, ...)
}
```

Both of these `$`-extraction methods work fine.

``` r
foo()$x
#> foo $-extraction
#> [1] 10
bar()$x
#> bar $-extraction
#> [1] 10
```

However, when declaring the same classes and methods from a package, the
`$.bar` method seems to get discarded. To ensure that this is run in a
clean session, I’ll use {reprex} to demonstrate. Please note in the
final chunk that the `"bar $-extraction"` string is missing.

``` r
rpx <- reprex::reprex({
  library(s7bugreport)
  foo()$x
  bar()$x
})
#> ✖ Install the styler package in order to use `style = TRUE`.
#> ℹ Non-interactive session, setting `html_preview = FALSE`.
#> ℹ Rendering reprex...
#> CLIPR_ALLOW has not been set, so clipr will not run interactively
cat(rpx, sep = "\n")
```

``` r
library(s7bugreport)
foo()$x
#> foo $-extraction
#> [1] 10
bar()$x
#> [1] 10
```

<sup>Created on 2023-11-27 with [reprex
v2.0.2](https://reprex.tidyverse.org)</sup>
