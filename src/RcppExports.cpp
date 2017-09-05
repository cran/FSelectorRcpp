// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <RcppArmadillo.h>
#include <Rcpp.h>

using namespace Rcpp;

// cutOff_k
std::vector< std::string > cutOff_k(std::vector< std::string >& x1, std::vector<double>& x2, double k);
RcppExport SEXP _FSelectorRcpp_cutOff_k(SEXP x1SEXP, SEXP x2SEXP, SEXP kSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< std::vector< std::string >& >::type x1(x1SEXP);
    Rcpp::traits::input_parameter< std::vector<double>& >::type x2(x2SEXP);
    Rcpp::traits::input_parameter< double >::type k(kSEXP);
    rcpp_result_gen = Rcpp::wrap(cutOff_k(x1, x2, k));
    return rcpp_result_gen;
END_RCPP
}
// discretize_cpp
IntegerVector discretize_cpp(const NumericVector& x, const IntegerVector& y, const List& discControl);
RcppExport SEXP _FSelectorRcpp_discretize_cpp(SEXP xSEXP, SEXP ySEXP, SEXP discControlSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const NumericVector& >::type x(xSEXP);
    Rcpp::traits::input_parameter< const IntegerVector& >::type y(ySEXP);
    Rcpp::traits::input_parameter< const List& >::type discControl(discControlSEXP);
    rcpp_result_gen = Rcpp::wrap(discretize_cpp(x, y, discControl));
    return rcpp_result_gen;
END_RCPP
}
// information_gain_cpp
List information_gain_cpp(List xx, IntegerVector y, int threads);
RcppExport SEXP _FSelectorRcpp_information_gain_cpp(SEXP xxSEXP, SEXP ySEXP, SEXP threadsSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< List >::type xx(xxSEXP);
    Rcpp::traits::input_parameter< IntegerVector >::type y(ySEXP);
    Rcpp::traits::input_parameter< int >::type threads(threadsSEXP);
    rcpp_result_gen = Rcpp::wrap(information_gain_cpp(xx, y, threads));
    return rcpp_result_gen;
END_RCPP
}
// sparse_information_gain_cpp
List sparse_information_gain_cpp(arma::sp_mat x, IntegerVector y);
RcppExport SEXP _FSelectorRcpp_sparse_information_gain_cpp(SEXP xSEXP, SEXP ySEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< arma::sp_mat >::type x(xSEXP);
    Rcpp::traits::input_parameter< IntegerVector >::type y(ySEXP);
    rcpp_result_gen = Rcpp::wrap(sparse_information_gain_cpp(x, y));
    return rcpp_result_gen;
END_RCPP
}
// fs_count_levels
int fs_count_levels(SEXP x);
RcppExport SEXP _FSelectorRcpp_fs_count_levels(SEXP xSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< SEXP >::type x(xSEXP);
    rcpp_result_gen = Rcpp::wrap(fs_count_levels(x));
    return rcpp_result_gen;
END_RCPP
}
// fs_order
IntegerVector fs_order(SEXP x);
RcppExport SEXP _FSelectorRcpp_fs_order(SEXP xSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< SEXP >::type x(xSEXP);
    rcpp_result_gen = Rcpp::wrap(fs_order(x));
    return rcpp_result_gen;
END_RCPP
}
// fs_entropy1d
double fs_entropy1d(SEXP x);
RcppExport SEXP _FSelectorRcpp_fs_entropy1d(SEXP xSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< SEXP >::type x(xSEXP);
    rcpp_result_gen = Rcpp::wrap(fs_entropy1d(x));
    return rcpp_result_gen;
END_RCPP
}
// fs_table1d
IntegerVector fs_table1d(SEXP& x);
RcppExport SEXP _FSelectorRcpp_fs_table1d(SEXP xSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< SEXP& >::type x(xSEXP);
    rcpp_result_gen = Rcpp::wrap(fs_table1d(x));
    return rcpp_result_gen;
END_RCPP
}
// fs_table_numeric2d
std::vector<int> fs_table_numeric2d(NumericVector& x, NumericVector& y);
RcppExport SEXP _FSelectorRcpp_fs_table_numeric2d(SEXP xSEXP, SEXP ySEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< NumericVector& >::type x(xSEXP);
    Rcpp::traits::input_parameter< NumericVector& >::type y(ySEXP);
    rcpp_result_gen = Rcpp::wrap(fs_table_numeric2d(x, y));
    return rcpp_result_gen;
END_RCPP
}
