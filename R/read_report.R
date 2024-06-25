#' Read an MGI report
#'
#' [read_report()] reads in an MGI report.
#'
#' @param report_file A path or URL to an MGI report file.
#' @param report_type Report type, one of:
#' - `"MRK_List1"`: Mouse Genetic Markers (including withdrawn marker symbols).
#' - `"MRK_List2"`: Mouse Genetic Markers (excluding withdrawn marker symbols).
#' - `"MGI_MRK_Coord"`: MGI Marker Coordinates.
#' - `"MGI_GTGUP"`: MGI Sequence Coordinates.
#' - `"MRK_Sequence"`: MGI Marker associations to Sequence (GenBank, RefSeq,
#'                     Ensembl) information.
#' - `"MRK_SwissProt_TrEMBL"`: MGI Marker associations to SWISS-PROT and TrEMBL
#'                             protein IDs.
#' - `"MRK_SwissProt"`: MGI Marker associations to SWISS-PROT protein IDs.
#' - `"MRK_GeneTrap"`: MGI Marker associations to Gene Trap IDs.
#' - `"MRK_ENSEMBL"`: MGI Marker associations to Ensembl sequence information.
#' - `"MGI_BioTypeConflict"`: MGI Marker associations to Ensembl or NCBI gene
#'                            models where a gene vs. pseudogene discrepancy
#'                            exists.
#' - `"MGI_InterProDomains"`: InterPro domain associations to MGI markers.
#' @param n_max Maximum number of lines to read.
#'
#' @examples
#' base_url <- "https://www.informatics.jax.org/downloads/reports"
#' url <- file.path(base_url, "MRK_List1.rpt")
#' # Import the Mouse Genetic Markers (including withdrawn marker symbols) Report
#' read_report(url, "MRK_List1", n_max = 10L)
#'
#' @returns A [tibble][tibble::tibble-package] with the report data in tidy
#'   format.
#'
#' @export
read_report <- function(report_file,
                        report_type = c(
                          "MRK_List1",
                          "MRK_List2",
                          "MGI_MRK_Coord",
                          "MGI_Gene_Model_Coord",
                          "MGI_GTGUP",
                          "MRK_Sequence",
                          "MRK_SwissProt_TrEMBL",
                          "MRK_SwissProt",
                          "MRK_GeneTrap",
                          "MRK_ENSEMBL",
                          "MGI_BioTypeConflict",
                          "MGI_InterProDomains"
                        ),
                        n_max = Inf) {

  report_type <- match.arg(report_type)
  read <- list(MRK_List1 = read_mrk_list_rpt,
               MRK_List2 = read_mrk_list_rpt,
               MGI_MRK_Coord = read_mrk_coord_rpt,
               MGI_GTGUP = read_gtgup_rpt,
               MRK_Sequence = read_mrk_sequence_rpt,
               MRK_SwissProt_TrEMBL = read_mrk_swissprot_tr_embl_rpt,
               MRK_SwissProt = read_mrk_swissprot_rpt,
               MRK_GeneTrap = read_mrk_genetrap_rpt,
               MRK_ENSEMBL = read_mrk_ensembl_rpt,
               MGI_BioTypeConflict = read_mgi_biotype_conflict_rpt,
               MGI_InterProDomains = read_mgi_inter_pro_domains_rpt)

  read[[report_type]](file = report_file, n_max = n_max)
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

# A sort of drop-in replacement of `read_tsv()` which is backed up by
# `vroom::vroom()`, while `read_tsv2()` is backed up `data.table::fread()`which
# has the useful `fill` parameter for when we have missing columns.
read_tsv2 <- function(file,
                     col_names,
                     col_types = "c",
                     skip = 1L,
                     n_max = Inf,
                     na = c("null", "NULL", "N/A", "")) {

  col_types_mapping <- c(
    `c` = "character",
    `i` = "integer",
    `n` = "numeric",
    `d` = "numeric",
    `l` = "logical",
    `f` = "factor",
    `D` = "Date",
    `-` = "NULL"
  )

  col_types <- unlist(strsplit(col_types, split = ""))
  col_classes <- unname(col_types_mapping[col_types])

  data.table::fread(
    input = file,
    sep = "\t",
    col.names	= col_names,
    colClasses = col_classes,
    # header = TRUE,
    nrows = n_max,
    na.strings	= na,
    fill = TRUE,
    showProgress = FALSE
  ) |>
    tibble::as_tibble()

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
read_mrk_list_rpt <- function(file, n_max = Inf) {
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

read_mrk_coord_rpt <- function(file, n_max = Inf) {
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
      "provider",
      "provider_display"
    )

  # Last column is spurious, so we skip it ("-").
  col_types <- "cccccciicccc-"
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
      genome_assembly = genome_assembly_col(.data$genome_assembly),
      chr = chr_col(.data$chr),
      strand = strand_col(.data$strand),
      feature_type = feature_type_col(.data$feature_type),
      provider = factor(.data$provider, levels = unique(.data$provider)),
      provider_display = factor(.data$provider_display, levels = unique(.data$provider_display))
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
      .data$provider,
      .data$provider_display
    )
}

read_gene_model_coord_rpt <- function(file, n_max = Inf) {
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
    col_types = col_types,
    n_max = n_max
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

read_gtgup_rpt <- function(file, n_max = Inf) {
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
    col_types = col_types,
    n_max = n_max
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

read_mrk_sequence_rpt <- function(file, n_max = Inf) {
  col_names <-
    c(
      "marker_id",
      "marker_symbol",
      "status",
      "marker_type",
      "marker_name",
      "cM_pos",
      "chr",
      "start",
      "end",
      "strand",
      "genbank_id",
      "refseq_trp_id",
      "ensembl_trp_id",
      "uniprot_id",
      "tr_embl_id",
      "ensembl_prt_id",
      "refseq_prt_id",
      "unigene_id",
      "feature_type"
    )

  col_types <- "ccccccciicccccccccc"
  # Import data
  read_tsv(
    file = file,
    col_names = col_names,
    col_types = col_types,
    n_max = n_max
  ) |>
    dplyr::mutate(
      cM_pos = cM_pos_col(.data$cM_pos),
      chr = chr_col(.data$chr),
      status = status_col(.data$status),
      marker_type = marker_type_col(.data$marker_type),
      strand = strand_col(.data$strand),
      feature_type = factor(.data$feature_type, levels = feature_types$feature_type)
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
      .data$genbank_id,
      .data$refseq_trp_id,
      .data$ensembl_trp_id,
      .data$uniprot_id,
      .data$tr_embl_id,
      .data$ensembl_prt_id,
      .data$refseq_prt_id,
      .data$unigene_id
    )
}

read_mrk_swissprot_tr_embl_rpt <- function(file, n_max = Inf) {
  col_names <-
    c(
      "marker_id",
      "marker_symbol",
      "status",
      "marker_name",
      "cM_pos",
      "chr",
      "protein_ids"
    )

  col_types <- "ccccccc"
  # Import data
  read_tsv(
    file = file,
    col_names = col_names,
    col_types = col_types,
    n_max = n_max
  ) |>
    dplyr::mutate(
      cM_pos = cM_pos_col(.data$cM_pos),
      chr = chr_col(.data$chr),
      status = status_col(.data$status),
      protein_ids = protein_ids_col(.data$protein_ids)
    ) |>
    dplyr::relocate(
      .data$marker_id,
      .data$marker_symbol,
      .data$marker_name,
      .data$status,
      .data$cM_pos,
      .data$chr,
      .data$protein_ids
    )
}

read_mrk_swissprot_rpt <- function(file, n_max = Inf) {
  col_names <-
    c(
      "marker_id",
      "marker_symbol",
      "status",
      "marker_name",
      "cM_pos",
      "chr",
      "spp_id"
    )

  col_types <- "ccccccc"
  # Import data
  read_tsv(
    file = file,
    col_names = col_names,
    col_types = col_types,
    n_max = n_max
  ) |>
    dplyr::mutate(
      cM_pos = cM_pos_col(.data$cM_pos),
      chr = chr_col(.data$chr),
      status = status_col(.data$status)
    ) |>
    dplyr::relocate(
      .data$marker_id,
      .data$marker_symbol,
      .data$marker_name,
      .data$status,
      .data$cM_pos,
      .data$chr,
      .data$spp_id
    )
}

read_mrk_genetrap_rpt <- function(file, n_max = Inf) {
  col_names <-
    c(
      "marker_id",
      "marker_symbol",
      "status",
      "marker_type",
      "marker_name",
      "cM_pos",
      "chr",
      "cell_line"
    )

  col_types <- "cccccccc-"
  # Import data
  read_tsv(
    file = file,
    col_names = col_names,
    col_types = col_types,
    n_max = n_max
  ) |>
    dplyr::mutate(
      cM_pos = cM_pos_col(.data$cM_pos),
      chr = chr_col(.data$chr),
      status = status_col(.data$status),
      marker_type = marker_type_col(.data$marker_type),
      cell_line = cell_line_col(.data$cell_line)
    ) |>
    dplyr::relocate(
      .data$marker_id,
      .data$marker_symbol,
      .data$marker_name,
      .data$marker_type,
      .data$status,
      .data$cM_pos,
      .data$chr,
      .data$cell_line
    )
}

read_mrk_ensembl_rpt <- function(file, n_max = Inf) {
  col_names <-
    c(
      "marker_id",
      "marker_symbol",
      "marker_name",
      "cM_pos",
      "chr",
      "ensembl_id",
      "ensembl_trp_id",
      "ensembl_prt_id",
      "feature_type",
      "start",
      "end",
      "strand",
      "biotype"
    )

  col_types <- "ccccccccciicc"
  # Import data
  read_tsv2(
    file = file,
    col_names = col_names,
    col_types = col_types,
    n_max = n_max
  ) |>
    dplyr::mutate(
      cM_pos = cM_pos_col(.data$cM_pos),
      chr = chr_col(.data$chr),
      strand = strand_col(.data$strand),
      feature_type = special_feature_type_col(.data$feature_type),
      biotype = biotype_col(.data$biotype),
      ensembl_trp_id = ensembl_trp_id_col(.data$ensembl_trp_id),
      ensembl_prt_id = ensembl_trp_id_col(.data$ensembl_prt_id)
    ) |>
    dplyr::relocate(
      .data$marker_id,
      .data$marker_symbol,
      .data$marker_name,
      .data$cM_pos,
      .data$chr,
      .data$start,
      .data$end,
      .data$strand,
      .data$ensembl_id,
      .data$ensembl_trp_id,
      .data$ensembl_prt_id,
      .data$feature_type,
      .data$biotype
    )
}

read_mgi_biotype_conflict_rpt <- function(file, n_max = Inf) {
  col_names <-
    c(
      "marker_id",
      "marker_symbol",
      "provider",
      "gene_id",
      "biotype",
      "mgi_gene_model"
    )

  col_types <- "cccccc"
  # Import data
  vroom::vroom_lines(file = file) |>
    # Keep only lines that contain data.
    grep("^MGI", x = _, value = TRUE) |>
    paste(collapse = "\n") |>
    read_tsv(col_names = col_names,
             col_types = col_types,
             n_max = n_max) |>
  dplyr::mutate(
    provider = provider_col(.data$provider)
  ) |>
  dplyr::relocate(
    .data$marker_id,
    .data$marker_symbol,
    .data$provider,
    .data$gene_id,
    .data$mgi_gene_model,
    .data$biotype
  )
}

# Marker Symbol
# Marker Name
# Primer Marker Name
# MGI Marker Accession ID
# MGI Primer Pair ID
# Primer 1 Sequence
# Primer 2 Sequence
# Amplimer Size
# Chromosome
# Map Position

# FIX: This function is not working at the moment because of a bad formatting
# of PRB_PrimerSeq.rpt. Filed an issue, now waiting for feedback.
# read_prb_primerseq_rpt <- function(file, n_max = Inf) {
#   col_names <-
#     c(
#       "marker_symbol",
#       "marker_name",
#       "primer_marker_name",
#       "marker_id",
#       "primer_pair_id",
#       "primer_one_sequence",
#       "primer_two_sequence",
#       "amplimer_size",
#       "chr",
#       "cM_pos"
#     )
#
#   col_types <- "cccccccccc"
#   # Import data
#   read_tsv(
#     file = file,
#     col_names = col_names,
#     col_types = col_types,
#     n_max = n_max
#   ) |>
#     dplyr::mutate(
#       cM_pos = cM_pos_col(.data$cM_pos),
#       chr = chr_col(.data$chr)
#     ) |>
#     dplyr::relocate(
#       .data$marker_id,
#       .data$marker_symbol,
#       .data$marker_name,
#       .data$primer_pair_id,
#       .data$primer_marker_name,
#       .data$chr,
#       .data$cM_pos,
#       .data$amplimer_size,
#       .data$primer_one_sequence,
#       .data$primer_two_sequence
#     )
# }

read_mgi_inter_pro_domains_rpt <- function(file, n_max = Inf) {
  col_names <-
    c(
      "interpro_id",
      "interpro_domain",
      "marker_id",
      "marker_symbol"
    )

  col_types <- "cccc"
  # Import data
  read_tsv(
    file = file,
    col_names = col_names,
    col_types = col_types,
    n_max = n_max
  ) |>
    dplyr::relocate(
      .data$interpro_id,
      .data$interpro_domain,
      .data$marker_id,
      .data$marker_symbol
    )
}
