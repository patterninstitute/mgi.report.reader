# #' Recursive lookup table mapping
# #'
# #' @description
# #'
# #' [look_up()] takes a character vector `x` and remaps values to new values
# #' according to the lookup table specified by the named vector `map`. The
# #' remapping is performed by looking up values of `x` in names of `map`. When
# #' there is a match then the value of `map` is used, otherwise the original
# #' value in `x` is left as is.
# #'
# #' What makes this function functionality different from a simple remapping with
# #' a named vector is that the mapping is attempted recursively until no value in
# #' `x` can be further remapped.
# #'
# #' @param x A character vector of values to be remapped to new ones.
# #' @param map A named character vector providing a lookup table from names to
# #' values.
# #'
# #' @returns A character vector of (potentially) remapped values.
# #'
# #' @examples
# #' # Simple example.
# #' x <- c("a", "b", "c")
# #' mgi.report.reader:::look_up(x = x, map = c(a = "1", b = "2", c = "3"))
# #'
# #' # Simple-ish example with recursive remapping.
# #' mgi.report.reader:::look_up(x = x, map = c(a = "1", b = "c", c = "X"))
# #'
# #' @keywords internal
# look_up <- function(x, map) {
#
#   stopifnot("`x` must be a character vector" = is.character(x))
#   stopifnot("`map` must be a character vector" = is.character(x), "`map` must be a named vector" = !is.null(names(map)))
#
#   y <- unname(map[x])
#   y[is.na(y)] <- x[is.na(y)]
#
#   if (all(x == y)) {
#     return(y)
#   } else {
#     look_up(x = y, map = map)
#   }
# }
