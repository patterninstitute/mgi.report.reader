# synonyms_col <- function(synonyms) {
#
#   synonyms <- strsplit(synonyms, "|", fixed = TRUE)
#   # Convert single NA values to empty character vectors in the list-column.
#   dplyr::if_else(sapply(synonyms, \(x) length(x) == 1L && is.na(x)), list(character()), synonyms)
# }

# strand_col <- function(strand) {
#   factor(strand, levels = strands()) # "." is implicitly mapped to NA.
# }

# chr_col <- function(chr) {
#   factor(chr, levels = chromosomes())
# }

# cM_pos_col <- function(cM_pos) {
#   as.double(dplyr::if_else(cM_pos %in% c("syntenic", "N/A", "-1.0"), NA_character_, cM_pos))
# }

# status_col <- function(status) {
#   factor(status, levels = c("O", "W"))
# }

# marker_id_col <- function(marker_id) {
#   dplyr::if_else(marker_id == "NULL", NA_character_, marker_id)
# }

# genome_assembly_col <- function(genome_assembly) {
#   as.factor(genome_assembly)
# }

# feature_type_col <- function(feature_type) {
#   factor(feature_type, levels = feature_types$feature_type)
# }

# marker_type_col <- function(marker_type) {
#   factor(marker_type, levels = marker_types())
# }

protein_ids_col <- function(protein_ids) {

  protein_ids <- strsplit(protein_ids, " ", fixed = TRUE)
  # Convert single NA values to empty character vectors in the list-column.
  dplyr::if_else(sapply(protein_ids, \(x) length(x) == 1L && is.na(x)), list(character()), protein_ids)
}

# cell_line_col <- function(cell_line) {
#
#   cell_line <- strsplit(cell_line, " ", fixed = TRUE)
#   # Convert single NA values to empty character vectors in the list-column.
#   dplyr::if_else(sapply(cell_line, \(x) length(x) == 1L && is.na(x)), list(character()), cell_line)
# }

special_feature_type_col <- function(feature_type) {

  # In cases like:
  # "lncRNA gene|lncRNA gene|lncRNA gene"
  # keep only one instance. This assumes the values pipe-separated are repeated,
  # this is the case in MRK_ENSEMBL.rpt.
  feature_type <- sub("\\|.+", "", feature_type)

  factor(feature_type, levels = feature_types$feature_type)
}

# biotype_col <- function(biotype) {
#   biotype <- strsplit(biotype, "|", fixed = TRUE)
#   # Convert single NA values to empty character vectors in the list-column.
#   dplyr::if_else(sapply(biotype, \(x) length(x) == 1L && is.na(x)), list(character()), biotype) |>
#     sapply(\(x) unique(x))
# }


# ensembl_trp_id_col <- function(ensembl_trp_id) {
#   ensembl_trp_id <- strsplit(ensembl_trp_id, " ", fixed = TRUE)
#   # Convert single NA values to empty character vectors in the list-column.
#   dplyr::if_else(sapply(ensembl_trp_id, \(x) length(x) == 1L && is.na(x)), list(character()), ensembl_trp_id)
# }
#
# ensembl_prt_id_col <- function(ensembl_prt_id) {
#   ensembl_prt_id <- strsplit(ensembl_prt_id, " ", fixed = TRUE)
#   # Convert single NA values to empty character vectors in the list-column.
#   dplyr::if_else(sapply(ensembl_prt_id, \(x) length(x) == 1L && is.na(x)), list(character()), ensembl_prt_id)
# }

# provider_col <- function(provider) {
#   providers <- c(
#     "MGI",
#     "NCBI Gene Model",
#     "Ensembl Gene Model",
#     "Ensembl Reg Gene Model",
#     "QTL",
#     "RIKEN",
#     "gff3blat",
#     "VISTA Gene Model"
#   )
#
#   factor(provider, levels = providers)
#
# }
