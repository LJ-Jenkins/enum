enum_impl <- function(
  ...,
  .err_fn = NULL,
  .checker = NULL,
  .unique = FALSE,
  .class_name = NULL
) {
  x <- list(...)
  nms <- names(x)
  check_names(nms, .err_fn)
  if (!is.null(.checker)) .checker(x)
  check_unique(.unique, x, .err_fn)
  create_enum(x, nms, .class_name, .err_fn)
}

create_enum <- function(member_vals, member_nms, class_name, print_nm) {
  enum_env <- new.env(parent = emptyenv())

  make_binding <- function(value) {
    force(value)

    function(assignment_attempt) {
      if (!missing(assignment_attempt)) {
        err("Enums cannot be modified.")
      }

      value
    }
  }

  for (i in seq_along(member_vals)) {
    makeActiveBinding(
      member_nms[[i]],
      make_binding(member_vals[[i]]),
      enum_env
    )
  }

  lockEnvironment(enum_env, bindings = FALSE)
  class(enum_env) <- c(class_name, "enum", "environment")
  `attr<-`(enum_env, "enum_print_nm", print_nm)
}

#-- exports

#' Create read-only enum objects
#' @description
#' Create an enum object with named members that cannot be modified
#' after creation.
#' @param ... Named members of the enum.
#' @param unique Logical indicating if member values must be unique.
#' @param class Optional custom class to assign to the enum object.
#' @return A locked environment of class `"enum"` containing the
#' read-only named members.
#' @details
#' The enum object is implemented as an environment with active bindings
#' for each member, ensuring that the values cannot be modified after
#' creation.
#'
#' The strongly typed variants enforce specific types for the enum members,
#' such as logical (`_lgl`), numeric (`_num`), integer (`_int`),
#' double (`_dbl`), character (`_chr`), and function (`_fn`).
#'
#' `enum_bool` enforces that all enum members are either a single `TRUE` or
#' `FALSE` value.
#'
#' `enum_str` enforces that all enum members are single, non-`NA`, non-empty
#' strings.
#'
#' `enum_nmbr` enforces that all enum members are single, finite numeric
#' values.
#' @examples
#' enum(a = 1, b = TRUE, c = "text", d = list(x = 1), e = mean)
#'
#' # enforce type
#' enum_lgl(yes = TRUE, no = FALSE, unknown = NA)
#' try(enum_bool(yes = TRUE, no = FALSE, unknown = NA))
#'
#' enum_num(yes = 1L, no = 2.0, maybe = NA_real_)
#' try(enum_nmbr(yes = 1L, no = 2.0, maybe = Inf))
#'
#' enum_chr(text = "hello", empty = "", missing = NA_character_)
#' try(enum_str(text = "hello", empty = "", missing = NA_character_))
#'
#' # add class at construction
#' class(enum(red = 1, class = "Color"))
#' @export
enum <- function(..., unique = FALSE, class = NULL) {
  enum_impl(..., .unique = unique, .class_name = class, .err_fn = "enum")
}

#' @rdname enum
#' @export
enum_lgl <- function(..., unique = FALSE, class = NULL) {
  enum_impl(
    ...,
    .checker = check_lgl,
    .unique = unique,
    .class_name = class,
    .err_fn = "enum_lgl"
  )
}

#' @rdname enum
#' @export
enum_bool <- function(..., unique = FALSE, class = NULL) {
  enum_impl(
    ...,
    .checker = check_bool,
    .unique = unique,
    .class_name = class,
    .err_fn = "enum_bool"
  )
}

#' @rdname enum
#' @export
enum_num <- function(..., unique = FALSE, class = NULL) {
  enum_impl(
    ...,
    .checker = check_num,
    .unique = unique,
    .class_name = class,
    .err_fn = "enum_num"
  )
}

#' @rdname enum
#' @export
enum_int <- function(..., unique = FALSE, class = NULL) {
  enum_impl(
    ...,
    .checker = check_int,
    .unique = unique,
    .class_name = class,
    .err_fn = "enum_int"
  )
}

#' @rdname enum
#' @export
enum_dbl <- function(..., unique = FALSE, class = NULL) {
  enum_impl(
    ...,
    .checker = check_dbl,
    .unique = unique,
    .class_name = class,
    .err_fn = "enum_dbl"
  )
}

#' @rdname enum
#' @export
enum_nmbr <- function(..., unique = FALSE, class = NULL) {
  enum_impl(
    ...,
    .checker = check_nmbr,
    .unique = unique,
    .class_name = class,
    .err_fn = "enum_nmbr"
  )
}

#' @rdname enum
#' @export
enum_chr <- function(..., unique = FALSE, class = NULL) {
  enum_impl(
    ...,
    .checker = check_chr,
    .unique = unique,
    .class_name = class,
    .err_fn = "enum_chr"
  )
}

#' @rdname enum
#' @export
enum_str <- function(..., unique = FALSE, class = NULL) {
  enum_impl(
    ...,
    .checker = check_str,
    .unique = unique,
    .class_name = class,
    .err_fn = "enum_str"
  )
}

#' @rdname enum
#' @export
enum_fn <- function(..., unique = FALSE, class = NULL) {
  enum_impl(
    ...,
    .checker = check_fn,
    .unique = unique,
    .class_name = class,
    .err_fn = "enum_fn"
  )
}
