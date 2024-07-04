col_marker_id_ <- function(x) {
  dplyr::if_else(x == "NULL", NA_character_, x)
}

col_marker_id <- function(x) {
  col_marker_id_(x) |>
    add_label_to_marker_id()
}

col_marker_id_now <- function(x) {
  col_marker_id_(x) |>
    add_label_to_marker_id_now()
}

col_marker_symbol <- function(x) {
  add_label_to_marker_symbol(x)
}

col_marker_symbol_now <- function(x) {
  add_label_to_marker_symbol_now(x)
}

col_marker_name <- function(x) {
  add_label_to_marker_name(x)
}

col_marker_type <- function(x) {
  factor(x, levels = marker_types()) |>
    add_label_to_marker_type()
}

col_marker_status <- function(x) {
  factor(x, levels = c("O", "W")) |>
    add_label_to_marker_status()
}

col_genetic_map_pos <- function(x) {
  not_genetic_map_values <- c("syntenic", "N/A", "-1.0")

  dplyr::if_else(x %in% not_genetic_map_values, NA_character_, x) |>
    as.double() |>
    add_label_to_genetic_map_pos()
}

col_chromosome <- function(x) {
  x |>
  stringr::str_remove("^chr") |>
  factor(levels = chromosomes()) |>
    add_label_to_chromosome()
}

col_start <- function(x) {
  as.integer(x) |>
    add_label_to_start()
}

col_end <- function(x) {
  as.integer(x) |>
    add_label_to_end()
}

col_strand <- function(x) {
  factor(x, levels = strands()) |> # "." is implicitly mapped to NA.
    add_label_to_strand()
}

col_feature_type <- function(x) {
  factor(x, levels = feature_types$feature_type) |>
    add_label_to_feature_type()
}

col_synonyms <- function(x, sep = "|") {
  x |>
    col_to_lst_col(sep = sep) |>
    add_label_to_synonyms()
}

col_note <- function(x) {
  add_label_to_note(x)
}

col_assembly <- function(x) {
  factor(x, levels = c("GRCm38", "GRCm39")) |>
    add_label_to_assembly()
}

col_biotype <- function(x, sep = "|") {
  x |>
    col_to_lst_col(sep = sep) |>
    add_label_to_biotype()
}

col_source <- function(x) {

  levels <- c("NCBI", "Ensembl", "Ensembl Reg", "RIKEN", "MGI", "VISTA")
  factor(x, levels = levels) |>
    add_label_to_source()
}

col_database <- function(x) {

  levels <- c(
    "NCBI Gene Model",
    "Ensembl Gene Model",
    "Ensembl Reg Gene Model",
    "RIKEN",
    "MGI",
    "QTL",
    "VISTA Gene Model",
    "gff3blat"
  )
  factor(x, levels = levels) |>
    add_label_to_database()
}

col_ensembl_gen_id <- function(x) {
  add_label_to_ensembl_gen_id(x)
}

col_ensembl_trp_id <- function(x, sep = "|") {
  x |>
    col_to_lst_col(sep = sep) |>
    add_label_to_ensembl_trp_id()
}

col_ensembl_prt_id <- function(x, sep = "|") {
  x |>
    col_to_lst_col(sep = sep) |>
    add_label_to_ensembl_prt_id()
}

col_entrez_gen_id <- function(x) {
  add_label_to_entrez_gen_id(x)
}

col_genbank_id <- function(x, sep = "|") {
  x |>
    col_to_lst_col(sep = sep) |>
    add_label_to_genbank_id()
}

col_refseq_trp_id <- function(x, sep = "|") {
  x |>
    col_to_lst_col(sep = sep) |>
    add_label_to_refseq_trp_id()
}

col_refseq_prt_id <- function(x, sep = "|") {
  x |>
    col_to_lst_col(sep = sep) |>
    add_label_to_refseq_prt_id()
}

col_tr_embl_prt_id <- function(x, sep = "|") {
  x |>
    col_to_lst_col(sep = sep) |>
    add_label_to_tr_embl_prt_id()
}

col_swiss_prt_id <- function(x, sep = "|") {
  x |>
    col_to_lst_col(sep = sep) |>
    add_label_to_swiss_prt_id()
}

col_uniprot_id <- function(x, sep = "|") {
  x |>
    col_to_lst_col(sep = sep) |>
    add_label_to_uniprot_id()
}

col_unigene_id <- function(x) {
    add_label_to_unigene_id(x)
}

col_interpro_id <- function(x) {
  add_label_to_interpro_id(x)
}

col_interpro_domain <- function(x) {
  add_label_to_interpro_domain(x)
}

col_cell_line_id <- function(x, sep = " ") {
  x |>
    col_to_lst_col(sep = sep) |>
    add_label_to_cell_line_id()
}

col_is_mgi_rep <- function(x) {
  dplyr::if_else(
    x == "Representative",
    true = TRUE,
    false = FALSE,
    missing = FALSE
  ) |>
    add_label_to_is_mgi_rep()
}

col_gene_id <- function(x) {
  add_label_to_gene_id(x)
}

col_primer_id <- function(x) {
  add_label(x, var_lbl["primer_id"])
}

col_primer_name <- function(x) {
  add_label(x, var_lbl["primer_name"])
}

col_primer_fwd_seq <- function(x) {
  add_label(x, var_lbl["primer_fwd_seq"])
}

col_primer_rev_seq <- function(x) {
  add_label(x, var_lbl["primer_rev_seq"])
}

col_primer_amplimer_size <- function(x) {
  add_label(x, var_lbl["primer_amplimer_size"])
}
