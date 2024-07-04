#' Genetic marker types
#'
#' [marker_types()] returns MGI marker types.
#'
#' @returns A character vector.
#'
#' @examples
#' marker_types()
#'
#' @export
marker_types <- function() {
  c(
    "Gene",
    "GeneModel",
    "Pseudogene",
    "DNA Segment",
    "Transgene",
    "QTL",
    "Cytogenetic Marker",
    "BAC/YAC end",
    "Complex/Cluster/Region",
    "Other Genome Feature"
  )
}
