#' MGI accession identifier checking
#'
#' [is_mgi_identifier()] checks whether the input is of the format
#' `"MGI:nnnnnn"`, where `"n"` is a digit and the number of digits can vary.
#'
#' @param x A character vector.
#'
#' @returns A logical vector.
#'
#' @keywords internal
is_mgi_identifier <- function(x) {

  if (!(rlang::is_character(x)))
    rlang::abort("`x` must be a character vector.")

  grepl("^MGI:\\d+$", x)
}

#' @keywords internal
is_report_key <- function(report_key) {

  if (!(rlang::is_character(report_key)))
    rlang::abort("`report_key` must be a character vector.")

  report_key %in% reports$report_key

}
