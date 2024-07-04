gtgup_colnames <- function() {
  c(
    "chromosome",
    "source",
    "marker_type",
    "start",
    "end",
    "empty1",
    "strand",
    "empty2",
    "misc"
  )
}

gtgup_coltypes <- function() {
  "cccii-c-c"
}

gtgup_col_order <- function() {
  c(
    "marker_type",
    "marker_id",
    "marker_symbol",
    "chromosome",
    "start",
    "end",
    "strand",
    "source",
    "feature_type"
  )
}

read_gtgup_rpt <- function(file, n_max = Inf) {

  read_tsv(
    file = file,
    col_names = gtgup_colnames(),
    col_types = gtgup_coltypes(),
    n_max = n_max
  ) |>
    dplyr::mutate(
      chromosome = col_chromosome(.data$chromosome),
      source = col_source(.data$source),
      marker_type = col_marker_type(.data$marker_type),
      strand = col_strand(.data$strand),
      start = col_start(.data$start),
      end = col_end(.data$end)
    ) |>
    extract_gff_attributes("misc") |>
    dplyr::mutate(
      marker_id = col_marker_id(.data$marker_id),
      marker_symbol = col_marker_symbol(.data$marker_symbol),
      feature_type = col_feature_type(.data$feature_type)
    ) |>
    dplyr::relocate(dplyr::all_of(gtgup_col_order()))
}
