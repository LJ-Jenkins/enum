check_names <- function(nms, fn_name) {
  if (is.null(nms) || !all(nzchar(nms))) {
    err("All elements in ", fn_name, " must be named.")
  }

  if (anyDuplicated(nms)) {
    err("All element names in ", fn_name, " must be unique.")
  }
}

check_unique <- function(tf, values, fn_name) {
  if (isTRUE(tf) && anyDuplicated(values)) {
    err("All `", fn_name, "` members must have unique values.")
  }
}

#-- type checks

check_lgl <- function(values) {
  i <- vapply_lgl(values, is.logical)
  if (!all(i)) err("`enum_lgl` members must be logical.")
}

check_bool <- function(values) {
  i <- vapply_lgl(
    values, function(x) is.logical(x) && length(x) == 1L && !is.na(x)
  )
  if (!all(i)) {
    err("`enum_bool` members must be single logical (non-NA) values.")
  }
}

check_num <- function(values) {
  i <- vapply_lgl(values, is.numeric)
  if (!all(i)) err("`enum_num` members must be numeric.")
}

check_int <- function(values) {
  i <- vapply_lgl(values, is.integer)
  if (!all(i)) err("`enum_int` members must be integers.")
}

check_dbl <- function(values) {
  i <- vapply_lgl(values, is.double)
  if (!all(i)) err("`enum_dbl` members must be doubles.")
}

check_nmbr <- function(values) {
  i <- vapply_lgl(
    values, function(x) is.numeric(x) && length(x) == 1L && is.finite(x)
  )
  if (!all(i)) err("`enum_nmbr` members must be scalar finite numerics.")
}

check_chr <- function(values) {
  i <- vapply_lgl(values, is.character)
  if (!all(i)) err("`enum_chr` members must be characters.")
}

check_str <- function(values) {
  i <- vapply_lgl(
    values,
    function(x) is.character(x) && length(x) == 1L && !is.na(x) && nzchar(x)
  )

  if (!all(i)) err("`enum_str` members must be single (non-NA) strings.")
}

check_fn <- function(values) {
  i <- vapply_lgl(values, is.function)
  if (!all(i)) err("`enum_fn` members must be functions.")
}
