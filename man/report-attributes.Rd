% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/reports.R
\name{report-attributes}
\alias{report-attributes}
\alias{report_file}
\alias{report_name}
\alias{report_type}
\alias{report_url}
\title{Get MGI report specs by report key}
\usage{
report_file(report_key)

report_name(report_key)

report_type(report_key)

report_url(report_key)
}
\arguments{
\item{report_key}{A character vector. A key used to uniquely refer to an MGI
report.}
}
\value{
A character vector:
\itemize{
\item \code{report_file()}: report file name as hosted in \url{https://www.informatics.jax.org/downloads/reports/}.
\item \code{report_name()}: report title.
\item \code{report_type()}: report type.
\item \code{report_url()}: report remote location.
}
}
\description{
Set of functions to retrieve metadata details of a MGI report.
}
\examples{
report_file("marker_list1")

report_name("marker_list1")

report_type("marker_list1")

report_url("marker_list1")

}
