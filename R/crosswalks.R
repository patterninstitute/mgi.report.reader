#' Read marker symbol mappings
#'
#' @description
#' [read_symbol_map()] reads MRK_List1.rpt data and returns an efficient
#' data table to be used for marker symbol remapping.
#'
#' This function is memoised.
#'
#' @param report_file The path to a MRK_List1.rpt file. Leave this as `NULL`
#' and the function will automatically download the report from
#' \url{`r report_url("marker_list1")`}.
#' @param n_max Maximum number of lines to read.
#'
#' @returns A [data.table][data.table::data.table] where each row is a mapping,
#'   from `marker_symbol` to `marker_symbol_now`:
#'
#' - `marker_symbol` (set as key): `r desc_marker_symbol()`
#' - `marker_symbol_now`: `r desc_marker_symbol_now()`
#'
#' @keywords internal
read_symbol_map <- function(report_file = NULL, n_max = Inf) {

  if (is.null(report_file)) {
    report_key <- "marker_list1"
    report_file <- report_url(report_key)
    report_type <- report_type(report_key)
  }

  # Hack to fix "no visible binding for global variable".
  marker_symbol <- NULL; marker_symbol_now <- NULL; . <- NULL; .N <- NULL
  N <- NULL; .SD <- NULL

  # Read in MRK_List1.rpt with only columns:
  #   - marker_symbol
  #   - marker_symbol_now
  dt <- read_mrk_list1_symbols_rpt(file = report_file, n_max = n_max)

  cols <- c("marker_symbol", "marker_symbol_now")
  # Remove mapping involving NA values.
  dt <- stats::na.omit(dt, cols = cols)

  # Remove redundant mappings, keep only non-ambiguous mappings
  dt <- dt[!duplicated(dt)][, .(marker_symbol_now, .N), by = marker_symbol][N == 1L][, N := NULL][, .SD, .SDcols = cols]

  rpt_source <- find_report_source(report_file)
  rpt_last_modified <- find_report_last_modified(report_file)

  attr(dt, "report_source") <- rpt_source
  attr(dt, "report_last_modified") <- rpt_last_modified

  dt

}

#' Read marker symbol to identifier mappings
#'
#' @description
#' [read_symbol_to_id_map()] reads MRK_List1.rpt data and returns an efficient
#' data table to be used for marker symbol remapping to marker identifiers. Note
#' that old symbols will be remapped to new symbols' ids, if applicable.
#'
#' This function is memoised.
#'
#' @param report_file The path to a MRK_List1.rpt file. Leave this as `NULL`
#' and the function will automatically download the report from
#' \url{`r report_url("marker_list1")`}.
#' @param n_max Maximum number of lines to read.
#'
#' @returns A [data.table][data.table::data.table] where each row is a mapping,
#'   from `marker_symbol` to `marker_id_now`:
#'
#' - `marker_symbol` (set as key): `r desc_marker_symbol()`
#' - `marker_id_now`: `r desc_marker_id_now()`
#'
#' @keywords internal
read_symbol_to_id_map <- function(report_file = NULL, n_max = Inf) {

  if (is.null(report_file)) {
    report_key <- "marker_list1"
    report_file <- report_url(report_key)
    report_type <- report_type(report_key)
  }

  # Hack to fix "no visible binding for global variable".
  marker_symbol <- NULL; marker_id_now <- NULL; . <- NULL; .N <- NULL
  N <- NULL; .SD <- NULL

  # Read in MRK_List1.rpt with only columns:
  #   - marker_symbol
  #   - marker_id_now
  dt <- read_mrk_list1_symbol_to_id_rpt(file = report_file, n_max = n_max)

  cols <- c("marker_symbol", "marker_id_now")
  # Remove mapping involving NA values.
  dt <- stats::na.omit(dt, cols = cols)

  # Remove redundant mappings, keep only non-ambiguous mappings
  dt <- dt[!duplicated(dt)][, .(marker_id_now, .N), by = marker_symbol][N == 1L][, N := NULL][, .SD, .SDcols = cols]

  rpt_source <- find_report_source(report_file)
  rpt_last_modified <- find_report_last_modified(report_file)

  attr(dt, "report_source") <- rpt_source
  attr(dt, "report_last_modified") <- rpt_last_modified

  dt

}

#' Update marker symbols
#'
#' [symbol_to_symbol()] remaps old marker symbols to, in-use, most up to
#' date symbols.
#'
#' @param x A character vector of marker symbols to be remapped.
#' @param report_file The path to a MRK_List1.rpt file. Leave this as `NULL`
#' and the function will automatically download the report from
#' \url{`r report_url("marker_list1")`}.
#' @param n_max Maximum number of lines to read from the `report_file`.
#'
#' @returns A character vector of most up to date symbols.
#'
#' @examples
#' rpt_ex01 <- report_example("MRK_List1-EX01.rpt")
#' read_report(report_file = rpt_ex01, report_type = "MRK_List1") |>
#'   dplyr::select("marker_status", "marker_symbol", "marker_symbol_now")
#'
#' # NB:
#' #   - "1700024N20Rik" has two conflicting mappings, so maps to `NA`.
#' #   - "Hes1" is not present in MRK_List1-EX01.rpt, so maps to `NA`.
#' #   - "Plpbp" (official) and "Prosc" (withdrawn) both map to "Plpbp"
#'
#' marker_symbols <- c("2200002F22Rik", "Plpbp", "Prosc", "1700024N20Rik", "Hes1")
#' symbol_to_symbol(x = marker_symbols, report_file = rpt_ex01)
#'
#' @export
symbol_to_symbol <- function(x, report_file = NULL, n_max = Inf) {

  symbol_map <- read_symbol_map(report_file = report_file, n_max = n_max)
  x_dt <- data.table::data.table(marker_symbol = x)
  marker_symbol_now <- symbol_map[x_dt, "marker_symbol_now", on = "marker_symbol"]$marker_symbol_now

  attr(marker_symbol_now, "label") <- NULL
  marker_symbol_now
}

#' Convert marker symbols to updated marker identifiers
#'
#' [symbol_to_identifier()] remaps old marker symbols to, in-use, most up
#' to date marker identifiers.
#'
#' @param x A character vector of marker symbols to be remapped.
#' @param report_file The path to a MRK_List1.rpt file. Leave this as `NULL`
#' and the function will automatically download the report from
#' \url{`r report_url("marker_list1")`}.
#' @param n_max Maximum number of lines to read from the `report_file`.
#'
#' @examples
#' rpt_ex01 <- report_example("MRK_List1-EX01.rpt")
#' read_report(report_file = rpt_ex01, report_type = "MRK_List1") |>
#'   dplyr::select("marker_status", "marker_symbol", "marker_id_now")
#'
#' # NB:
#' #   - "1700024N20Rik" has two conflicting mappings, so maps to `NA`.
#' #   - "Hes1" is not present in MRK_List1-EX01.rpt, so maps to `NA`.
#' #   - "Plpbp" (official) and "Prosc" (withdrawn) both map to "MGI:1891207"
#'
#' marker_symbols <- c("2200002F22Rik", "Plpbp", "Prosc", "1700024N20Rik", "Hes1")
#' symbol_to_identifier(x = marker_symbols, report_file = rpt_ex01)
#'
#' @export
symbol_to_identifier <- function(x, report_file = NULL, n_max = Inf) {

  symbol_to_id_map <- read_symbol_to_id_map(report_file = report_file, n_max = n_max)
  x_dt <- data.table::data.table(marker_symbol = x)
  marker_id_now <- symbol_to_id_map[x_dt, "marker_id_now", on = "marker_symbol"]$marker_id_now

  attr(marker_id_now, "label") <- NULL
  marker_id_now
}
