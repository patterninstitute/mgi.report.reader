test_that("symbol_to_symbol() works as expected", {

  # "a" -> "b"
  # "b" -> NA: because "b" it does not exist in `marker_symbol` should map to NA
  # NA stays NA.

  report_file <- report_example("MRK_List1-EX01.rpt")
  marker_symbols <- c("2200002F22Rik", "1700024N20Rik", NA)


  expected <- c("Plpbp", NA, NA)
  result <- symbol_to_symbol(x = marker_symbols, report_file = report_file)

  expect_identical(result, expected)

})

test_that("symbol_to_symbol(): conflicting mappings.", {

  # "a" occurs twice in `marker_symbol` with different mappings,
  # meaning we have an ambiguous case.
  # So "a" should be mapped to NA.

  report_file <- report_example("MRK_List1-EX02.rpt")
  list1_rpt <- read_report(report_file = report_file, report_type = "MRK_List1")
  result <- symbol_to_symbol(x = "Mob4", report_file = report_file)

  # Even though the original report contains Mob4 more than once, because the
  # mappings are to different symbols, these mappings end up being removed from
  # the symbol map, and the mapping of Mob4 results in NA.
  expect_true(sum(list1_rpt$marker_symbol == "Mob4") > 1L)
  expect_identical(result, NA_character_)

})

test_that("symbol_to_symbol(): same mapping, repeated.", {

  # "a" occurs twice in `marker_symbol` with the same mapping,
  # so it should apply that unique mapping.
  # So "a" should be mapped to "b".

  report_file <- report_example("MRK_List1-EX03.rpt")
  marker_symbols <- c("Adh7", "Mir466f-3", "Hes1")


  expected <- c("Adh7", "Mir466f-3", "Hes1")
  result <- symbol_to_symbol(x = marker_symbols, report_file = report_file)

  expect_identical(result, expected)

})
