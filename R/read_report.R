#' Read an MGI report
#'
#' @description
#'
#' [read_report()] imports data from an MGI report into R as a tidy data set.
#'
#' You may call this function in two alternative ways:
#'
#' - Using `report_key`: this is the easiest approach. A report key maps to a
#' report currently hosted at MGI, e.g. `read_report("marker_list2")` reads
#' `MRK_List2.rpt` directly from MGI server into R. See Supported Reports below
#' for options.
#'
#' - Using `report_file` and `report_type`: this approach is more flexible as
#' you can read directly from a file or URL.
#'
#' ## Supported Reports
#'
#' The set of currently supported reports:
#'
#' ```{r}
#' reports
#' ```
#'
#' @inheritParams common-args
#' @param n_max Maximum number of lines to read.
#'
#' @returns A [tibble][tibble::tibble-package] with report data in tidy
#'   format. The set of variables is dependent on the specific report requested:
#'
#'   - For `"marker_list1"`, see `vignette("marker_list1")`.
#'   - For `"marker_list2"`, see `vignette("marker_list2")`.
#'   - For `"marker_coordinates"`, see `vignette("marker_coordinates")`.
#'   - For `"gene_model_coordinates"`, see `vignette("gene_model_coordinates")`.
#'   - For `"sequence_coordinates"`, see `vignette("sequence_coordinates")`.
#'   - For `"genbank_refseq_ensembl_ids"`, see `vignette("genbank_refseq_ensembl_ids")`.
#'   - For `"swiss_trembl_ids"`, see `vignette("swiss_trembl_ids")`.
#'   - For `"swiss_prot_ids"`, see `vignette("swiss_prot_ids")`.
#'   - For `"gene_trap_ids"`, see `vignette("gene_trap_ids")`.
#'   - For `"ensembl_ids"`, see `vignette("ensembl_ids")`.
#'   - For `"biotype_conflicts"`, see `vignette("biotype_conflicts")`.
#'   - For `"primers"`, see `vignette("primers")`.
#'   - For `"interpro_domains"`, see `vignette("interpro_domains")`.
#'
#' @export
read_report <- function(report_key = NULL,
                        report_file = NULL,
                        report_type = NULL,
                        n_max = Inf) {

  if (rlang::is_empty(report_key) &&
      (rlang::is_empty(report_type) ||
       rlang::is_empty(report_type))) {
    msg <- paste(
      "Either pass a report key (`report_key`)",
      "or a report file/url (`report_file`)",
      "and its type (`report_type`)."
    )

    rlang::abort(msg)
  }

  if (!rlang::is_empty(report_key)) {
    report_file <- report_url(report_key)
    report_type <- report_type(report_key)
  } else {
    report_type <- match.arg(report_type, choices = reports$report_type)
  }

  reader <- report_type_to_reader[[report_type]]
  tbl <- reader(file = report_file, n_max = n_max)

  rpt_source <- find_report_source(report_file)
  rpt_last_modified <- find_report_last_modified(report_file)

  attr(tbl, "report_source") <- rpt_source
  attr(tbl, "report_datetime") <- rpt_last_modified

  tbl
}

read_tsv <- function(file,
                     col_names,
                     col_types = "c",
                     skip = 1L,
                     n_max = Inf,
                     na = c("null", "NULL", "N/A", ""),
                     comment = "") {
  vroom::vroom(
    file = file,
    delim = "\t",
    col_names = col_names,
    col_types = col_types,
    skip = skip,
    n_max = n_max,
    na = na,
    comment = comment
  )

}
