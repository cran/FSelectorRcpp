#' Formula to Variables' Names
#'
#' Converts formula to a character vector.
#'
#' @noRd
#'
formula2names <- function(formula, data) {
  y <- formula[[2]]
  x <- gsub("`", "", attr(stats::terms(formula, data = data), "term.labels"))

  list(y = as.character(y), x = x)
}

#' Create a formula Object
#'
#' Utility function to create a \link{formula} object. Note that it may be very useful when you use pipes.
#'
#' @param attrs Character vector with names of independent variables.
#' @param class Single string with a dependent variable's name.
#'
#' @examples
#' if(require("rpart")) {
#' # evaluator from FSelector package
#' evaluator <- function(subset, data, dependent = names(iris)[5]) {
#'   library(rpart)
#'   k <- 5
#'   splits <- runif(nrow(data))
#'   results <- sapply(1:k, function(i) {
#'     test.idx <- (splits >= (i - 1) / k) & (splits < i / k)
#'     train.idx <- !test.idx
#'     test <- data[test.idx, , drop = FALSE]
#'     train <- data[train.idx, , drop = FALSE]
#'     tree <- rpart(to_formula(subset, dependent), train)
#'     error.rate <- sum(test[[dependent]] != predict(tree, test, type = "c")) /
#'     nrow(test)
#'     return(1 - error.rate)
#'   })
#'   return(mean(results))
#' }
#'
#' set.seed(123)
#' fit <- feature_search(attributes = names(iris)[-5], fun = evaluator, data = iris,
#'                 mode = "exhaustive", parallel = FALSE)
#' fit$best
#' names(fit$best)[fit$best == 1]
#' # with to_formula
#' to_formula(names(fit$best)[fit$best == 1], "Species")
#' }
#' @importFrom stats as.formula
#' @export
to_formula <- function(attrs, class) {
  as.formula(paste(class, paste(attrs, collapse = " + "), sep = " ~ "))
}

#' Get children
#'
#' Function to obtain children matrices
#'
#' @noRd
#'
#' @importFrom utils combn
get_children <- function(parent, direction = c("forward", "backward", "both"),
                         omit.func = NULL) {
  # adopted from FSelector package
  direction <- match.arg(direction)
  if (!is.null(omit.func)) {
    omit.func <- match.fun(omit.func)
  }

  cols <- length(parent)
  if (cols <= 0) {
    stop("Parent attribute set cannot be empty.")
  }

  m1 <- NULL
  m2 <- NULL

  if (direction == "forward" || direction == "both") {
    rows <- cols - sum(parent)
    if (rows > 0) {
      m1 <- matrix(parent, ncol = cols, nrow = rows, byrow = TRUE)
      CurrRow <- 1
      CurrCol <- 1
      while (CurrCol <= cols && CurrRow <= rows) {
        if (m1[CurrRow, CurrCol] == 0) {
          m1[CurrRow, CurrCol] <- 1
          CurrRow <- CurrRow + 1
        }
        CurrCol <- CurrCol + 1
      }
    }
  }

  if (direction == "backward" || direction == "both") {
    rows <- sum(parent)
    if (rows > 1) {
      m2 <- matrix(parent, ncol = cols, nrow = rows, byrow = TRUE)
      CurrRow <- 1
      CurrCol <- 1
      while (CurrCol <= cols && CurrRow <= rows) {
        if (m2[CurrRow, CurrCol] == 1) {
          m2[CurrRow, CurrCol] <- 0
          CurrRow <- CurrRow + 1
        }
        CurrCol <- CurrCol + 1
      }
    }
  }

  m <- rbind(m1, m2)
  if (is.null(m)) {
    return(m)
  }

  if (!is.null(omit.func)) {
    RowToOmit <- apply(m, 1, omit.func)
    return(m[!RowToOmit, , drop = FALSE]) #nolint
  } else {
    return(m)
  }
}

#' Colnames from different calls
#'
#' Convenience function for extracting colnames
#' @noRd
#'
get_colname <- function(dataCol) {
  if (grepl(pattern = "^[[:digit:]]+$", x = dataCol[2])) {
    fnc <- ifelse(exists(dataCol[1]), get, dynGet)
    names(fnc(dataCol[1]))[as.integer(dataCol[2])]
  } else {
    dataCol[2]
  }
}

#' Names for Different Classes
#'
#' Sets names of output based on call
#'
#' @noRd
#'
call2names <- function(vecCall) {
  charCall <- as.character(vecCall)
  if (length(charCall) == 1) {
    charCall
  } else if (charCall[1] == "$") {
    charCall[3]
  } else if (charCall[1] == "[[") {
    get_colname(charCall[-1])
  } else {
    toSub <- charCall[-1]
    withBrackets <- grep(pattern = "[[", x = toSub, fixed = TRUE)
    toSub[withBrackets] <- gsub(pattern = "]]", replacement = "",
                                x = toSub[withBrackets])
    toSub[withBrackets] <- strsplit(x = toSub[withBrackets], split = "[[",
                                    fixed = TRUE)
    toSub[withBrackets] <- lapply(toSub[withBrackets], get_colname)
    toSub[-withBrackets] <- gsub(pattern = ".*\\$", replacement = "",
                                 x = toSub[-withBrackets])
    gsub(pattern = "\"", replacement = "", x = unlist(toSub))
  }
}

#' Format handler
#'
#' Handles values format
#'
#' @noRd
#'
format_handler <- function(xCall, x) {
  df <- as.data.frame(x)
  if (!is.matrix(x)) {
    colnames(df) <- call2names(xCall)
  }
  df
}
