#' Genome Feature Types
#'
#' A dataset containing different types of gene and genome features along with
#' their Sequence Ontology (SO) identifiers and definitions.
#'
#' @format A [tibble][tibble::tibble-package] with `r nrow(feature_types)` rows
#'   and `r ncol(feature_types)` variables:
#' \describe{
#'   \item{feature_type}{Character. The type of gene or genome feature.}
#'   \item{so_id}{Character. The Sequence Ontology identifier associated with the feature type.}
#'   \item{definition}{Character. The definition of the feature type.}
#' }
#'
#' @examples
#' print(feature_types, n = Inf)
#'
#' @source
#'   The table in \url{https://www.informatics.jax.org/userhelp/GENE_feature_types_help.shtml}
#'   and a few other terms found in MGI reports.
"feature_types"
