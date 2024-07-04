#' Supported MGI reports
#'
#' @description
#'
#' `reports` is a data set of supported MGI reports, meaning reports that
#' `r desc_package_name()` can currently read into R.
#' To browse all reports made available by MGI visit
#' \url{`r mgi_reports_base_url()`}.
#'
#' @format A [tibble][tibble::tibble-package] of `r ncol(reports)` variables:
#'
#' \describe{
#' \item{`report_key`}{`r desc_report_key()`}
#' \item{`report_file`}{`r desc_report_file()`}
#' \item{`report_type`}{`r desc_report_type()`}
#' \item{`report_name`}{`r desc_report_name()`}
#' }
#'
#' @examples
#' reports
#'
"reports"

#' @keywords internal
get_reports_col <- function(report_key, col) {
  if (!all(is_report_key(report_key))) {
    rlang::abort("Some report keys (`report_key`) do not match supported reports.")
  }

  report_key |>
    tibble::tibble() |>
    dplyr::left_join(reports, by = "report_key") |>
    dplyr::pull(col)
}

#' Get MGI report specs by report key
#'
#' Set of functions to retrieve metadata details of a MGI report.
#'
#' @inheritParams common-args
#'
#' @returns A character vector:
#'
#' - `report_file()`: report file name as hosted in \url{`r mgi_reports_base_url()`}.
#' - `report_name()`: report title.
#' - `report_type()`: report type.
#' - `report_url()`: report remote location.
#'
#' @examples
#' report_file("marker_list1")
#'
#' report_name("marker_list1")
#'
#' report_type("marker_list1")
#'
#' report_url("marker_list1")
#'
#' @name report-attributes
NULL

#' @rdname report-attributes
#' @export
report_file <- function(report_key) {
  get_reports_col(report_key = report_key, col = "report_file")
}

#' @rdname report-attributes
#' @export
report_name <- function(report_key) {
  get_reports_col(report_key = report_key, col = "report_name")
}

#' @rdname report-attributes
#' @export
report_type <- function(report_key) {
  get_reports_col(report_key = report_key, col = "report_type")
}

#' @rdname report-attributes
#' @export
report_url <- function(report_key) {
  file.path(mgi_reports_base_url(), report_file(report_key))
}
