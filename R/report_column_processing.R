synonyms_col <- function(synonyms) {

  synonyms <- strsplit(synonyms, "|", fixed = TRUE)
  # Convert single NA values to empty character vectors in the list-column.
  dplyr::if_else(sapply(synonyms, \(x) length(x) == 1L && is.na(x)), list(character()), synonyms)
}

strand_col <- function(strand) {
  factor(strand, levels = strands()) # "." is implicitly mapped to NA.
}

chr_col <- function(chr) {
  factor(chr, levels = chromosomes())
}

cM_pos_col <- function(cM_pos) {
  as.double(dplyr::if_else(cM_pos %in% c("syntenic", "N/A"), NA_character_, cM_pos))
}

status_col <- function(status) {
  factor(status, levels = c("O", "W"))
}

marker_id_col <- function(marker_id) {
  dplyr::if_else(marker_id == "NULL", NA_character_, marker_id)
}

genome_assembly_col <- function(genome_assembly) {
  as.factor(genome_assembly)
}

feature_type_col <- function(feature_type) {
  factor(feature_type, levels = feature_types$feature_type)
}

marker_type_col <- function(marker_type) {
  factor(marker_type, levels = marker_types())
}
