#' d1_info
#' 
#' Get information about the services available at a node.  
#' @param node the URL of the DataONE node of interest.  
#' @return XML-noded description of the node in an httr response object.  
#' @export
d1_info <- function(node = "https://cn.dataone.org/cn/v1"){
  url <- paste(node, "node", sep="/")
  GET(url)
}

# FIXME consider parsing the XML and converting to a list structure?