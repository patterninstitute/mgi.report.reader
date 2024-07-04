mrk_genetrap_colnames <- function() {
    c(
      "marker_id",
      "marker_symbol",
      "marker_status",
      "marker_type",
      "marker_name",
      "genetic_map_pos",
      "chromosome",
      "cell_line_id"
    )
}

mrk_genetrap_coltypes <- function() {
  "cccccccc-"
}

mrk_genetrap_col_order <- function() {
  c(
    "marker_status",
    "marker_type",
    "marker_id",
    "marker_symbol",
    "marker_name",
    "chromosome",
    "genetic_map_pos",
    "cell_line_id"
  )
}

read_mrk_genetrap_rpt <- function(file, n_max = Inf) {

  read_tsv(
    file = file,
    col_names = mrk_genetrap_colnames(),
    col_types = mrk_genetrap_coltypes(),
    n_max = n_max
  ) |>
    dplyr::mutate(
      marker_status = col_marker_status(.data$marker_status),
      marker_type = col_marker_type(.data$marker_type),
      marker_id = col_marker_id(.data$marker_id),
      marker_symbol = col_marker_symbol(.data$marker_symbol),
      marker_name = col_marker_name(.data$marker_name),
      chromosome = col_chromosome(.data$chromosome),
      genetic_map_pos = col_genetic_map_pos(.data$genetic_map_pos),
      cell_line_id = col_cell_line_id(.data$cell_line_id)
    ) |>
    dplyr::relocate(dplyr::all_of(mrk_genetrap_col_order()))
}
