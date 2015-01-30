#' d1_get
#' 
#' get data or metadata given an identifier
#' @param id the identifier of the object of interest 
#' @param node the node url of the DataONE node.  Be default, uses the central dataone.org node.  Usually no need to adjust this.
#' @param action return the object itself (`object`) or the system metadata (`meta`)? Defaults to `object` 
#' @return httr "response" object.  Use httr function \code{\link{content}} to parse
#' @details action should be object to download an object itself, including a metadata object (such as an EML xml file).  
#'  meta allows access to system metadata.  
#' @examples
#' \dontrun{
#' d1_get("doi:10.5063/AA/wolkovich.24.1")
#' }
#' @import httr
#' @import XML
#' @export d1_get d1_download
#' @aliases d1_get d1_download 
d1_get <- function(id,
                   action = c("object", "meta"),
                   node = c("https://cn.dataone.org/cn/v1",
                            "https://knb.ecoinformatics.org/knb/d1/mn/v1/")
                   ){

  node <- match.arg(node)
  action <- match.arg(action)
  url <- paste(node, action, id, sep="/")
  GET(url)
}

d1_download <- d1_get

