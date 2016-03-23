## get PCrows associated with missingValues
getSel <- function(missingIndex,shape) {
    m <- ncol(shape)
    sel <- missingIndex*3
    sel <- sort(c(sel, sel-1, sel-2))
    return(sel)
}
    
getUseLM <- function(missingIndex,shape) {
     k <- nrow(shape)
     use.lm=c(1:k)[-missingIndex]
     return(use.lm)
 }

# create a neat variance table
createVarTable <- function(sdev,square=TRUE) {
    if (square)
        sdev <- sdev^2
    sdsum <- sum(sdev)
    sdVar <- sdev/sdsum
    sdCum <- cumsum(sdVar)
    Variance <- data.frame(eigenvalue=sdev,exVar=sdVar, cumVar=sdCum)
    return(Variance)
}
# convert a mesh/matrix to a valid representer
dataset2representer <- function(x) {
    if (is.matrix(x))
        out <- list(vb=t(x),it=matrix(0,0,0))
    else if (inherits(x,"mesh3d"))
        out <- meshintegrity(x)
    else
        stop("unknown representer type")
    return(out)
}
        
# get matrix of mean shape    
getMeanMatrix <- function(model,transpose=TRUE) {
    meanvector <- GetMeanVector(model)
    x <- matrix(meanvector,3,length(meanvector)/3)
    if (transpose)
        x <- t(x)
    return(x)
}
    
## get the original standard deviations from a model given model the dampened values and the estimated noiseVariance
calcSdev <- function(model) {
    sdevorig <- sqrt(GetPCAVarianceVector(model)+GetNoiseVariance(model))
    return(sdevorig)
}

#' get the representer from a model of class "pPCA"
#'
#' get the representer from a model of class "pPCA"
#' @param model object of class \code{\link{pPCA}}
#' @return an object of class mesh3d or matrix, depending whether a point cloud or a triangular mesh is the model's representer.
#' @rdname representer2sample
#' @export
setGeneric("representer2sample", function(model) {
    standardGeneric("representer2sample")
})
#' @rdname representer2sample
setMethod("representer2sample", signature(model="pPCA"), function(model) {
    representer <- GetRepresenter(model)
    if (inherits(representer,"mesh3d")){
        if (nrow(representer$vb) == 3)
            representer$vb <- rbind(representer$vb,1)
    }   else
        representer <- vert2points(representer)
    return(representer)
})

#' @rdname representer2sample
setMethod("representer2sample", signature(model="pPCA_pointer"), function(model) {
    representer <- GetRepresenter(model)
    if (inherits(representer,"mesh3d")){
        if (nrow(representer$vb) == 3)
            representer$vb <- rbind(representer$vb,1)
    }   else
        representer <- vert2points(representer)
    return(representer)
})

output2sample <- function(out) {
    if (inherits(out,"mesh3d"))
        out$vb <- rbind(out$vb,1)
    else
        out <- t(out$vb)
    return(out)
}


setGeneric("UpdateVariance", function(model) standardGeneric("UpdateVariance"))
setMethod("UpdateVariance", "pPCA",function(model) {
    return(model)
})


names2modelinfo <- function(x) {
    ll <- 1:length(x)
    out <- lapply(ll,function(i) x <- c(paste("URI",i-1,sep="_"),x[i]))
    return(out)
}

GetRepresenter <- function(pPCA) {
    if (inherits(pPCA,"pPCA"))
        return(pPCA@representer)
    else if (inherits(pPCA,"pPCA_pointer"))
        return(DrawMean(pPCA))
    else
        stop("no object of class pPCA or pPCA_pointer")
}
        
