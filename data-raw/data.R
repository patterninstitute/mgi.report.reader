library(tibble)
library(usethis)
library(rvest)

#
# `reports`:
#
#   A tidy data set of supported reports, i.e. reports for which we
#   provide readers.
#
reports <-
  tibble::tribble(
    ~report_key, ~report_file, ~report_type, ~report_name,
    "marker_list1",
    "MRK_List1.rpt","MRK_List1", "Mouse Genetic Markers (including withdrawn marker symbols)",

    "marker_list2",
    "MRK_List2.rpt","MRK_List2", "Mouse Genetic Markers (excluding withdrawn marker symbols)",

    "marker_coordinates",
    "MGI_MRK_Coord.rpt","MGI_MRK_Coord", "MGI Marker Coordinates",

    "gene_model_coordinates",
    "MGI_Gene_Model_Coord.rpt", "MGI_Gene_Model_Coord", "MGI Gene Model Coordinates",

    "sequence_coordinates",
    "MGI_GTGUP.gff","MGI_GTGUP", "MGI Sequence Coordinates",

    "genbank_refseq_ensembl_ids",
    "MRK_Sequence.rpt","MRK_Sequence", "MGI Marker associations to Sequence (GenBank, RefSeq, Ensembl) information",

    "swiss_trembl_ids",
    "MRK_SwissProt_TrEMBL.rpt","MRK_SwissProt_TrEMBL", "MGI Marker associations to SWISS-PROT and TrEMBL protein IDs",

    "swiss_prot_ids",
    "MRK_SwissProt.rpt","MRK_SwissProt", "MGI Marker associations to SWISS-PROT protein IDs",

    "gene_trap_ids",
    "MRK_GeneTrap.rpt","MRK_GeneTrap", "MGI Marker associations to Gene Trap IDs",

    "ensembl_ids",
    "MRK_ENSEMBL.rpt","MRK_ENSEMBL", "MGI Marker associations to Ensembl sequence information",

    "biotype_conflicts",
    "MGI_BioTypeConflict.rpt","MGI_BioTypeConflict", "MGI Marker associations to Ensembl or NCBI gene models where a gene vs. pseudogene discrepancy exists",

    "primers",
    "PRB_PrimerSeq.rpt","PRB_PrimerSeq", "MGI Marker associations with primer pairs",

    "interpro_domains",
    "MGI_InterProDomains.rpt","MGI_InterProDomains", "InterPro domain associations to MGI markers"
  )




#
#
# Feature types
#
#

url <- "https://www.informatics.jax.org/userhelp/GENE_feature_types_help.shtml"

html <- rvest::read_html(url)
feature_type_tbl <- rvest::html_table(html)[[2]]

feature_types01 <-
  feature_type_tbl |>
  dplyr::relocate(feature_type = `Feature Type`, so_id = `CorrespondingSO ID`, definition = `MGI Definition`) |>
  # Here we complement the feature types provided by MGI in their HTML table
  # with a few extra terms that are found in the reports but that are not
  # included in the HTML table.
  dplyr::bind_rows(
    dplyr::tribble(
      ~ feature_type, ~ so_id, ~ definition,
      "imprinting control region", "SO:0002191", "A regulatory region that controls epigenetic imprinting and affects the expression of target genes in an allele- or parent-of-origin-specific manner. Associated regulatory elements may include differentially methylated regions and non-coding RNAs.",
      "intronic regulatory region", "SO:0001492", "A regulatory region that is part of an intron.",
      "silencer", "SO:0000625", "A regulatory region which upon binding of transcription factors, suppress the transcription of the gene or genes they control.",
      "locus control region", "SO:0000037", "A DNA region that includes DNAse hypersensitive sites located near a gene that confers the high-level, position-independent, and copy number-dependent expression to that gene.",
      "insulator", "SO:0000627", "A regulatory region that 1) when located between a CRM and a gene's promoter prevents the CRM from modulating that genes expression and 2) acts as a chromatin boundary element or barrier that can block the encroachment of condensed chromatin from an adjacent region.",
      "response element", "SO:0002205", "A regulatory element that acts in response to a stimulus, usually via transcription factor binding.",
      "origin of replication", "SO:0000296", "A region of nucleic acid from which replication initiates; includes sequences that are recognized by replication proteins, the site from which the first separation of complementary strands occurs, and specific replication start sites.",
      "transcriptional cis regulatory region", "SO:0001055", "A regulatory_region that modulates the transcription of a gene or genes.",
      "TSS cluster", "SO:0001915", "A region defined by a cluster of experimentally determined transcription starting sites."
    )
  ) |>
  # In the reports these terms are typically used in lowercase, not titlecase, so we change it here accordingly.
  dplyr::mutate(
    feature_type = dplyr::if_else(feature_type %in% c("Open chromatin region", "Promoter flanking region"), tolower(feature_type), feature_type)) |>
  dplyr::mutate(so_id = dplyr::if_else(so_id == "", NA_character_, so_id))

order <-
  c(1, 2, 23, 24, 22, 25, 26, 27, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16,
    17, 18, 19, 20, 21, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41,
    42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60,
    61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71
  )

feature_types <- feature_types01[order, ]

# Export to file too.
readr::write_csv(feature_types, file = "data-raw/feature_types.csv")
readr::write_csv(reports, file = "data-raw/reports.csv")

# Export data sets
usethis::use_data(feature_types, overwrite = TRUE, compress = "xz")
usethis::use_data(reports, overwrite = TRUE, compress = "xz")

# Internal data
usethis::use_data(reports, feature_types, internal = TRUE, overwrite = TRUE)
