% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_motif_logo.R
\name{process_pfm}
\alias{process_pfm}
\title{Process PFM format}
\usage{
process_pfm(x)
}
\arguments{
\item{x}{path to PFM format file}
}
\value{
data.frame
}
\description{
Process PFM format
}
\examples{
myc_pfm <- system.file("extdata/motifs", "MA0147.2.pfm", package = "ALPS", mustWork = TRUE)
myc_df <- process_pfm(x = myc_pfm)
}
