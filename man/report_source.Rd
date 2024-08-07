% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/report_source.R
\name{report_source}
\alias{report_source}
\title{Report source}
\usage{
report_source(tbl)
}
\arguments{
\item{tbl}{Report data as a \link[tibble:tibble-package]{tibble}.}
}
\value{
A single string with an absolute path to a file on disk or an URL.
}
\description{
\code{\link[=report_source]{report_source()}} returns the source used to obtain the report data:
a file path or an URL.
}
\examples{
if (FALSE) {
  markers <- read_report("marker_list1", n_max = 10L)

  # Where did the data come from?
  report_source(markers)
}
}
