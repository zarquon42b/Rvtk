% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/GetFullJacobian.r
\docType{methods}
\name{GetFullJacobian}
\alias{GetFullJacobian}
\alias{GetFullJacobian,pPCA-method}
\title{get Jacobian for all model points or a subset}
\usage{
GetFullJacobian(model, pt)

\S4method{GetFullJacobian}{pPCA}(model, pt)
}
\arguments{
\item{model}{statistical shape model of class 'pPCA'}

\item{pt}{integer vector specifying which points to use}
}
\value{
returns a matrix with rows n: (n+2) containing the Jacobian for the n-th point
}
\description{
get Jacobian for all model points or a subset
}
\seealso{
\code{\link{GetJacobian}}
}

