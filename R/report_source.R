find_report_source <- function(file) {
  if (is_url(file))
    return(file)

  if (file.exists(file)) {
    return(normalizePath(file, winslash = "/", mustWork = TRUE))
  }

  NA_character_

}

url_last_modified <- function(url) {
  response <-
    url |>
    httr2::request() |>
    httr2::req_method("HEAD") |>
    httr2::req_perform()

  # Extract metadata from the response headers
  headers <- httr2::resp_headers(response)

  # Extract last modified date
  headers$`last-modified` |>
    as.POSIXct(format = "%a, %d %b %Y %H:%M:%S", tz = "GMT")
}

file_last_modified <- function(file) {
  file.info(file)$mtime
}

find_report_last_modified <- function(file) {
  if (is_url(file))
    return(url_last_modified(file))

  if (file.exists(file)) {
    return(file_last_modified(file))
  }

  NA_character_
}

#' Report last modification date
#'
#' [report_last_modified()] returns the last modified date and time of the
#' report source (local file or remote file).
#'
#' @param tbl Report data as a [tibble][tibble::tibble-package].
#'
#' @returns A last modified date-time as a [POSIXct][base::DateTimeClasses]
#'   object.
#'
#' @examples
#' markers <- read_report("marker_list1", n_max = 10L)
#'
#' # When was the report file last updated?
#' report_last_modified(markers)
#'
#' @export
report_last_modified <- function(tbl) {
  attr(tbl, "report_last_modified")
}


#' Report source
#'
#' [report_source()] returns the source used to obtain the report data:
#' a file path or an URL.
#'
#' @param tbl Report data as a [tibble][tibble::tibble-package].
#'
#' @returns A single string with an absolute path to a file on disk or an URL.
#'
#' @examples
#' markers <- read_report("marker_list1", n_max = 10L)
#'
#' # Where did the data come from?
#' report_source(markers)
#'
#' @export
report_source <- function(tbl) {
  attr(tbl, "report_source")
}
