test_that("plot_correlation() works fine", {

  mat <- matrix(sample.int(15, 9*100, TRUE), 9, 100) %>% as.data.frame()
  mat <- mat %>%
    tibble::rowid_to_column(var = "start") %>%
    dplyr::mutate(end = start + 1000) %>%
    dplyr::mutate(chr = "chr1") %>%
    dplyr::select(chr, start, end, dplyr::everything()) %>%
    dplyr::select(chr:V10)

  sample_table <- data.frame(sample_id = paste0("V", 1:10),
                             group = rep(c("G1", "G2"), 5),
                             color_code = c("red", "blue"), 5)

  plot_correlation(enrichments_df = mat,
                   log_transform = FALSE,
                   sample_metadata = sample_table,
                   plot_type = "replicate_level")

  plot_correlation(enrichments_df = mat,
                   log_transform = FALSE,
                   sample_metadata = sample_table,
                   plot_type = "group_level")

  dev.off()

})
