test_that("enum_lgl accepts logical values and vectors", {
  x <- enum_lgl(
    yes = TRUE,
    no = FALSE,
    missing = NA,
    vector = c(TRUE, FALSE)
  )

  expect_identical(x$yes, TRUE)
  expect_identical(x$no, FALSE)
  expect_identical(x$missing, NA)
  expect_identical(x$vector, c(TRUE, FALSE))
})

test_that("enum_lgl rejects non-logical values", {
  expect_error(enum_lgl(a = 1), "must be logical")
  expect_error(enum_lgl(a = "TRUE"), "must be logical")
})

test_that("enum_bool accepts only scalar non-missing logicals", {
  x <- enum_bool(yes = TRUE, no = FALSE)

  expect_identical(x$yes, TRUE)
  expect_identical(x$no, FALSE)
})

test_that("enum_bool rejects invalid values", {
  expect_error(enum_bool(a = 1), "single logical")
  expect_error(enum_bool(a = NA), "single logical")
  expect_error(enum_bool(a = c(TRUE, FALSE)), "single logical")
  expect_error(enum_bool(a = "TRUE"), "single logical")
})

test_that("enum_num accepts integer and double values", {
  x <- enum_num(integer = 1L, double = 2.5, vector = c(1, 2))

  expect_identical(x$integer, 1L)
  expect_identical(x$double, 2.5)
  expect_identical(x$vector, c(1, 2))
})

test_that("enum_num rejects non-numeric values", {
  expect_error(enum_num(a = "1"), "must be numeric")
  expect_error(enum_num(a = TRUE), "must be numeric")
})

test_that("enum_int accepts integer values", {
  x <- enum_int(a = 1L, b = c(1L, 2L), missing = NA_integer_)

  expect_identical(x$a, 1L)
  expect_identical(x$b, c(1L, 2L))
  expect_identical(x$missing, NA_integer_)
})

test_that("enum_int rejects doubles and non-integers", {
  expect_error(enum_int(a = 1), "must be integers")
  expect_error(enum_int(a = "1"), "must be integers")
})

test_that("enum_dbl accepts double values", {
  x <- enum_dbl(a = 1, b = 2.5, missing = NA_real_)

  expect_identical(x$a, 1)
  expect_identical(x$b, 2.5)
  expect_identical(x$missing, NA_real_)
})

test_that("enum_dbl rejects integers and non-numerics", {
  expect_error(enum_dbl(a = 1L), "must be doubles")
  expect_error(enum_dbl(a = "1"), "must be doubles")
})

test_that("enum_nmbr accepts scalar non-missing numerics", {
  x <- enum_nmbr(integer = 1L, double = 2.5, neg = -1.5)

  expect_identical(x$integer, 1L)
  expect_identical(x$double, 2.5)
  expect_identical(x$neg, -1.5)
})

test_that("enum_nmbr rejects missing, inf and non-scalar values", {
  expect_error(enum_nmbr(a = NA_real_), "scalar")
  expect_error(enum_nmbr(a = NaN), "scalar")
  expect_error(enum_nmbr(a = c(1, 2)), "scalar")
  expect_error(enum_nmbr(a = "1"), "scalar")
  expect_error(enum_nmbr(a = Inf))
  expect_error(enum_nmbr(a = -Inf))
  expect_error(enum_nmbr(a = NaN))
})

test_that("enum_chr accepts character vectors", {
  x <- enum_chr(
    text = "hello",
    vector = c("a", "b"),
    missing = NA_character_
  )

  expect_identical(x$text, "hello")
  expect_identical(x$vector, c("a", "b"))
  expect_identical(x$missing, NA_character_)
})

test_that("enum_chr rejects non-character values", {
  expect_error(enum_chr(a = 1), "must be characters")
  expect_error(enum_chr(a = TRUE), "must be characters")
})

test_that("enum_str accepts non-empty scalar strings", {
  x <- enum_str(a = "hello", spaces = "  ")

  expect_identical(x$a, "hello")
  expect_identical(x$spaces, "  ")
})

test_that("enum_str rejects missing, empty and non-scalar strings", {
  expect_error(enum_str(a = NA_character_), "single")
  expect_error(enum_str(a = ""), "single")
  expect_error(enum_str(a = c("a", "b")), "single")
  expect_error(enum_str(a = 1), "single")
})

test_that("enum_fn accepts functions", {
  fn <- function(x) x + 1
  x <- enum_fn(increment = fn)

  expect_identical(x$increment, fn)
  expect_identical(x$increment(2), 3)
})

test_that("enum_fn rejects non-functions", {
  expect_error(enum_fn(a = 1), "must be functions")
  expect_error(enum_fn(a = "function"), "must be functions")
})

test_that("typed constructors accept custom classes", {
  x <- enum_chr(a = "hello", class = "text_enum")

  expect_identical(
    class(x),
    c("text_enum", "enum", "environment")
  )
})

test_that("typed constructors support uniqueness validation", {
  expect_error(
    enum_chr(a = "same", b = "same", unique = TRUE)
  )

  x <- enum_chr(a = "one", b = "two", unique = TRUE)

  expect_identical(x$a, "one")
  expect_identical(x$b, "two")
})
