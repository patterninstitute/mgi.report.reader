lst_col_na_to_empty <- function(x) {
  sapply(x, \(.x) length(.x) == 1L && is.na(.x)) |>
    dplyr::if_else(true = list(character()), false = x)
}
