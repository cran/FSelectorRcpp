## ----echo=FALSE, message=TRUE, results='asis'---------------------------------
is.pkg <- all(c("RTCGA.rnaseq", "microbenchmark", "RWeka", "pkgdown") %in% rownames(installed.packages()))
if(!is.pkg) {
  message("Please install all suggested packages to run benchmark.")
}

if(is.pkg && !pkgdown::in_pkgdown()) {
  is.pkg <- FALSE
  cat("### Benchmark is not available here",
  "(we don't want to run this code on the CRAN server).",
  "Please visit the ",
    paste(sep = "", 
        "https://mi2-warsaw.github.io/FSelectorRcpp/",
        "articles/benchmarks_discretize.html")
  )
}


## ----setup, eval=is.pkg, include = FALSE--------------------------------------
#  library(knitr)
#  
#  fig.path <- if(pkgdown::in_pkgdown()) {
#    "benchmarks_discretize_files/figure-html/"
#  } else {
#    "bench-figs/bench-"
#  }
#  
#  opts_chunk$set(
#      comment = "",
#      fig.width = 8,
#      fig.height = 8,
#      message = FALSE,
#      warning = FALSE,
#      tidy.opts = list(
#          keep.blank.line = TRUE,
#          width.cutoff = 150
#      ),
#      options(width = 150),
#      eval = TRUE,
#      fig.path = fig.path
#  )

## ----eval=is.pkg--------------------------------------------------------------
#  library(microbenchmark)
#  library(FSelectorRcpp)
#  library(RWeka)

## ----eval = FALSE-------------------------------------------------------------
#  ## try https:// if https:// URLs are not supported
#  source("https://bioconductor.org/biocLite.R")
#  biocLite("RTCGA")

## ----eval=is.pkg--------------------------------------------------------------
#  library(RTCGA.rnaseq)
#  BRCA.rnaseq <- RTCGA.rnaseq::BRCA.rnaseq
#  BRCA.rnaseq$bcr_patient_barcode <-
#     factor(substr(BRCA.rnaseq$bcr_patient_barcode, 14, 14))
#  names(BRCA.rnaseq) <- gsub(pattern = "?", replacement = "q",
#                             x = names(BRCA.rnaseq), fixed = TRUE)
#  names(BRCA.rnaseq) <- gsub(pattern = "[[:punct:]]", replacement = "_",
#                             x = names(BRCA.rnaseq))

## ----eval=is.pkg--------------------------------------------------------------
#  library(ggplot2)
#  library(pbapply)
#  library(tibble)
#  names_by <- function(nameBy, vecBy) {
#    c(paste0(nameBy,
#             sapply(max(nchar(vecBy)) - nchar(vecBy),
#                    function(zeros) {
#                      paste0(rep(0, zeros), collapse = "")
#                    }),
#                    vecBy))
#  }
#  
#  get_times <- function(fun, vecRows, vecCols, nTimes) {
#    forRows <- pblapply(vecRows, function(nRows) {
#      forCols <- pblapply(vecCols + 1, function(nCols) {
#        suppressWarnings(microbenchmark(fun(bcr_patient_barcode ~ .,
#                           BRCA.rnaseq[1:nRows, 1:nCols]),
#                       times = nTimes))
#      })
#      colsNames <- names_by(nameBy = "columns_", vecBy = vecCols)
#      setNames(forCols, colsNames)
#    })
#    rowsNames <- names_by(nameBy = "rows_", vecBy = vecRows)
#    setNames(forRows, rowsNames)
#  }
#  
#  make_df <- function(bm_data, package) {
#    tibble(
#      rows = rep(
#        x = as.integer(
#          gsub(
#            pattern = "rows_0*",
#               replacement = "",
#               x = names(bm_data)
#          )
#        ),
#        each =  unique(sapply(bm_data, length))
#      ),
#      columns = as.integer(
#        gsub(
#          pattern = "columns_0*",
#          replacement = "",
#          x = as.vector(sapply(bm_data, names))
#        )
#      ),
#      time = as.vector(
#        sapply(
#          bm_data,
#          function(setOfCols) {
#            sapply(
#              setOfCols,
#              function(set) {
#                median(set$time) / 10 ^ 9
#              }
#            )
#          }
#        )
#      ),
#      package = package
#    )
#  }
#  
#  bm_fsr_discretize <- get_times(fun = discretize,
#                                 vecRows = seq(from = 200, to = 1000, by = 200),
#                                 vecCols = c(10, 100, 500, 1000),
#                                 nTimes = 1L)
#  bm_rwk_discretize <- get_times(fun = Discretize,
#                                 vecRows = seq(from = 200, to = 1000, by = 200),
#                                 vecCols = c(10, 100, 500, 1000),
#                                 nTimes = 1L)
#  
#  df_fsr <- make_df(bm_data = bm_fsr_discretize, package = "FSelectorRcpp")
#  df_rwk <- make_df(bm_data = bm_rwk_discretize, package = "RWeka")
#  bm_df <- rbind(df_fsr, df_rwk)
#  
#  make_plot <- function(y) {
#    yUnit <- gsub(pattern = "time",
#                  replacement = "s",
#                  x = y)
#  
#    ggplot(data = bm_df, aes_string(x = "rows", y = y, color = "package")) +
#    facet_grid(columns ~ ., labeller = label_both) +
#    geom_point() +
#    xlab("Number of rows [-]") +
#    ylab(paste0("Elapsed time [", yUnit, "]")) +
#    ggtitle(label = "Microbenchmark: discretization function comparison",
#            subtitle = "for different sizes of data sets") +
#    theme(plot.title = element_text(hjust = 0.5),
#          plot.subtitle = element_text(hjust = 0.5),
#          legend.position = "top")
#  }
#  
#  bm_plot <- make_plot("time")
#  bm_plot_log <- make_plot("log(time)")

## ----plots, eval=is.pkg, echo=FALSE-------------------------------------------
#  bm_plot
#  bm_plot_log

