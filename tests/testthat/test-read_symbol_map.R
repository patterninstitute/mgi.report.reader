test_that("read_symbol_map() works as expected", {

  # In example 1, 1700024N20Rik has an ambiguous mapping to both Proscos and
  # Plpbp. (you can check with:
  # read_report(
  #   report_file = report_example("MRK_List1-EX01.rpt"),
  #   report_type = report_type("marker_list1")
  #   )

  # So the symbol map should not contain a mapping for the symbol 1700024N20Rik.
  symbol_map <- read_symbol_map(report_example("MRK_List1-EX01.rpt"))

  expect_s3_class(symbol_map, "data.frame")
  expect_s3_class(symbol_map, "data.table")
  expect_named(symbol_map, c("marker_symbol", "marker_symbol_now"))
  expect_identical(nrow(symbol_map), 5L)

  expect_false("1700024N20Rik" %in% symbol_map$marker_symbol)
  expect_contains(symbol_map$marker_symbol, c("2200002F22Rik", "Plpbp", "Proscos", "Prosc", "ENSMUSG00000045549"))
})

# TODO
# Wait for: https://github.com/tidyverse/vroom/issues/540
# test_that("read_symbol_map(): empty rpt", {
#
#   rpt <-
#     tibble::tibble(
#       marker_status = col_marker_status(character()),
#       marker_symbol = col_marker_symbol(character()),
#       marker_symbol_now = col_marker_symbol_now(character())
#     )
#
#   ex00_rpt <- report_example("MRK_List1-EX00.rpt")
#   symbol_map <- read_symbol_map(ex00_rpt)
#
#   expect_s3_class(symbol_mapping, "data.frame")
#   expect_s3_class(symbol_mapping, "data.table")
#   expect_named(symbol_mapping, c("marker_symbol", "marker_symbol_now"))
#   expect_identical(nrow(symbol_mapping), 0L)
#
# })
