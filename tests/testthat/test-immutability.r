test_that("enum members cannot be overwritten with dollar assignment", {
  x <- enum(red = "red")

  expect_error(
    x$red <- "blue",
    "Enums cannot be modified"
  )

  expect_identical(x$red, "red")
})

test_that("enum members cannot be overwritten with bracket assignment", {
  x <- enum(red = "red")

  expect_error(
    x[["red"]] <- "blue",
    "Enums cannot be modified"
  )

  expect_identical(x$red, "red")
})

test_that("enum members cannot be removed", {
  x <- enum(red = "red")

  expect_error(
    rm("red", envir = x),
    "locked environment"
  )

  expect_identical(x$red, "red")
})

test_that("new bindings cannot be added", {
  x <- enum(red = "red")

  expect_error(
    assign("blue", "blue", envir = x),
    "locked environment"
  )

  expect_false("blue" %in% ls(x, all.names = TRUE))
})

test_that("the enum environment has no parent bindings", {
  x <- enum(red = "red")

  expect_identical(parent.env(x), emptyenv())
  expect_false(exists("red", envir = parent.env(x), inherits = TRUE))
})

test_that("enum members are active bindings", {
  x <- enum(red = "red")

  expect_true(bindingIsActive("red", x))
})

test_that("enum environment structure is locked", {
  x <- enum(red = "red")

  expect_true(environmentIsLocked(x))
})

test_that("member values are not accidentally coupled", {
  x <- enum(a = 10L, b = 20L, c = 30L)

  expect_identical(x$a, 10L)
  expect_identical(x$b, 20L)
  expect_identical(x$c, 30L)
  expect_identical(x$a, 10L)
})
