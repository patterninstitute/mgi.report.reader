#' Genome Feature Type Definitions
#'
#' A dataset containing different types of gene and genome features along with
#' their Sequence Ontology (SO) identifiers and definitions.
#'
#' @format A [tibble][tibble::tibble-package] with 71 rows and 3 variables:
#' \describe{
#'   \item{feature_type}{Character. The type of gene or genome feature.}
#'   \item{so_id}{Character. The Sequence Ontology identifier associated with the feature type.}
#'   \item{definition}{Character. The definition of the feature type.}
#' }
#'
#' @examples
#' feature_types
#'
#' @source \url{https://www.informatics.jax.org/userhelp/GENE_feature_types_help.shtml}
"feature_types"
