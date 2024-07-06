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

feature_type_definitions <- feature_types01[order, ]


#
#
# Marker types
#
#

marker_type_definitions <-
  tibble::tribble(
    ~marker_type, ~definition,
    "Gene", "A locus in the cytoplasmic or nuclear genome that is necessary and sufficient to express the complete complement of functional products derived from a unit of transcription.",
    "GeneModel", "A representation of an mRNA transcript of a gene that contains information about features of the transcript such as exon-intron boundaries, splice sites, UTRs, etc.. Due to alternative splicing of mRNA transcripts, there may be more than one gene model for any given gene.",
    "Pseudogene", "A non-functional locus derived from a functional locus either by: 1. replicative transfer, such as transposition, retrotransposition or duplication, 2. mutation, where the non-functional locus is not considered an allele of an existing functional locus in the mouse.",
    "DNA Segment", "A genomic feature recognized by anonymous DNA probes: a segment of DNA not known to correspond to a named gene that can be used as a marker in the construction of genetic maps.",
    "Transgene", "Any DNA sequence or combination of sequences that has been introduced via a construct into the germ line of the animal by random integration.",
    "QTL", "Quantitative Trait Locus (QTL): the type of marker described by statistical association to quantitative variation in a particular phenotypic trait that is thought to be controlled by the cumulative action of alleles at multiple loci.",
    "Cytogenetic Marker", "A structure within a chromosome that is visible by microscopic examination, possibly after special staining methods are used.",
    "BAC/YAC end", "BAC/YAC end refers to sequences at the end of foreign DNA inserts in a BAC or YAC. These sequences are a source of Sequence Tagged Sites (STSs) to determine the extent of overlap between Bacterial Artificial Chromosomes (BACs) or Yeast Artificial Chromosome (YACs) and to aid in the alignment of sequence contigs.",
    "Complex/Cluster/Region", "Refers to any of the following: 1. Gene complex; a group of genes closely linked together that are related evolutionarily or functionally. Interspersed unrelated genes located within the group are included. 2. A segment of the mouse genome defined by comparison to an orthologous segment in the genome of another species, or by some specific characteristic, such as loss of heterozygosity. 3. A marker repository for information pertaining to a specific gene family, where such information lacks precise family member resolution.",
    "Other Genome Feature", "Refers to any feature of the genome that is considered to have biological significance but that cannot be classified with defined marker types. Major classes of other genome features include Endogenous Viruses and Retrotransposons, Integration Sites, and Repetitive Elements. An additional class of such features includes genomic segments that function or are biologically significant as DNA elements."
  )


# Export to file.
readr::write_csv(feature_type_definitions, file = "data-raw/feature_type_definitions.csv")
readr::write_csv(marker_type_definitions, file = "data-raw/marker_type_definitions.csv")
readr::write_csv(reports, file = "data-raw/reports.csv")

# Export data sets
usethis::use_data(feature_type_definitions, overwrite = TRUE, compress = "xz")
usethis::use_data(reports, overwrite = TRUE, compress = "xz")
usethis::use_data(marker_type_definitions, overwrite = TRUE, compress = "xz")

# Internal data
usethis::use_data(reports, feature_type_definitions, marker_type_definitions, internal = TRUE, overwrite = TRUE)
