mgi_inter_pro_domains_colnames <- function() {
  c(
    "interpro_id",
    "interpro_domain",
    "marker_id",
    "marker_symbol"
  )
}

mgi_inter_pro_domains_coltypes <- function() {
  "cccc"
}

mgi_inter_pro_domains_col_order <- function() {
  mgi_inter_pro_domains_colnames()
}

read_mgi_inter_pro_domains_rpt <- function(file, n_max = Inf) {

  read_tsv(
    file = file,
    col_names = mgi_inter_pro_domains_colnames(),
    col_types = mgi_inter_pro_domains_coltypes(),
    n_max = n_max
  ) |>
    dplyr::mutate(
      marker_id = col_marker_id(.data$marker_id),
      marker_symbol = col_marker_symbol(.data$marker_symbol),
      interpro_id = col_interpro_id(.data$interpro_id),
      interpro_domain = col_interpro_domain(.data$interpro_domain)
    ) |>
    dplyr::relocate(dplyr::all_of(mgi_inter_pro_domains_col_order()))
}
