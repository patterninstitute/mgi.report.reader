mrk_ensembl_colnames <- function() {
  c(
    "marker_id",
    "marker_symbol",
    "marker_name",
    "genetic_map_pos",
    "chromosome",
    "ensembl_gen_id",
    "ensembl_trp_id",
    "ensembl_prt_id",
    "feature_type",
    "start",
    "end",
    "strand",
    "biotype"
  )
}

mrk_ensembl_coltypes <- function() {
  "ccccccccciicc"
}

mrk_ensembl_col_order <- function(extra_cols = character()) {
  c(
    "marker_id",
    "marker_symbol",
    "marker_name",
    "feature_type",
    "chromosome",
    "start",
    "end",
    "strand",
    "genetic_map_pos",
    "ensembl_gen_id",
    "ensembl_trp_id",
    "ensembl_prt_id",
    "biotype",
    extra_cols
  )
}

read_mrk_ensembl_rpt <- function(file, n_max = Inf) {
  read_tsv(
    file = file,
    col_names = mrk_ensembl_colnames(),
    col_types = mrk_ensembl_coltypes(),
    n_max = n_max
  ) |>
    dplyr::mutate(
      marker_id = col_marker_id(.data$marker_id),
      marker_symbol = col_marker_symbol(.data$marker_symbol),
      marker_name = col_marker_name(.data$marker_name),
      feature_type = col_feature_type(.data$feature_type),
      ensembl_gen_id = col_ensembl_gen_id(.data$ensembl_gen_id),
      ensembl_trp_id = col_ensembl_trp_id(.data$ensembl_trp_id, sep = " "),
      ensembl_prt_id = col_ensembl_prt_id(.data$ensembl_prt_id, sep = " "),
      chromosome = col_chromosome(.data$chromosome),
      start = col_start(.data$start),
      end = col_end(.data$end),
      strand = col_strand(.data$strand),
      genetic_map_pos = col_genetic_map_pos(.data$genetic_map_pos),
      biotype = col_biotype(.data$biotype)
    ) |>
    dplyr::relocate(dplyr::all_of(mrk_ensembl_col_order()))
}
