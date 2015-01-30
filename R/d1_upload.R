#' d1_upload
#'
#' upload an object to dataone
#' @param object new data file to be uploaded
#' @param uid the user id of the data maintainer
#' @param id what identifier should be used for the object; default will try and guess from object metadata (e.g. EML metadata).
#' @param cert path to the x509 certificate from https://cilogon.org/?skin=DataONE
#' @param node The URL to the DataONE node we intend to update. Defaults to the KNB
#' @param sysmeta the required system metadata for the package, geranted by default.
#' @return httr::response object indicating the success or failure of the call

#' @import httr
#' @examples
#' \dontrun{
#' f <- system.file("doc", "reml_example.xml", package="reml")
#' d1_upload(f, "boettiger", id=uuid::UUIDgenerate(), node = knb_test)
#' }
#' @export
d1_upload <- function(object,
                      uid,
                      id = getid("extract", object),
                      cert = "/tmp/x509up_u1000",
                      node = "https://knb.ecoinformatics.org/knb/d1/mn/v1",
                      sysmeta = write_sysmeta(object, uid=uid, id=id)){

  url <- paste0(node, "/object")
  body <- list(pid = id, 
              object = upload_file(object),
              sysmeta = upload_file(sysmeta))
  POST(url, 
       body = body,
       config=config(sslcert = cert))
}

# FIXME come up with a more helpful scheme for handling the node
# user just wants to say "KNB" or "KNB", "test", not have to 
# give these long URLs...

knb_test <- "https://mn-demo-5.test.dataone.org/knb/d1/mn"


## tests: 
### FIXME use the session variable to avoid re-authenticating...
#
#
### WORKS: 
#node = knb_test
#cert = "/tmp/x509up_u1000"
### Ping server
#GET(paste0(node, "/monitor/ping"))
### Reserve an ID
#POST(paste0(node, "/generate"), list(scheme="uuid"), config=config(sslcert = cert))
#
#
#library(tools)
#f <- system.file("doc", "reml_example.xml", package="reml")
#md5sum(f)
#

