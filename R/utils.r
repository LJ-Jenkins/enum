err <- function(...) {
  stop(..., call. = FALSE)
}

vapply_lgl <- function(values, fn) {
  vapply(values, fn, logical(1))
}

#' @importFrom utils capture.output str
capstr <- function(x, ...) {
  utils::capture.output(utils::str(x, ...))
}

#' @export
print.enum <- function(x, ...) {
  print_nm <- attr(x, "enum_print_nm")
  if (!is.null(print_nm)) {
    print_nm <- strsplit(print_nm, "_", fixed = FALSE)[[1]][2]
    if (is.na(print_nm)) print_nm <- NULL
  }

  nms <- sort(names(x))
  chars <- nchar(nms)
  mx_chars <- max(chars)

  pad <- function(nm) {
    paste0(nm, strrep(" ", mx_chars - nchar(nm)))
  }

  if (!is.null(print_nm)) {
    cat("Enum with <", print_nm, "> members:\n", sep = "")
    for (nm in nms) {
      cat(" $", pad(nm), " :", capstr(x[[nm]]), "\n", sep = "")
    }
  } else {
    cat("Enum with members:\n")
    for (nm in nms) {
      cat(" $", pad(nm), " :", capstr(x[[nm]]), "\n", sep = "")
    }
  }
}
