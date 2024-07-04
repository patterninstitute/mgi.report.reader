mrk_list2_colnames <- function() {
  c(
    "marker_id",
    "chromosome",
    "genetic_map_pos",
    "start",
    "end",
    "strand",
    "marker_symbol",
    "marker_status",
    "marker_name",
    "marker_type",
    "feature_type",
    "synonyms"
  )
}

mrk_list2_coltypes <- function() {
  "ccciiccfcfcc"
}

mrk_list2_col_order <- function(extra_cols = character()) {
  c(
    "marker_status",
    "marker_type",
    "marker_id",
    "marker_symbol",
    "marker_name",
    "feature_type",
    "chromosome",
    "start",
    "end",
    "strand",
    "genetic_map_pos",
    "synonyms",
    extra_cols
  )
}

read_mrk_list2_rpt <- function(file, sort = TRUE, n_max = Inf) {

  list2_rpt <-
    read_tsv(
      file = file,
      col_names = mrk_list2_colnames(),
      col_types = mrk_list2_coltypes(),
      n_max = n_max
    ) |>
    dplyr::mutate(
      marker_id = col_marker_id(.data$marker_id),
      marker_symbol = col_marker_symbol(.data$marker_symbol),
      marker_name = col_marker_name(.data$marker_name),
      marker_type = col_marker_type(.data$marker_type),
      marker_status = col_marker_status(.data$marker_status),
      genetic_map_pos = col_genetic_map_pos(.data$genetic_map_pos),
      chromosome = col_chromosome(.data$chromosome),
      start = col_start(.data$start),
      end = col_end(.data$end),
      strand = col_strand(.data$strand),
      feature_type = col_feature_type(.data$feature_type),
      synonyms = col_synonyms(.data$synonyms)
    ) |>
    dplyr::relocate(dplyr::all_of(mrk_list2_col_order()))

  if (sort) {
    by <- c("marker_status", "marker_type", "marker_symbol")
    list2_rpt <- dplyr::arrange(list2_rpt, dplyr::pick(by))
  }

  list2_rpt
}
