mrk_sequence_colnames <- function() {
    c(
      "marker_id",
      "marker_symbol",
      "marker_status",
      "marker_type",
      "marker_name",
      "genetic_map_pos",
      "chromosome",
      "start",
      "end",
      "strand",
      "genbank_id",
      "refseq_trp_id",
      "ensembl_trp_id",
      "swiss_prt_id",
      "tr_embl_prt_id",
      "ensembl_prt_id",
      "refseq_prt_id",
      "unigene_id",
      "feature_type"
    )
}

mrk_sequence_coltypes <- function() {
  "ccccccciicccccccccc"
}

mrk_sequence_col_order <- function() {
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
    "genbank_id",
    "refseq_trp_id",
    "refseq_prt_id",
    "ensembl_trp_id",
    "ensembl_prt_id",
    "swiss_prt_id",
    "tr_embl_prt_id",
    "unigene_id"
  )
}

read_mrk_sequence_rpt <- function(file, n_max = Inf) {

  read_tsv(
    file = file,
    col_names = mrk_sequence_colnames(),
    col_types = mrk_sequence_coltypes(),
    n_max = n_max
  ) |>
    dplyr::mutate(
      marker_status = col_marker_status(.data$marker_status),
      marker_type = col_marker_type(.data$marker_type),
      marker_id = col_marker_id(.data$marker_id),
      marker_symbol = col_marker_symbol(.data$marker_symbol),
      marker_name = col_marker_name(.data$marker_name),
      feature_type = col_feature_type(.data$feature_type),
      chromosome = col_chromosome(.data$chromosome),
      start = col_start(.data$start),
      end = col_end(.data$end),
      strand = col_strand(.data$strand),
      genetic_map_pos = col_genetic_map_pos(.data$genetic_map_pos),
      genbank_id = col_genbank_id(.data$genbank_id),
      refseq_trp_id = col_refseq_trp_id(.data$refseq_trp_id),
      ensembl_trp_id = col_ensembl_trp_id(.data$ensembl_trp_id),
      swiss_prt_id = col_swiss_prt_id(.data$swiss_prt_id),
      tr_embl_prt_id = col_tr_embl_prt_id(.data$tr_embl_prt_id),
      ensembl_prt_id = col_ensembl_prt_id(.data$ensembl_prt_id),
      refseq_prt_id = col_refseq_prt_id(.data$refseq_prt_id),
      unigene_id = col_unigene_id(.data$unigene_id)
    ) |>
    dplyr::relocate(dplyr::all_of(mrk_sequence_col_order()))
}
