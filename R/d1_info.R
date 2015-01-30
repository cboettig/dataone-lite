#' d1_info
#' 
#' Get information about the services available at a node.  
#' @param node the URL of the DataONE node of interest.  
#' @return XML-noded description of the node in an httr response object.  
d1_info <- function(node = c("https://cn.dataone.org/cn/v1",
                             "https://knb.ecoinformatics.org/knb/d1/mn/v1/")){
  node <- match.arg(node)
  url <- paste(node, "node", sep="/")
  GET(url)
}

