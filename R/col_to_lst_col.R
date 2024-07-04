col_to_lst_col <- function(x, sep = "|", unique = TRUE, sort = TRUE) {

  if (rlang::is_empty(x)) return(list())

  lst_col <-
    strsplit(x, split = sep, fixed = TRUE) |>
    lst_col_na_to_empty()

  if (unique) lst_col <- sapply(lst_col, \(.x) unique(.x))
  if (sort) lst_col <- sapply(lst_col, \(.x) sort(.x))

  lst_col
}
