mrk_swissprot_tr_embl_colnames <- function() {
    c(
      "marker_id",
      "marker_symbol",
      "marker_status",
      "marker_name",
      "genetic_map_pos",
      "chromosome",
      "uniprot_id"
    )
}

mrk_swissprot_tr_embl_coltypes <- function() {
  "ccccccc"
}

mrk_swissprot_tr_embl_col_order <- function() {
  c(
    "marker_status",
    "marker_id",
    "marker_symbol",
    "marker_name",
    "chromosome",
    "genetic_map_pos",
    "uniprot_id"
  )
}

read_mrk_swissprot_tr_embl_rpt <- function(file, n_max = Inf) {

  read_tsv(
    file = file,
    col_names = mrk_swissprot_tr_embl_colnames(),
    col_types = mrk_swissprot_tr_embl_coltypes(),
    n_max = n_max
  ) |>
    dplyr::mutate(
      marker_status = col_marker_status(.data$marker_status),
      marker_id = col_marker_id(.data$marker_id),
      marker_symbol = col_marker_symbol(.data$marker_symbol),
      marker_name = col_marker_name(.data$marker_name),
      chromosome = col_chromosome(.data$chromosome),
      genetic_map_pos = col_genetic_map_pos(.data$genetic_map_pos),
      uniprot_id = col_uniprot_id(.data$uniprot_id, sep = " ")
    ) |>
    dplyr::relocate(dplyr::all_of(mrk_swissprot_tr_embl_col_order()))
}
