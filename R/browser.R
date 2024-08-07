#' MGI base URL
#'
#' [mgi_base_url()] returns MGI base URL.
#'
#' @returns A scalar character vector with the URL.
#'
#' @keywords internal
mgi_base_url <- function() {
  "https://www.informatics.jax.org"
}

#' MGI reports base URL
#'
#' [mgi_reports_base_url()] returns MGI reports base URL.
#'
#' @returns A scalar character vector with the URL.
#'
#' @keywords internal
mgi_reports_base_url <- function() {
  file.path(mgi_base_url(), "downloads/reports/")
}

#' MGI reports index URL
#'
#' [mgi_reports_index_url()] returns MGI reports index URL.
#'
#' @returns A scalar character vector with the URL.
#'
#' @keywords internal
mgi_reports_index_url <- function() {
  paste0(mgi_reports_base_url(), "index.html")
}

mgi_reports_index_md <- function() {
  paste0("[MGI Reports Index](",mgi_reports_index_url(),")")
}

#' Browse MGI markers identifiers online
#'
#' [open_marker_id_in_mgi()] launches the web browser and opens a tab for each MGI
#' accession identifier on the Mouse Genome Informatics web interface:
#' \url{https://www.informatics.jax.org}.
#'
#' @inheritParams common-args
#'
#' @returns Returns `TRUE` if successful, or `FALSE` otherwise. But note that
#'   this function is run for its side effect of launching the browser.
#'
#' @examples
#' # Read about Acta1 (actin alpha 1, skeletal muscle) online.
#' open_marker_id_in_mgi("MGI:87902")
#'
#' # `open_marker_id_in_mgi()` is vectorized, so you can open multiple pages.
#' # NB: think twice if you really need to open many tabs at once.
#' open_marker_id_in_mgi(c("MGI:87902", "MGI:87909"))
#'
#' @export
open_marker_id_in_mgi <- function(marker_id) {
  if (!(all(is_mgi_identifier(marker_id))))
    stop("`marker_id` must be a character vector of valid MGI identifiers.")

  if (interactive()) {
    msg <- paste("You are about to open",
                 length(marker_id),
                 "pages in your browser.")
    if (length(marker_id) > 10L)
      if (!sure(before_question = msg))
        return(invisible(FALSE))

    urls <- file.path(mgi_base_url(), "marker", marker_id)
    lapply(urls, utils::browseURL)

    return(invisible(TRUE))
  } else {
    return(invisible(TRUE))
  }
}

#' Browse MGI markers symbols online
#'
#' [open_marker_symbol_in_mgi()] launches the web browser and opens a tab for each MGI
#' symbol on the Mouse Genome Informatics web interface:
#' \url{https://www.informatics.jax.org}.
#'
#' @inheritParams common-args
#'
#' @returns Returns `TRUE` if successful, or `FALSE` otherwise. But note that
#'   this function is run for its side effect of launching the browser.
#'
#' @examples
#' # Read about Acta1 (actin alpha 1, skeletal muscle) online.
#' open_marker_symbol_in_mgi("Acta1")
#'
#' # `open_marker_symbol_in_mgi()` is vectorized, so you can open multiple pages.
#' # NB: think twice if you really need to open many tabs at once.
#' open_marker_symbol_in_mgi(c("Acta1", "Hes1"))
#'
#' @export
open_marker_symbol_in_mgi <- function(marker_symbol) {

  if (interactive()) {
    msg <- paste("You are about to open",
                 length(marker_symbol),
                 "pages in your browser.")
    if (length(marker_symbol) > 10L)
      if (!sure(before_question = msg))
        return(invisible(FALSE))

    urls <- paste0(mgi_base_url(), "/quicksearch/summary?queryType=exactPhrase&query=", marker_symbol)
    lapply(urls, utils::browseURL)

    return(invisible(TRUE))
  } else {
    return(invisible(TRUE))
  }
}
