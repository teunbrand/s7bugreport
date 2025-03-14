
<!-- README.md is generated from README.Rmd. Please edit that file -->

# s7bugreport

The goal of this repository is to demonstrate a potential bug found in
S7.

The bug occurs when you have an S7 class (foo) and S3 class (bar)
coexisting in a package, and both classes have methods for an S3
generic.

``` r
library(S7)
foo <- new_class("foo", properties = list(x = new_property(class_integer, default = 10L)))

bar <- function() {
  structure(list(x = 10L), class = "bar")
}

method(print, foo) <- function(x, ...) {
  cat("foo print\n")
}

print.bar <- function(x, ...) {
  cat("bar print\n")
}
```

Both of these print methods work fine.

``` r
print(foo())
#> foo print
print(bar())
#> bar print
```

However, when declaring the same classes and methods from a package, the
`print.bar` method seems to get discarded. To ensure that this is run in
a clean session, I’ll use {reprex} to demonstrate. Please note in the
final chunk that the `"bar print"` string is missing.

``` r
rpx <- reprex::reprex({
  library(s7bugreport)
  print(foo())
  print(bar())
})
#> ℹ Non-interactive session, setting `html_preview = FALSE`.
#> ℹ Rendering reprex...
#> CLIPR_ALLOW has not been set, so clipr will not run interactively
cat(rpx, sep = "\n")
{
    library(s7bugreport)
    print(foo())
    print(bar())
}
#> foo print
#> $x
#> [1] 10
#> 
#> attr(,"class")
#> [1] "bar"
```

<sup>Created on 2025-03-14 with [reprex
v2.1.1](https://reprex.tidyverse.org)</sup>
