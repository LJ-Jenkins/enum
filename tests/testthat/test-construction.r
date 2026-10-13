test_that("enum constructs an enum environment", {
  x <- enum(red = "red", green = "green")

  expect_s3_class(x, "enum")
  expect_s3_class(x, "environment")
  expect_identical(environmentIsLocked(x), TRUE)
  expect_identical(parent.env(x), emptyenv())
})

test_that("enum preserves member names and values", {
  x <- enum(red = "red", green = "green", blue = "blue")

  expect_identical(x$red, "red")
  expect_identical(x$green, "green")
  expect_identical(x$blue, "blue")

  expect_setequal(
    ls(x, all.names = TRUE),
    c("red", "green", "blue")
  )
})

test_that("enum handles non-syntactic member names", {
  x <- enum(
    red = "red",
    `blue wee` = "blue",
    `1st choice` = "first"
  )

  expect_identical(x$red, "red")
  expect_identical(x$`blue wee`, "blue")
  expect_identical(x$`1st choice`, "first")
})

test_that("each binding returns its own value", {
  x <- enum(
    first = "alpha",
    second = "beta",
    third = "gamma",
    fourth = "delta",
    fifth = "epsilon"
  )

  expect_identical(x$first, "alpha")
  expect_identical(x$second, "beta")
  expect_identical(x$third, "gamma")
  expect_identical(x$fourth, "delta")
  expect_identical(x$fifth, "epsilon")
})

test_that("bindings preserve values of different types", {
  x <- enum(
    text = "hello",
    number = 42,
    flag = TRUE,
    missing = NA_character_,
    vector = c(1, 2, 3)
  )

  expect_identical(x$text, "hello")
  expect_identical(x$number, 42)
  expect_identical(x$flag, TRUE)
  expect_identical(x$missing, NA_character_)
  expect_identical(x$vector, c(1, 2, 3))
})

test_that("duplicate member values are allowed by default", {
  x <- enum(first = "same", second = "same")

  expect_identical(x$first, "same")
  expect_identical(x$second, "same")
})

test_that("enum supports a custom class", {
  x <- enum(red = "red", class = "colour_enum")

  expect_identical(
    class(x),
    c("colour_enum", "enum", "environment")
  )
  expect_identical(x$red, "red")
})

test_that("enum preserves the order of members", {
  x <- enum(z = 3, a = 1, m = 2)

  expect_identical(ls(x, all.names = TRUE), c("a", "m", "z"))
  expect_identical(as.list(x), list(z = 3, a = 1, m = 2))
})
