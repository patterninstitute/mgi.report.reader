example <- function(file) {
  system.file(file, package = "mgi.report.reader", mustWork = TRUE)
}

#' Report example
#'
#' [report_example()] returns the local path of an example report file. These
#' files are typically very small and are useful for demonstrations. These
#' are mostly used in the Examples section of functions and in unit tests.
#'
#' @param report_file File basename.
#'
#' @examples
#' report_example("MRK_List1-EX01.rpt")
#'
#' report_example("MRK_List1-EX02.rpt")
#'
#' report_example("MRK_List1-EX03.rpt")
#'
#' @export
report_example <- function(report_file) {
  example(paste0("extdata/report_examples/", report_file))
}
