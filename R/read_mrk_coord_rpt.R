mrk_coord_colnames <- function() {
    c(
      "marker_id",
      "marker_type",
      "feature_type",
      "marker_symbol",
      "marker_name",
      "chromosome",
      "start",
      "end",
      "strand",
      "assembly",
      "database",
      "source"
    )
}

mrk_coord_coltypes <- function() {
  # Last column is spurious, so we skip it ("-").
  "cccccciicccc-"
}

mrk_coord_col_order <- function() {
  c(
    "marker_type",
    "marker_id",
    "marker_symbol",
    "marker_name",
    "feature_type",
    "chromosome",
    "start",
    "end",
    "strand",
    "assembly",
    "source",
    "database"
  )
}

read_mrk_coord_rpt <- function(file, n_max = Inf) {
  read_tsv(
    file = file,
    col_names = mrk_coord_colnames(),
    col_types = mrk_coord_coltypes(),
    n_max = n_max
  ) |>
    dplyr::mutate(
      marker_id = col_marker_id(.data$marker_id),
      marker_type = col_marker_type(.data$marker_type),
      marker_symbol = col_marker_symbol(.data$marker_symbol),
      marker_name = col_marker_name(.data$marker_name),
      feature_type = col_feature_type(.data$feature_type),
      chromosome = col_chromosome(.data$chromosome),
      start = col_start(.data$start),
      end = col_end(.data$end),
      strand = col_strand(.data$strand),
      assembly = col_assembly(.data$assembly),
      database = col_database(.data$database),
      source = col_source(.data$source)
    ) |>
    dplyr::relocate(dplyr::all_of(mrk_coord_col_order()))
}
