#' write_sysmeta
#' 
#' Generate minimal system metadata XML file 
#' 
#' @param file the path/name of the file to generate metadata for.  
#' @param uid your user identifier as registered at cilogon.org
#' @param id how to obtain the identifier.  If "create", will attempt to make an 
#'       identifier with uuid.  "extract" will attempt to extract EML packageID
#'       identifiers.  Otherwise, just provide the identifier here.  
#' @param formatId if "guess", will base a guess on the file extension, otherwise specify format here
#' @param affiliation affiliation as registered at http://cilogon.org certificate
#' @param metafile the name of the output minimal system metadata file (NULL returns output to console)
#' @return an XML object containing the dataone minimal system metadata, see schema definition for details (in xsd directory)
#' @import XML
#' @importFrom tools md5sum
#' @import uuid
write_sysmeta <- 
  function(file, 
           uid, 
           id = c("create", "extract"),
           formatId = "guess",
           affiliation="unaffiliated",
           metafile = "sysmeta.xml"){

  size <- file.info(file)[["size"]]
  md5 <- md5sum(file)
  who <- paste0("uid=", uid, ",", "o=", affiliation)
  doc <- xmlParse(file)

  if(formatId == "guess"){
    x <- strsplit(file, "\\.")
    ext <- x[[1]][[length(x)]]
    if(ext == "csv")
      formatId <- "text/csv"
    else if(ext == "xml")
      formatId <-  xmlNamespaces(doc)$eml$uri
  }
  
  id <- getid(id, file)
  d1 <- newXMLNode("d1:systemMetadata", 
                   namespaceDefinitions = 
      c(d1 = "http://ns.dataone.org/service/types/v1"))
  newXMLNode("identifier", id, parent = d1)
  newXMLNode("formatId", formatId, parent = d1) 
  newXMLNode("size", size, parent = d1)
  newXMLNode("checksum", attrs = c(algorithm="MD5"), md5, parent = d1)
  newXMLNode("rightsHolder", who, parent = d1)
  saveXML(newXMLDoc(d1), metafile, 
          indent = TRUE, 
          prefix = '<?xml version="1.0" encoding="UTF-8"?>\n', 
          encoding="UTF-8")
}

#' getid
#' 
#' helper function to the get the id of a dataone object
#' @param id if "extract" or "create", will attempt to do so.  
#' @param file file need only be provided for extract 
#' @export
getid <- function(id, file = NULL){
  if(id == "create"){
    id <- UUIDgenerate()
  } else if(id == "extract"){
    doc <- xmlParse(file)
    id <- xmlAttrs(xmlRoot(doc))[["packageId"]]
  } else {
    id
  }
}


#  time <- format(Sys.time(), "%Y-%M-%dT%H:%M:%OS3")
#  #  timezone is actually optional, but needs a colon added
#  timezone <- gsub("^(...)(..)", "\\1:\\2", format(Sys.time(), "%z"))
#  time <- paste0(time, timezone)
# 
#  newXMLNode("accessPolicy", 
#             newXMLNode("allow", .children = 
#                        list(newXMLNode("subject", person),
#                             newXMLNode("permission", "read"),
#                             newXMLNode("permission", "write"),
#                             newXMLNode("permission", "changePermssion"))
#                        )
#             )
#
#
