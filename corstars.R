corstars <- function(x, ordinal_vars=NULL, removeTriangle=c("upper", "lower"),
                     result=c("none", "html", "latex"), indecies=c(pearson="", spearman="(s)")) {
  # Compute correlation matrix
  require(Hmisc)
  x <- as.matrix(x)
  n <- ncol(x)
  R <- matrix(0, n, n)
  p <- matrix(0, n, n)
  method_index <- matrix("", n, n)
  
  # Loop through columns and apply different correlation methods
  for(i in 1:n) {
    for(j in i:n) {
      method = if(i %in% ordinal_vars || j %in% ordinal_vars) "spearman" else "pearson"
      corr <- cor.test(x[,i], x[,j], method=method)
      R[i,j] <- R[j,i] <- corr$estimate
      p[i,j] <- p[j,i] <- corr$p.value
      method_index[i,j] <- method_index[j,i] <- indecies[[method]]
    }
  }

  ## Define notions for significance levels; spacing is important.
  mystars <- ifelse(p < .0001, "***", ifelse(p < .001, "*** ", ifelse(p < .01, "**  ", ifelse(p < .05, "*   ", "    "))))
  
  ## Truncate the correlation matrix to two decimal
  R <- format(round(cbind(rep(-1.11, ncol(x)), R), 2))[,-1]
  
  ## Build a new matrix that includes the correlations with their appropriate stars
  Rnew <- matrix(paste(R, mystars, method_index, sep=""), ncol=n)
  diag(Rnew) <- paste(diag(R), " ", sep="")
  rownames(Rnew) <- colnames(x)
  colnames(Rnew) <- paste(colnames(x), "", sep="")
  
  ## Remove upper triangle of correlation matrix
  if(removeTriangle[1]=="upper") {
    Rnew <- as.matrix(Rnew)
    Rnew[upper.tri(Rnew, diag = TRUE)] <- ""
    Rnew <- as.data.frame(Rnew)
  }
  
  ## Remove lower triangle of correlation matrix
  else if(removeTriangle[1]=="lower") {
    Rnew <- as.matrix(Rnew)
    Rnew[lower.tri(Rnew, diag = TRUE)] <- ""
    Rnew <- as.data.frame(Rnew)
  }
  
  ## Remove last column and return the correlation matrix
  Rnew <- cbind(Rnew[1:length(Rnew)-1])
  if (result[1]=="none") return(Rnew)
  else {
    if(result[1]=="html") print(xtable(Rnew), type="html")
    else print(xtable(Rnew), type="latex") 
  }
}
