% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read_report.R
\name{read_report}
\alias{read_report}
\title{Read an MGI report}
\usage{
read_report(
  report_key = NULL,
  report_file = NULL,
  report_type = NULL,
  n_max = Inf
)
}
\arguments{
\item{report_key}{A character vector. A key used to uniquely refer to an MGI
report.}

\item{report_file}{A character vector. The file path or URL to an MGI report
file.}

\item{report_type}{A character vector. The type of an MGI report.}

\item{n_max}{Maximum number of lines to read.}
}
\value{
A \link[tibble:tibble-package]{tibble} with report data in tidy
format. The set of variables is dependent on the specific report requested:
\itemize{
\item For \code{"marker_list1"}, see \code{vignette("marker_list1")}.
\item For \code{"marker_list2"}, see \code{vignette("marker_list2")}.
\item For \code{"marker_coordinates"}, see \code{vignette("marker_coordinates")}.
\item For \code{"gene_model_coordinates"}, see \code{vignette("gene_model_coordinates")}.
\item For \code{"sequence_coordinates"}, see \code{vignette("sequence_coordinates")}.
\item For \code{"genbank_refseq_ensembl_ids"}, see \code{vignette("genbank_refseq_ensembl_ids")}.
\item For \code{"swiss_trembl_ids"}, see \code{vignette("swiss_trembl_ids")}.
\item For \code{"swiss_prot_ids"}, see \code{vignette("swiss_prot_ids")}.
\item For \code{"gene_trap_ids"}, see \code{vignette("gene_trap_ids")}.
\item For \code{"ensembl_ids"}, see \code{vignette("ensembl_ids")}.
\item For \code{"biotype_conflicts"}, see \code{vignette("biotype_conflicts")}.
\item For \code{"primers"}, see \code{vignette("primers")}.
\item For \code{"interpro_domains"}, see \code{vignette("interpro_domains")}.
}
}
\description{
\code{\link[=read_report]{read_report()}} imports data from an MGI report into R as a tidy data set.

You may call this function in two alternative ways:
\itemize{
\item Using \code{report_key}: this is the easiest approach. A report key maps to a
report currently hosted at MGI, e.g. \code{read_report("marker_list2")} reads
\code{MRK_List2.rpt} directly from MGI server into R. See Supported Reports below
for options.
\item Using \code{report_file} and \code{report_type}: this approach is more flexible as
you can read directly from a file or URL.
}
\subsection{Supported Reports}{

The set of currently supported reports:

\if{html}{\out{<div class="sourceCode r">}}\preformatted{reports
#> # A tibble: 13 x 4
#>    report_key                 report_file              report_type   report_name
#>    <chr>                      <chr>                    <chr>         <chr>      
#>  1 marker_list1               MRK_List1.rpt            MRK_List1     Mouse Gene~
#>  2 marker_list2               MRK_List2.rpt            MRK_List2     Mouse Gene~
#>  3 marker_coordinates         MGI_MRK_Coord.rpt        MGI_MRK_Coord MGI Marker~
#>  4 gene_model_coordinates     MGI_Gene_Model_Coord.rpt MGI_Gene_Mod~ MGI Gene M~
#>  5 sequence_coordinates       MGI_GTGUP.gff            MGI_GTGUP     MGI Sequen~
#>  6 genbank_refseq_ensembl_ids MRK_Sequence.rpt         MRK_Sequence  MGI Marker~
#>  7 swiss_trembl_ids           MRK_SwissProt_TrEMBL.rpt MRK_SwissPro~ MGI Marker~
#>  8 swiss_prot_ids             MRK_SwissProt.rpt        MRK_SwissProt MGI Marker~
#>  9 gene_trap_ids              MRK_GeneTrap.rpt         MRK_GeneTrap  MGI Marker~
#> 10 ensembl_ids                MRK_ENSEMBL.rpt          MRK_ENSEMBL   MGI Marker~
#> 11 biotype_conflicts          MGI_BioTypeConflict.rpt  MGI_BioTypeC~ MGI Marker~
#> 12 primers                    PRB_PrimerSeq.rpt        PRB_PrimerSeq MGI Marker~
#> 13 interpro_domains           MGI_InterProDomains.rpt  MGI_InterPro~ InterPro d~
}\if{html}{\out{</div>}}
}
}
