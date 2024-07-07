#' Common arguments
#'
#' A set of arguments that are commonly reused across functions of
#' `r desc_package_name()`.
#'
#' @param marker_id A character vector. MGI accession identifiers.
#' @param marker_symbol A character vector. MGI marker symbols.
#'
#' @param report_key A character vector. A key used to uniquely refer to an MGI
#'   report.
#' @param report_file A character vector. The file path or URL to an MGI report
#' file.
#' @param report_type A character vector. The type of an MGI report.
#'
#' @name common-args
#' @keywords internal
NULL

#
# Description of common variables
#
desc_report_key <- function() {
  paste(
    "A string key used to uniquely refer to an MGI report,",
    "which is only meaningful within the context of the `{mgi.report.reader}`."
  )
}

desc_report_file <- function() {
  paste(
    "MGI report file name as hosted at", "\\url{", mgi_reports_base_url(), "}."
  )
}

desc_report_type <- function() {
  paste(
    "MGI report type. The type is used internally to find the appropriate",
    "reader for parsing, and is only meaningful within the context of",
    paste0(desc_package_name(), ".")
  )
}

desc_report_name <- function() {
  paste(
    "MGI report name. Report names are taken from",
    paste0("\\url{", mgi_reports_base_url(), "index.html", "}.")
  )
}

desc_package_name <- function() {
  "`{mgi.report.reader}`"
}

desc_marker_status <- function() {
  paste(
    "genetic marker status is a factor with two levels:",
    "`'O'` for official, and `'W'` for withdrawn.",
    "Official indicates a currently in-use genetic marker, whereas withdrawn",
    "means that the symbol or name was once approved but has since been replaced."
  )
}

desc_marker_status <- function() {
  paste(
    "genetic marker status is a factor of two levels:",
    "`'O'` for official, and `'W'` for withdrawn.",
    "Official indicates a currently in-use genetic marker, whereas withdrawn",
    "means that the symbol or name was once approved but has since been replaced."
  )
}

desc_marker_type <- function() {

  paste0(
    'genetic marker type is a factor of 10 levels: ',
    paste(marker_types(), collapse = ", "),
    ". ",
    "See `?marker_type_definitions` for the meaning of each type."
  )
}

desc_marker_id <- function() {
  paste(
    "MGI accession identifier.",
    "A unique alphanumeric character string that is used to unambiguously",
    "identify a particular record in the Mouse Genome Informatics database.",
    "The format is `MGI:nnnnnn`, where `n` is a digit."
    )
}

desc_marker_symbol <- function() {
  paste("marker symbol is a unique abbreviation of the marker name.")
}

desc_marker_name <- function() {
  paste("marker name is a word or phrase that uniquely identifies the genetic marker,",
        "e.g. a gene or allele name.")
}

desc_feature_type <- function() {
  paste("an attribute of a portion of a genomic sequence. See the dataset",
        "`?feature_type_definitions` for details.")
}

desc_chromosome <- function() {
  paste(
    "mouse chromosome name. Possible values are names for the autosomal,",
    "sexual or mitochondrial chromosomes."
    )
}

desc_start <- function() {
  paste("genomic start position (one-offset).")
}

desc_end <- function() {
  paste("genomic end position (one-offset).")
}

desc_strand <- function() {
  paste("DNA strand, '+' for sense, and '-' for antisense.")
}

desc_genetic_map_pos <- function() {
  paste(
    "genetic map position in centiMorgan (cM): a unit of length in a genetic map.",
    "Two loci are 1 cM apart if recombination is detected between them in 1% of meioses."
    )
}

desc_synonyms <- function() {
  paste(
    "alternative marker symbols.",
    "These alternatives can be either an unofficial symbol that has appeared",
    "in the scientific literature or in public databases such as GenBank, or a",
    "formerly official symbol, withdrawn due to gene family revisions or to",
    "conform to the human ortholog symbol."
    )
}

desc_marker_id_now <- function() {
  paste(
    "genetic marker identifier replacement. If the record pertains a ",
    "`marker_symbol` that was withdrawn, then `marker_id_now` indicates",
    "the most recent in-use marker identifier that replaced it."
    )
}

desc_marker_symbol_now <- function() {
  paste(
    "genetic marker symbol replacement. If the record pertains a ",
    "`marker_symbol` that was withdrawn, then `marker_symbol_now` indicates",
    "the most recent in-use marker symbol that replaced it."
  )
}

desc_note <- function() {
  paste(
    "message about marker symbol withdrawal.",
    "When a symbol is withdrawn, the `note` includes a brief message",
    "indicating the reason for withdrawal. Most messages are of the form:",
    "`'withdrawn, = <gene symbol>'`. In many cases, the gene symbol indicated",
    "in the message will correspond to `marker_symbol_now`, but this is not",
    "always the case. Some withdrawn symbols have been remapped to other",
    "symbols, which may have subsequently been remapped again. Therefore,",
    "the note message will only indicate the first symbol remapping, while",
    "`marker_symbol_now` holds the most up-to-date marker symbol, if applicable."
  )
}

desc_assembly <- function() {
  paste(
    "mouse genome assembly version, a factor of two levels:",
    "`'GRCm38'` and `'GRCm39'`. Almost always `'GRCm39'`."
  )
}

desc_source <- function() {
  paste(
    "provider of the genomic annotation."
  )
}

desc_database <- function() {
  paste(
    "database or catalogue within the `source` that provides the genomic annotation."
  )
}

desc_entrez_gen_id <- function() {
  paste("mouse NCBI Entrez gene identifier, an integer number.")
}

desc_entrez_chromosome <- function() {
  paste("mouse chromosome name, according to NCBI gene model.")
}

desc_entrez_start <- function() {
  paste("genomic start position (one-offset), according to NCBI gene model.")
}

desc_entrez_end <- function() {
  paste("genomic end position (one-offset), according to NCBI gene model.")
}

desc_entrez_strand <- function() {
  paste("DNA strand, '+' for sense, and '-' for antisense, according to NCBI gene model.")
}

desc_ensembl_gen_id <- function() {
  paste("mouse Ensembl gene identifier, a string of the format `ENSMUSG[a unique eleven digit number].")
}

desc_ensembl_chromosome <- function() {
  paste("mouse chromosome name, according to Ensembl gene model.")
}

desc_ensembl_start <- function() {
  paste("genomic start position (one-offset), according to Ensembl gene model.")
}

desc_ensembl_end <- function() {
  paste("genomic end position (one-offset), according to Ensembl gene model.")
}

desc_ensembl_strand <- function() {
  paste("DNA strand, '+' for sense, and '-' for antisense, according to Ensembl gene model.")
}

desc_genbank_id <- function() {
  paste("NCBI GenBank identifier(s), a list-column.")
}

desc_refseq_trp_id <- function() {
  paste("NCBI RefSeq transcript identifier(s), a list-column.")
}

desc_refseq_prt_id <- function() {
  paste("NCBI RefSeq protein identifier(s), a list-column.")
}

desc_ensembl_trp_id <- function() {
  paste("Ensembl transcript identifier(s), a list-column.")
}

desc_ensembl_prt_id <- function() {
  paste("Ensembl protein identifier(s), a list-column.")
}

desc_swiss_prt_id <- function() {
  paste("UniProtKB/Swiss-Prot identifier(s), a list-column.")
}

desc_tr_embl_prt_id <- function() {
  paste("UniProtKB/TrEMBL identifier(s), a list-column.")
}

desc_unigene_id <- function() {
  paste("NCBI UniGene identifier(s), a character vector.")
}

desc_uniprot_id <- function() {
  paste("UniProtKB/Swiss-Prot or UniProtKBTrEMBL identifier(s), a list-column.")
}

desc_cell_line_id <- function() {
  paste(
    "a list-column of unique identifier(s) assigned to each gene trap cell",
    "line. In gene trapping experiments, this ID is crucial for tracking and",
    "cataloging the specific embryonic stem (ES) cell lines that have undergone",
    "genome-wide insertional mutations. Each `cell_line_id` corresponds to a",
    "mutant cell line in which a gene has been disrupted by the integration of",
    "a selection gene, potentially altering gene expression or protein production.",
    "The identifier facilitates the retrieval of information regarding the specific",
    "site of integration, which can be further characterized by cloning, cDNA",
    "extension, or direct sequencing of the insertion site.")
}

desc_ensembl_biotype <- function() {
  paste(
    "Ensembl's biotype, gene or transcript classification.",
    "See Ensembl documentation on",
    "[Biotypes](https://www.ensembl.org/info/genome/genebuild/biotypes.html)",
    "for more details."
  )
}

desc_biotype <- function() {
  paste(
    "a gene or transcript biotype, according to any of the gene models by",
    "NCBI, Ensembl or MGI."
    )
}

desc_is_mgi_rep <- function() {
  paste(
    "a logical, indicating whether the genetic marker is for gene model",
    "that is the MGI representative."
  )
}

desc_gene_id <- function() {
  paste(
    "a gene identifier from either NCBI, Ensembl or MGI."
  )
}

desc_primer_id <- function() {
  paste(
    "an MGI accession identifier standing for a PCR primer.",
    "A unique alphanumeric character string that is used to unambiguously",
    "identify a particular record in the Mouse Genome Informatics database.",
    "The format is `MGI:nnnnnn`, where `n` is a digit."
  )
}

desc_primer_name <- function() {
  paste(
    "PCR primer pair name."
  )
}

desc_primer_fwd_seq <- function() {
  paste(
    "PCR primer forward sequence."
  )
}

desc_primer_rev_seq <- function() {
  paste(
    "PCR primer reverse sequence."
  )
}

desc_primer_amplimer_size <- function() {
  paste(
    "PCR primer amplimer size, as a **character vector**."
  )
}

desc_interpro_id <- function() {
  paste(
    "InterPro domain identifier."
  )
}

desc_interpro_domain <- function() {
  paste(
    "InterPro domain name."
  )
}
