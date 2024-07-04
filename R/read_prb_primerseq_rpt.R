prb_primerseq_colnames <- function() {
  c(
    "marker_symbol",
    "marker_name",
    "primer_name",
    "marker_id",
    "primer_id",
    "primer_fwd_seq",
    "primer_rev_seq",
    "primer_amplimer_size",
    "chromosome",
    "genetic_map_pos"
  )
}

prb_primerseq_coltypes <- function() {
  "cccccccccc"
}

prb_primerseq_col_order <- function() {
  c(
    "marker_id",
    "marker_symbol",
    "marker_name",
    "chromosome",
    "genetic_map_pos",
    "primer_id",
    "primer_name",
    "primer_fwd_seq",
    "primer_rev_seq",
    "primer_amplimer_size"
  )
}

read_prb_primerseq_rpt <- function(file, n_max = Inf) {

  read_tsv(
    file = file,
    col_names = prb_primerseq_colnames(),
    col_types = prb_primerseq_coltypes(),
    n_max = n_max
  ) |>
    dplyr::mutate(
      marker_id = col_marker_id(.data$marker_id),
      marker_symbol = col_marker_symbol(.data$marker_symbol),
      marker_name = col_marker_name(.data$marker_name),
      primer_name = col_primer_name(.data$primer_name),
      primer_id = col_primer_id(.data$primer_id),
      primer_fwd_seq = col_primer_fwd_seq(.data$primer_fwd_seq),
      primer_rev_seq = col_primer_rev_seq(.data$primer_rev_seq),
      primer_amplimer_size = col_primer_amplimer_size(.data$primer_amplimer_size),
      chromosome = col_chromosome(.data$chromosome),
      genetic_map_pos = col_genetic_map_pos(.data$genetic_map_pos)
    ) |>
    dplyr::relocate(dplyr::all_of(prb_primerseq_col_order()))
}
