#include "pPCA2statismo.h"

RcppExport SEXP pPCA2pointer(SEXP pPCA_) {
  try {
  XPtr<vtkMeshModel> model = pPCA2statismo(pPCA_);
  return statismo2pPCA(model,true);
  }  catch (std::exception& e) {
    ::Rf_error( e.what());
  } catch (...) {
    ::Rf_error("unknown exception");
  }
}
RcppExport SEXP pointer2pPCA(SEXP pPCA_) {
  try {
  XPtr<vtkMeshModel> model = pPCA2statismo(pPCA_);
  return statismo2pPCA(model,false);
  }  catch (std::exception& e) {
    ::Rf_error( e.what());
  } catch (...) {
    ::Rf_error("unknown exception");
  }
}