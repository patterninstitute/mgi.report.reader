mrk_gene_model_coord_colnames <- function() {
  c(
    "marker_id",
    "marker_type",
    "marker_symbol",
    "marker_name",
    "assembly",
    "entrez_gen_id",
    "entrez_chromosome",
    "entrez_start",
    "entrez_end",
    "entrez_strand",
    "ensembl_gen_id",
    "ensembl_chromosome",
    "ensembl_start",
    "ensembl_end",
    "ensembl_strand"
  )
}

mrk_gene_model_coord_coltypes <- function() {
  # Last column is spurious.
  "ccccciciiccciic-"
}

mrk_gene_model_coord_col_order <- function() {
  c(
    "marker_type",
    "marker_id",
    "marker_symbol",
    "marker_name",
    "assembly",
    "entrez_gen_id",
    "entrez_chromosome",
    "entrez_start",
    "entrez_end",
    "entrez_strand",
    "ensembl_gen_id",
    "ensembl_chromosome",
    "ensembl_start",
    "ensembl_end",
    "ensembl_strand"
  )
}

read_gene_model_coord_rpt <- function(file, n_max = Inf) {

  read_tsv(
    file = file,
    col_names = mrk_gene_model_coord_colnames(),
    col_types = mrk_gene_model_coord_coltypes(),
    n_max = n_max
  ) |>
    dplyr::mutate(
      marker_id = col_marker_id(.data$marker_id),
      marker_type = col_marker_type(.data$marker_type),
      marker_symbol = col_marker_symbol(.data$marker_symbol),
      marker_name = col_marker_name(.data$marker_name),
      assembly = col_assembly(.data$assembly),
      entrez_gen_id = col_entrez_gen_id(.data$entrez_gen_id),
      entrez_chromosome = col_chromosome(.data$entrez_chromosome),
      entrez_start = col_start(.data$entrez_start),
      entrez_end = col_end(.data$entrez_end),
      entrez_strand = col_strand(.data$entrez_strand),
      ensembl_gen_id = col_ensembl_gen_id(.data$ensembl_gen_id),
      ensembl_chromosome = col_chromosome(.data$ensembl_chromosome),
      ensembl_start = col_start(.data$ensembl_start),
      ensembl_end = col_end(.data$ensembl_end),
      ensembl_strand = col_strand(.data$ensembl_strand)
    ) |>
    dplyr::relocate(dplyr::all_of(mrk_gene_model_coord_col_order()))
}

