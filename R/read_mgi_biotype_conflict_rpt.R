mgi_biotype_conflict_colnames <- function() {
  c("marker_id",
    "marker_symbol",
    "database",
    "gene_id",
    "biotype",
    "is_mgi_rep")
}

mgi_biotype_conflict_coltypes <- function() {
  "cccccc"
}

mgi_biotype_conflict_col_order <- function() {
  mgi_biotype_conflict_colnames()
}

read_mgi_biotype_conflict_rpt <- function(file, n_max = Inf) {

  vroom::vroom_lines(file = file) |>
    # Keep only lines that contain data.
    grep("^MGI", x = _, value = TRUE) |>
    paste(collapse = "\n") |>
    read_tsv(col_names = mgi_biotype_conflict_colnames(),
             col_types = mgi_biotype_conflict_coltypes(),
             n_max = n_max) |>
    dplyr::mutate(
      marker_id = col_marker_id(.data$marker_id),
      marker_symbol = col_marker_symbol(.data$marker_symbol),
      database = col_database(.data$database),
      gene_id = col_gene_id(.data$gene_id),
      biotype = col_biotype(.data$biotype),
      is_mgi_rep = col_is_mgi_rep(.data$is_mgi_rep)
    ) |>
    dplyr::relocate(dplyr::all_of(mgi_biotype_conflict_col_order()))
}
