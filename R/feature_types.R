#' Genome Feature Type Definitions
#'
#' A dataset containing different types of gene and genome features along with
#' their Sequence Ontology (SO) identifiers and definitions.
#'
#' @format A [tibble][tibble::tibble-package] with `r nrow(feature_type_definitions)` rows
#'   and `r ncol(feature_type_definitions)` variables:
#' \describe{
#'   \item{feature_type}{Character. The type of gene or genome feature.}
#'   \item{so_id}{Character. The Sequence Ontology identifier associated with the feature type.}
#'   \item{definition}{Character. The definition of the feature type.}
#' }
#'
#' @examples
#' print(feature_type_definitions, n = Inf)
#'
#' @source
#'   The table in \url{https://www.informatics.jax.org/userhelp/GENE_feature_types_help.shtml}
#'   and a few other terms found in MGI reports.
"feature_type_definitions"


#' Genome Feature types
#'
#' [feature_types()] returns different types of gene and genome features. For
#' feature type definitions, see `?feature_type_definitions`.
#'
#' @returns A character vector of feature types' names.
#'
#' @examples
#' feature_types()
#'
#' @export
feature_types <- function() {
  feature_type_definitions$feature_type
}
