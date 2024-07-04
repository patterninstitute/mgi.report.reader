mrk_list1_colnames <- function() {
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
    "synonyms",
    "marker_id_now",
    "marker_symbol_now"
  )
}

mrk_list1_coltypes <- function() {
  "ccciiccfcfcccc"
}

mrk_list1_col_order <- function(extra_cols = character()) {
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
    "marker_id_now",
    "marker_symbol_now",
    extra_cols
  )
}

read_mrk_list1_rpt <- function(file, sort = FALSE, n_max = Inf) {
  list1_rpt <-
    read_tsv(
      file = file,
      col_names = mrk_list1_colnames(),
      col_types = mrk_list1_coltypes(),
      n_max = n_max
    ) |>
    dplyr::mutate(
      marker_id = col_marker_id(.data$marker_id),
      marker_id_now = col_marker_id_now(.data$marker_id_now),
      marker_symbol = col_marker_symbol(.data$marker_symbol),
      marker_symbol_now = col_marker_symbol_now(.data$marker_symbol_now),
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
    # Add a `note` column capturing what happened to Withdrawn symbols.
    # This info is obtained from the `marker_name` column. For withdrawn
    # markers, we then set them to `NA_character_`.
    dplyr::mutate(
      note = col_note(
        dplyr::if_else(.data$marker_status == "W", .data$marker_name, NA_character_)),
      marker_name = col_marker_name(
      dplyr::if_else(.data$marker_status == "O", .data$marker_name, NA_character_)),
      marker_id_now = col_marker_id_now(
        dplyr::if_else(.data$marker_status == "O", .data$marker_id, .data$marker_id_now)),
      marker_symbol_now = col_marker_symbol_now(
        dplyr::if_else(.data$marker_status == "O", .data$marker_symbol, .data$marker_symbol_now))
    ) |>
    dplyr::relocate(dplyr::all_of(mrk_list1_col_order(extra_cols = "note")))

  if (sort) {
    by <- c("marker_status", "marker_type", "marker_symbol")
    list1_rpt <- dplyr::arrange(list1_rpt, dplyr::pick(by))
  }

  list1_rpt
}
