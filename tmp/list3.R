read_mrk_list3_rpt <- function(file, n_max = Inf) {
  col_names <-
    c(
      "marker_id",
      "chr",
      "cM_pos",
      "start",
      "end",
      "strand",
      "marker_symbol",
      "status",
      "marker_name",
      "marker_type",
      "feature_type",
      "synonyms",
      "marker_symbol_current",
      "marker_id_current"
    )

  col_types <- "ccciiccfcfcccc"
  # Import data
  read_tsv(
    file = file,
    col_names = col_names,
    col_types = col_types,
    n_max = n_max
  ) |>
    dplyr::mutate(
      marker_id = marker_id_col(.data$marker_id),
      marker_type = marker_type_col(.data$marker_type),
      cM_pos = cM_pos_col(.data$cM_pos),
      chr = chr_col(.data$chr),
      strand = strand_col(.data$strand),
      status = status_col(.data$status),
      feature_type = feature_type_col(.data$feature_type),
      synonyms = synonyms_col(.data$synonyms),
      marker_id_current = marker_id_col(.data$marker_id_current)
    ) |>
    dplyr::relocate(
      "marker_id",
      "marker_id_current",
      "marker_symbol",
      "marker_symbol_current",
      "marker_name",
      "marker_type",
      "status",
      "cM_pos",
      "chr",
      "start",
      "end",
      "strand",
      "feature_type",
      "synonyms"
    )
}

look_up <- function(x, map) {

  stopifnot("`x` must be a character vector" = is.character(x))
  stopifnot("`map` must be a character vector" = is.character(x), "`map` must be a named vector" = !is.null(names(map)))

  y <- unname(map[x])
  y[is.na(y)] <- x[is.na(y)]

  if (all(x == y)) {
    return(y)
  } else {
    look_up(x = y, map = map)
  }
}

foo <- read_mrk_list3_rpt("/home/rmagno/dwl/gencode/MRK_ListShort.txt")

foo |>
  dplyr::filter(
    marker_symbol %in% c("Pgm1", "Pgm1a", "Pgm2")
  )


old_to_new_symbols <-
  foo |>
  dplyr::filter(status == "W") |>
  dplyr::select(dplyr::all_of(c("marker_symbol", "marker_symbol_current"))) |>
  dplyr::distinct() |>
  dplyr::filter(marker_symbol != marker_symbol_current)

map <- old_to_new_symbols[1:54925, ]

map <-
  old_to_new_symbols |>
  dplyr::filter(marker_symbol %in% c("Pgm1", "Pgm2") | marker_symbol_current %in% c("Pgm1", "Pgm2"))

new_symbols <- look_up(map$marker_symbol, setNames(map$marker_symbol_current, nm = map$marker_symbol))


map <- old_to_new_symbols
# map <- old_to_new_symbols[1:10, ]
new_symbols <- look_up(map$old_symbol, setNames(map$new_symbol, nm = map$old_symbol))

list01 |>
  dplyr::filter(marker_symbol %in% c("Arha", "Arha2"))

readr::write_tsv(withdrawn_symbols, file = "~/dwl/withdrawn_symbols.tsv")

withdrawn_symbols[is.na(withdrawn_symbols$marker_symbol_new), ]

anyDuplicated(old_to_new_symbols$old_symbol)

dplyr::filter(old_to_new_symbols, old_symbol == "0610007N19Rik")
dplyr::filter(list01, marker_symbol %in% c("0610007N19Rik", "Snhg18", "Snord123"))


foo |>
  dplyr::filter(marker_symbol %in% c("Pgm1", "Pgm2") | marker_symbol_now %in% c("Pgm1", "Pgm2"))

library(ggplot2)

foo |>
  ggplot(mapping = aes(x = cM_pos, y = start)) +
  geom_point() +
  facet_wrap(vars(chr))

bar <-
foo |>
  dplyr::mutate(
    note = dplyr::if_else(marker_status == "W", marker_name, NA_character_),
    marker_name = dplyr::if_else(marker_status == "O", marker_name, NA_character_)
  )


foo |>
  dplyr::filter(marker_symbol == marker_symbol_now)

foo |>
  dplyr::filter(marker_symbol == marker_symbol_now)
