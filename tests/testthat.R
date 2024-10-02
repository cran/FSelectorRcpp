if(
  require(testthat) &&
  require(FSelectorRcpp) &&
  require(Matrix) &&
  require(Rcpp) &&
  require(RcppArmadillo) &&
  require(dplyr) &&
  require(entropy) &&
  require(lintr)
) {
  test_check("FSelectorRcpp")
}

