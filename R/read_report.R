#' Read an MGI report
#'
#' [read_report()] reads in an MGI report.
#'
#' @param report_file A path or URL to an MGI report file.
#' @param report_type Report type.
#'
#' @examples
#' if (FALSE) {
#' base_url <- "https://www.informatics.jax.org/downloads/reports"
#'
#' # Import the Mouse Genetic Markers (including withdrawn marker symbols) Report
#' read_report(file.path(base_url, "MRK_List1.rpt"), "MRK_List1")
#'
#' # Import Mouse Genetic Markers (excluding withdrawn marker symbols) Report
#' read_report(file.path(base_url, "MRK_List2.rpt"), "MRK_List2")
#'
#' # Import the MGI Marker Coordinates' Report
#' read_report(file.path(base_url, "MGI_MRK_Coord.rpt"), "MGI_MRK_Coord")
#'
#' # Import the MGI Sequence Coordinates (in GFF format)
#' read_report(file.path(base_url, "MGI_GTGUP.gff"), "MGI_GTGUP")
#' }
#'
#' @returns A [tibble][tibble::tibble-package] with the report data in tidy
#'   format.
#'
#' @export
read_report <- function(report_file,
                        report_type = c("MRK_List1",
                                        "MRK_List2",
                                        "MGI_MRK_Coord",
                                        "MGI_Gene_Model_Coord",
                                        "MGI_GTGUP")) {

  report_type <- match.arg(report_type)
  read <- list(MRK_List1 = read_mrk_list_rpt,
               MRK_List2 = read_mrk_list_rpt,
               MGI_MRK_Coord = read_mrk_coord_rpt,
               MGI_GTGUP = read_gtgup_rpt)

  read[[report_type]](file = report_file)
}

read_tsv <- function(file,
                     col_names,
                     col_types = "c",
                     skip = 1L,
                     na = c("null", "NULL", "N/A", "")) {
  vroom::vroom(
    file = file,
    delim = "\t",
    col_names = col_names,
    col_types = col_types,
    skip = skip,
    na = na
  )

}

#' Read a marker list report
#'
#' [read_mrk_list_rpt()] imports either a `MRK_List1.rpt` or a `MRK_List2.rpt`
#' report file. See [MGI Data and Statistical
#' Reports](https://www.informatics.jax.org/downloads/reports/index.html) for
#' more details.
#'
#' @param file Path to a report file.
#'
#' @returns A [tibble][tibble::tibble-package] with the following variables (or
#'   a subset of):
#' \describe{
#'   \item{marker_id}{Character. The unique MGI identifier for the marker.}
#'   \item{marker_symbol}{Character. The MGI symbol representing the marker.}
#'   \item{marker_name}{Character. The full name of the marker.}
#'   \item{marker_type}{Factor. The type of the marker (e.g., Gene, BAC/YAC end,
#'   DNA segment).}
#'   \item{status}{Factor. The status of the marker (e.g., `"O"` for official or
#'   `"W"` for withdrawn).}
#'   \item{cM_pos}{Double. The position of the marker in centiMorgans (cM) on
#'   the chromosome.}
#'   \item{chr}{Factor. The chromosome on which the marker is located.}
#'   \item{start}{Integer. The start position of the marker on the chromosome.}
#'   \item{end}{Integer. The end position of the marker on the chromosome.}
#'   \item{strand}{Factor. The DNA strand on which the marker is located (e.g.,
#'   plus (`"+"`) or minus (`"-"`)).}
#'   \item{feature_type}{Character. The feature type of the marker (e.g., gene,
#'   lncRNA gene, DNA segment). In most cases a sequence ontology term.}
#'   \item{synonyms}{List-column. A list of synonyms for the marker.}
#' }
#'
#' @keywords internal
read_mrk_list_rpt <- function(file) {
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
      "synonyms"
    )

  col_types <- "ccciiccfcfcc"
  # Import data
  read_tsv(
    file = file,
    col_names = col_names,
    col_types = col_types
  ) |>
    dplyr::mutate(
      marker_id = marker_id_col(.data$marker_id),
      marker_type = marker_type_col(.data$marker_type),
      cM_pos = cM_pos_col(.data$cM_pos),
      chr = chr_col(.data$chr),
      strand = strand_col(.data$strand),
      status = status_col(.data$status),
      feature_type = feature_type_col(.data$feature_type),
      synonyms = synonyms_col(.data$synonyms)
    ) |>
    dplyr::relocate(
      .data$marker_id,
      .data$marker_symbol,
      .data$marker_name,
      .data$marker_type,
      .data$status,
      .data$cM_pos,
      .data$chr,
      .data$start,
      .data$end,
      .data$strand,
      .data$feature_type,
      .data$synonyms
    )
}

read_mrk_coord_rpt <- function(file) {
  col_names <-
    c(
      "marker_id",
      "marker_type",
      "feature_type",
      "marker_symbol",
      "marker_name",
      "chr",
      "start",
      "end",
      "strand",
      "genome_assembly",
      "provider_collection",
      "provider_display"
    )

  # Last column is spurious, so we skip it ("-").
  col_types <- "cccccciicccc-"
  # Import data
  read_tsv(
    file = file,
    col_names = col_names,
    col_types = col_types
  ) |>
    dplyr::mutate(
      marker_id = marker_id_col(.data$marker_id),
      marker_type = marker_type_col(.data$marker_type),
      genome_assembly = genome_assembly_col(.data$genome_assembly),
      chr = chr_col(.data$chr),
      strand = strand_col(.data$strand),
      feature_type = feature_type_col(.data$feature_type)
    ) |>
    dplyr::relocate(
      .data$marker_id,
      .data$marker_type,
      .data$marker_symbol,
      .data$marker_name,
      .data$genome_assembly,
      .data$chr,
      .data$start,
      .data$end,
      .data$strand,
      .data$feature_type,
      .data$provider_collection,
      .data$provider_display
    )
}

read_gene_model_coord_rpt <- function(file) {
  col_names <-
    c(
      "marker_id",
      "marker_type",
      "marker_symbol",
      "marker_name",
      "genome_assembly",
      "entrez_id",
      "entrez_chr",
      "entrez_start",
      "entrez_end",
      "entrez_strand",
      "ensembl_id",
      "ensembl_chr",
      "ensembl_start",
      "ensembl_end",
      "ensembl_strand"
    )

  col_types <- "ccccciciiccciic"
  # Import data
  read_tsv(
    file = file,
    col_names = col_names,
    col_types = col_types
  ) |>
    dplyr::mutate(
      marker_id = marker_id_col(.data$marker_id),
      marker_type = marker_type_col(.data$marker_type),
      genome_assembly = genome_assembly_col(.data$genome_assembly),
      entrez_chr = chr_col(.data$entrez_chr),
      ensembl_chr = chr_col(.data$ensembl_chr),
      entrez_strand = strand_col(.data$entrez_strand),
      ensembl_strand = strand_col(.data$ensembl_strand)
    ) |>
    dplyr::relocate(
      .data$marker_id,
      .data$marker_type,
      .data$marker_symbol,
      .data$marker_name,
      .data$genome_assembly,
      .data$entrez_id,
      .data$entrez_chr,
      .data$entrez_start,
      .data$entrez_end,
      .data$entrez_strand,
      .data$ensembl_id,
      .data$ensembl_chr,
      .data$ensembl_start,
      .data$ensembl_end,
      .data$ensembl_strand
    )
}

read_gtgup_rpt <- function(file) {
  col_names <-
    c(
      "chr",
      "feature_source",
      "marker_type",
      "start",
      "end",
      "empty1",
      "strand",
      "empty2",
      "misc"
    )

  col_types <- "cccii-c-c"
  # Import data
  read_tsv(
    file = file,
    col_names = col_names,
    col_types = col_types
  ) |>
    dplyr::mutate(
      chr = chr_col(stringr::str_remove(.data$chr, "^chr")),
      feature_source = as.factor(.data$feature_source),
      marker_type = marker_type_col(.data$marker_type),
      strand = strand_col(.data$strand)
    ) |>
    extract_gff_attributes("misc") |>
    dplyr::mutate(feature_type = factor(.data$feature_type, levels = feature_types$feature_type)) |>
    dplyr::relocate(
      .data$marker_id,
      .data$marker_symbol,
      .data$marker_type,
      .data$chr,
      .data$start,
      .data$end,
      .data$strand,
      .data$feature_source,
      .data$feature_type
    )
}
