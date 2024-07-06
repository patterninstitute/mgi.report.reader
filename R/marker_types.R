#' Genetic marker types
#'
#' [marker_types()] returns MGI marker types. See [marker_type_definitions] for
#' the meaning of each type.
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

#' Genetic Marker Type Definitions
#'
#' @description
#'
#' A dataset of marker types definitions.
#'
#' Use instead [marker_types()] for the marker type names as a single character
#' vector.
#'
#' @format A [tibble][tibble::tibble-package] with
#' `r nrow(marker_type_definitions)` rows and `r ncol(marker_type_definitions)`
#'   variables:
#'
#' \describe{
#'   \item{`marker_type`}{Character. The type of genetic marker.}
#'   \item{`definition`}{Character. The definition of the marker type.}
#' }
#'
#' @examples
#' print(marker_type_definitions, n = Inf)
#'
#' @source
#'   The cross-references in the entry definition for marker at MGI glossary:
#'   \url{https://www.informatics.jax.org/glossary/marker/}.
#'
"marker_type_definitions"
