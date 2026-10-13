test_that("dollar and double bracket access retrieves enum members", {
  x <- enum(red = "red", blue = "blue")

  expect_identical(x$red, "red")
  expect_identical(x$blue, "blue")
  expect_identical(x[["red"]], "red")
  expect_identical(x[["blue"]], "blue")
  expect_error(x["red"])
})

test_that("backtick access works for non-syntactic names", {
  x <- enum(`blue wee` = "blue")

  expect_identical(x$`blue wee`, "blue")
})

test_that("all members can be accessed repeatedly", {
  x <- enum(a = 1L, b = 2L, c = 3L)

  for (i in seq_len(10)) {
    expect_identical(x$a, 1L)
    expect_identical(x$b, 2L)
    expect_identical(x$c, 3L)
  }
})

test_that("as.list returns member values with their names", {
  x <- enum(a = 1L, b = "two", c = TRUE)

  expect_identical(
    as.list(x),
    list(a = 1L, b = "two", c = TRUE)
  )
})

test_that("a missing member is not created by reading it", {
  x <- enum(a = 1L)

  expect_null(x$missing)
  expect_identical(ls(x, all.names = TRUE), "a")
})

test_that("enum members retain vector attributes", {
  value <- structure(c(1L, 2L), names = c("x", "y"))
  x <- enum(member = value)

  expect_identical(x$member, value)
})
