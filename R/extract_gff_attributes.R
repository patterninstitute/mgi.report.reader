#' @importFrom data.table ":="
extract_gff_attributes <- function(df, col) {

  dt <- data.table::as.data.table(df)

  # Split the attributes column into ID, Name, and Note
  dt[, c("marker_id", "marker_symbol", "feature_type") := data.table::tstrsplit(col, ";(?=ID=|Name=|Note=)", perl = TRUE), env = list(col = col)]

  # Hack to fix "no visible binding for global variable".
  marker_id <- NULL
  marker_symbol <- NULL
  feature_type <- NULL
  misc <- NULL

  # Remove the prefixes
  dt[, marker_id := sub("ID=", "", marker_id)]
  dt[, marker_symbol := sub("Name=", "", marker_symbol)]
  dt[, feature_type := sub("Note=", "", feature_type)]

  dt[, misc := NULL]

  return(tibble::as_tibble(dt))
}

