test_that("enum requires every member to be named", {
  expect_error(
    enum("red", blue = "blue"),
    "All elements in enum must be named"
  )

  expect_error(
    enum(a = "a", "b"),
    "All elements in enum must be named"
  )

  expect_error(
    enum(),
    "All elements in enum must be named"
  )
})

test_that("enum rejects empty member names", {
  x <- list("", "blue")
  names(x) <- c("", "blue")

  expect_error(
    do.call(enum, x),
    "All elements in enum must be named"
  )
})

test_that("enum rejects duplicate member names", {
  expect_error(
    enum(a = 1, a = 2),
    "All element names in enum must be unique"
  )
})

test_that("enum allows duplicate values by default", {
  x <- enum(a = 1, b = 1)

  expect_identical(x$a, 1)
  expect_identical(x$b, 1)
})

test_that("unique = TRUE rejects duplicate values", {
  expect_error(
    enum(a = "red", b = "red", unique = TRUE)
  )
})

test_that("unique = TRUE accepts distinct values", {
  x <- enum(a = "red", b = "blue", unique = TRUE)

  expect_identical(x$a, "red")
  expect_identical(x$b, "blue")
})

test_that("unique = FALSE allows duplicate values explicitly", {
  x <- enum(a = 1, b = 1, unique = FALSE)

  expect_identical(x$a, 1)
  expect_identical(x$b, 1)
})

test_that("uniqueness is checked across whole member values", {
  expect_error(
    enum(a = c(1, 2), b = c(1, 2), unique = TRUE)
  )
})

test_that("unique is only enabled by the literal TRUE", {
  x <- enum(a = 1, b = 1, unique = NA)

  expect_identical(x$a, 1)
  expect_identical(x$b, 1)
})

test_that("custom classes are applied without replacing enum classes", {
  x <- enum(a = 1, class = "my_enum")

  expect_identical(
    class(x),
    c("my_enum", "enum", "environment")
  )
})
