% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_enrichments.R
\name{plot_enrichments}
\alias{plot_enrichments}
\title{Enrichment plots}
\usage{
plot_enrichments(enrichments_df = NULL, log_transform = TRUE,
  plot_type = "separate", sample_metadata, box_alpha = 0.8,
  violin_alpha = 0.8, x_order = NULL, overlap_order = NULL)
}
\arguments{
\item{enrichments_df}{enrichments at genomics regions from all samples, as in the format of output from \code{\link{multiBigwig_summary}}}

\item{log_transform}{logical. Should the data be \code{log2} transformed? Default is \code{TRUE}}

\item{plot_type}{either \code{separate} or \code{overlap}}

\item{sample_metadata}{metadata associated with the columns present in \code{enrichments_df}, information in this table will be used depending on the option in \code{plot_type}}

\item{box_alpha}{alpha/transparency to use for box plots, default 0.8}

\item{violin_alpha}{alpha/transparecny to use for violin plots, default 0.8}

\item{x_order}{ordering of levels on x-axis in resulting plot, default \code{NULL}}

\item{overlap_order}{ordering of overlaying if \code{plot_type = "overlap"}. E.g. overlaying treatment data on top of untreated data, default \code{NULL}}
}
\value{
\code{ggplot2} object
}
\description{
Function to plot enrichments from ChIP-seq/ATAC-seq at
genomics regions either as an individual groups or as
paired condition e.g untreated-treated
}
\examples{

## load example data
chr21_data_table <- system.file("extdata/bw", "ALPS_example_datatable.txt", package = "ALPS", mustWork = TRUE)

## attach path to bw_path and bed_path
d_path <- dirname(chr21_data_table)

chr21_data_table <- read.delim(chr21_data_table, header = TRUE)
chr21_data_table$bw_path <- paste0(d_path, "/", chr21_data_table$bw_path)
chr21_data_table$bed_path <- paste0(d_path, "/", chr21_data_table$bed_path)

enrichments <- multiBigwig_summary(data_table = chr21_data_table,
                                   summary_type = "mean",
                                   parallel = TRUE)

## plot_type == "separate"
plot_enrichments(enrichments_df = enrichments, log_transform = TRUE,
plot_type = "separate", sample_metadata = chr21_data_table)

## plot_type == "overlap"
enrichemnts_4_overlapviolins <- system.file("extdata/overlap_violins", "enrichemnts_4_overlapviolins.txt", package = "ALPS", mustWork = TRUE)
enrichemnts_4_overlapviolins <- read.delim(enrichemnts_4_overlapviolins, header = TRUE)

## metadata associated with above enrichments
data_table_4_overlapviolins <- system.file("extdata/overlap_violins", "data_table_4_overlapviolins.txt", package = "ALPS", mustWork = TRUE)
data_table_4_overlapviolins <- read.delim(data_table_4_overlapviolins, header = TRUE)

plot_enrichments(enrichments_df = enrichemnts_4_overlapviolins, log_transform = FALSE,
plot_type = "overlap", sample_metadata = data_table_4_overlapviolins)
}
