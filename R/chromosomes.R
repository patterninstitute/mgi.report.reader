#' Mouse chromosomes
#'
#' [chromosomes()] returns mouse chromosome names.
#'
#' @param autosomal Whether to include the autosomal chromosomes (1 thru 19).
#' @param sexual Whether to include the sexual chromosomes (X and Y).
#' @param mitochondrial Whether to include the mitochondrial chromosome (MT).
#'
#' @returns A character vector of mouse chromosome names, or a subset thereof,
#' or an empty character vector.
#'
#' @examples
#' # All chromosomes.
#' chromosomes()
#'
#' # Autosomal chromosomes.
#' chromosomes(autosomal = TRUE, sexual = FALSE, mitochondrial = FALSE)
#'
#' @export
chromosomes <- function(autosomal = TRUE, sexual = TRUE, mitochondrial = TRUE) {

  empty <- character()
  c(
    `if`(autosomal, as.character(seq_len(19L)), empty),
    `if`(sexual, c("X", "Y"), empty),
    `if`(mitochondrial, c("MT"), empty)
  )
}
