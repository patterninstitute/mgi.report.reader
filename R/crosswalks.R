create_symbol_mapping <- function(rpt) {

  # Convert tibble to data.table
  rpt_dt <- data.table::as.data.table(rpt)

  # Hack to fix "no visible binding for global variable".
  marker_symbol <- NULL
  marker_symbol_now <- NULL
  . <- NULL

  # Select relevant columns and perform in-place operations
  rpt_dt <- rpt_dt[, .(marker_symbol, marker_symbol_now)]

  # Remove rows with any NA values
  rpt_dt <- stats::na.omit(rpt_dt, cols = c("marker_symbol", "marker_symbol_now"))

  # Remove duplicated rows
  rpt_dt <- rpt_dt[!duplicated(rpt_dt)]

  # Key the marker_symbol column for performance in joins
  data.table::setkey(rpt_dt, marker_symbol)

}

map_to_marker_symbol_now <- function(x, rpt) {

  required_columns <- c("marker_symbol", "marker_symbol_now")
  if (!all(required_columns %in% colnames(rpt))) {
    missing_cols <- required_columns[!required_columns %in% colnames(rpt)]
    rlang::abort(paste("The following required columns are missing in rpt:", paste(missing_cols, collapse = ", ")))
  }

  symbol_mapping <- create_symbol_mapping(rpt)

  # Hack to fix "no visible binding for global variable".
  marker_symbol_now <- NULL

  attr(symbol_mapping$marker_symbol_now, "label") <- NULL
  symbol_mapping[data.table::data.table(marker_symbol = x), marker_symbol_now, on = "marker_symbol"]
}

#' Update marker symbols
#'
#' [update_marker_symbol()] remaps old marker symbols to, in-use, most up to
#' date symbols.
#'
#' @param x A character vector of marker symbols to be remapped.
#' @param rpt Report data as a [tibble][tibble::tibble-package] offering the
#'   translation table between old (`marker_symbol`) and new
#'   (`marker_symbol_now`) symbols. Hence, at least, the following two columns
#'   are required because they encode the mapping:
#'
#' - `marker_symbol`: The symbols to matched against the values of `x`.
#' - `marker_symbol_now`: The new symbols to be returned in case of a match.
#'
#' Almost always, `rpt` will take the result of `read_report("marker_list1")`.
#'
#' @returns A character vector of most up to date symbols.
#'
#' @examples
#' # Reading only the first 100 markers (for efficiency)
#' rpt <- read_report("marker_list1", n_max = 100)
#' head(rpt)
#'
#' # Note that:
#' #   - "0610005A07Rik" is a withdrawn symbol, so gets remapped to Gstm7.
#' #   - "0610005C13Rik" is an official symbol, so stays the same.
#' #   - "not a symbol" is not an existing symbol in `rpt`, so gets mapped to `NA`.
#' symbols <- c("0610005A07Rik", "0610005C13Rik", "not a symbol")
#' update_marker_symbol(x = symbols, rpt = rpt)
#'
#' @export
update_marker_symbol <- map_to_marker_symbol_now

create_id_mapping <- function(rpt) {

  # Convert tibble to data.table
  rpt_dt <- data.table::as.data.table(rpt)

  # Hack to fix "no visible binding for global variable".
  marker_symbol <- NULL
  marker_id_now <- NULL
  . <- NULL

  # Select relevant columns and perform in-place operations
  rpt_dt <- rpt_dt[, .(marker_symbol, marker_id_now)]

  # Remove rows with any NA values
  rpt_dt <- stats::na.omit(rpt_dt, cols = c("marker_symbol", "marker_id_now"))

  # Remove duplicated rows
  rpt_dt <- rpt_dt[!duplicated(rpt_dt)]

  # Key the marker_symbol column for performance in joins
  data.table::setkey(rpt_dt, marker_symbol)

}

map_to_marker_id_now <- function(x, rpt) {

  required_columns <- c("marker_symbol", "marker_id_now")
  if (!all(required_columns %in% colnames(rpt))) {
    missing_cols <- required_columns[!required_columns %in% colnames(rpt)]
    rlang::abort(paste("The following required columns are missing in rpt:", paste(missing_cols, collapse = ", ")))
  }

  id_mapping <- create_id_mapping(rpt)

  # Hack to fix "no visible binding for global variable".
  marker_id_now <- NULL

  attr(id_mapping$marker_id_now, "label") <- NULL
  id_mapping[data.table::data.table(marker_symbol = x), marker_id_now, on = "marker_symbol"]
}

#' Convert marker symbols to updated marker identifiers
#'
#' [convert_to_marker_id()] remaps old marker symbols to, in-use, most up to date
#' marker identifiers.
#'
#' @param x A character vector of marker symbols to be remapped.
#' @param rpt Report data as a [tibble][tibble::tibble-package] offering the
#'   translation table between old (`marker_symbol`) symbols and new
#'   (`marker_id_now`) marker identifiers. Hence, at least, the following two columns
#'   are required because they encode the mapping:
#'
#' - `marker_symbol`: The symbols to matched against the values of `x`.
#' - `marker_id_now`: The new marker identifiers to be returned in case of a match.
#'
#' Almost always, `rpt` will take the result of `read_report("marker_list1")`.
#'
#' @returns A character vector of most up to date marker identifiers.
#'
#' @examples
#' # Reading only the first 100 markers (for efficiency)
#' rpt <- read_report("marker_list1", n_max = 100)
#' head(rpt)
#'
#' # Note that:
#' #   - "0610005A07Rik" is a withdrawn symbol, so gets remapped to Gstm7.
#' #   - "0610005C13Rik" is an official symbol, so stays the same.
#' #   - "not a symbol" is not an existing symbol in `rpt`, so gets mapped to `NA`.
#' symbols <- c("0610005A07Rik", "0610005C13Rik", "not a symbol")
#' convert_to_marker_id(x = symbols, rpt = rpt)
#'
#' @export
convert_to_marker_id <- map_to_marker_id_now
