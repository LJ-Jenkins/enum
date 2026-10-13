
<!-- README.md is generated from README.Rmd. Please edit that file -->

# enum <img src="man/figures/logo.png" align="right" height="120" alt="" />

<!-- badges: start -->

<!-- badges: end -->

Create simple read-only enum objects for clearer semantic meaning in
your code.

NOTE: in development and subject to change.

## Installation

Install the latest release of enum from CRAN:

``` r
install.packages("enum")
```

You can install the development version of enum from GitHub:

``` r
# install.packages("pak")
pak::pak("LJ-Jenkins/enum")
```

## Basic Usage

Create a simple enum object that contains any read-only values/types:

``` r
library(enum)

enum(a = 1, b = TRUE, c = "text", d = list(x = 1), e = mean)
#> Enum with members:
#>  $e :function (x, ...)  
#>  $d :List of 1 $ x: num 1
#>  $c : chr "text"
#>  $b : logi TRUE
#>  $a : num 1
```

Create enum objects that enforce types:

``` r
enum_lgl(yes = TRUE, no = FALSE, unknown = NA)
#> Enum with <lgl> members:
#>  $yes     : logi TRUE
#>  $no      : logi FALSE
#>  $unknown : logi NA

enum_bool(yes = TRUE, no = FALSE, unknown = NA)
#> Error:
#> ! `enum_bool` members must be single logical (non-NA) values.

enum_dbl(yes = 1.0, no = 2.0, maybe = NA_real_)
#> Enum with <dbl> members:
#>  $yes   : num 1
#>  $no    : num 2
#>  $maybe : num NA

enum_num(yes = 1L, no = 2.0, maybe = NA_real_)
#> Enum with <num> members:
#>  $yes   : int 1
#>  $no    : num 2
#>  $maybe : num NA

enum_chr(yes = "yes", no = "no", maybe = "")
#> Enum with <chr> members:
#>  $yes   : chr "yes"
#>  $no    : chr "no"
#>  $maybe : chr ""

enum_str(yes = "yes", no = "no", maybe = "")
#> Error:
#> ! `enum_str` members must be single (non-NA) strings.
```

Change the class of the enum objects to define custom methods:

``` r
mc <- enum(
  SUBSCRIPTION_COST = 1000,
  MEMBER = TRUE,
  MEMBER_DISCOUNT = 10L,
  class = "SubCost"
)

subscription_cost <- function(x, ...) {
  UseMethod("subscription_cost")
}

subscription_cost.SubCost <- function(x, ...) {
  x$SUBSCRIPTION_COST * (1 - x$MEMBER_DISCOUNT / 100)
}

subscription_cost(mc)
#> [1] 900

# or create a enum template
create_color <- function(r, g, b) {
  enum_int(r = r, g = g, b = b, class = "Color")
}

red <- create_color(r = 255L, g = 0L, b = 0L)
green <- create_color(r = 0L, g = 255L, b = 0L)
blue <- create_color(r = 0L, g = 0L, b = 255L)
```

## Getting help

If you encounter a clear bug, please file an issue with a minimal
reproducible example on
[GitHub](https://github.com/LJ-Jenkins/enum/issues).

## Code of Conduct

Please note that this project is released with a [Contributor Code of
Conduct](https://lj-jenkins.github.io/enum/CODE_OF_CONDUCT.html). By
contributing to this project, you agree to abide by its terms.
