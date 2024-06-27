library(magrittr)

has_new_symbol <- function(x) {
  grepl(r"{withdrawn, =\s+(.+)\s*$}", x)
}

extract_new_symbol <- function(x) {
  stringr::str_extract(x, r"{withdrawn, =\s+(.+)\s*$}", group = 1L)
}

list01 <- read_report("~/dwl/gencode/MRK_List1.rpt", "MRK_List1")
list02 <- read_report("~/dwl/gencode/MRK_List2.rpt", "MRK_List2")

old_to_new_symbols <-
  list01 |>
  dplyr::filter(status == "W") |>
  dplyr::filter(has_new_symbol(marker_name)) |>
  dplyr::mutate(new_symbol = extract_new_symbol(marker_name)) |>
  dplyr::rename(old_symbol = "marker_symbol") |>
  dplyr::select(dplyr::all_of(c("old_symbol", "new_symbol"))) |>
  dplyr::distinct() |>
  dplyr::filter(old_symbol != new_symbol)

map <- old_to_new_symbols[19950:19960, ]
# map <- old_to_new_symbols[1:10, ]
new_symbols <- look_up(map$old_symbol, setNames(map$new_symbol, nm = map$old_symbol))

list01 |>
  dplyr::filter(marker_symbol %in% c("Arha", "Arha2"))

readr::write_tsv(withdrawn_symbols, file = "~/dwl/withdrawn_symbols.tsv")

withdrawn_symbols[is.na(withdrawn_symbols$marker_symbol_new), ]

anyDuplicated(old_to_new_symbols$old_symbol)

dplyr::filter(old_to_new_symbols, old_symbol == "0610007N19Rik")
dplyr::filter(list01, marker_symbol %in% c("0610007N19Rik", "Snhg18", "Snord123"))
