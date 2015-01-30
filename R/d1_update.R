#' d1_update
#'
#' Update an existing dataone entry
#' @param pid package id to be updated
#' @param object new data file to be uploaded
#' @param uid the user id of the data maintainer
#' @param new_id new package id to be assigned
#' @param cert path to the x509 certificate from https://cilogon.org/?skin=DataONE
#' @param node The URL to the DataONE node we intend to update. Defaults to the KNB
#' @param sysmeta the required system metadata for the package, geranted by default.
#' @return httr::response object indicating the success or failure of the call
#' @import httr
#' @examples
#' \dontrun{
#' f <- system.file("doc", "reml_example.xml", package="reml")
#' d1_upload(f, "boettiger", id=uuid::UUIDgenerate(), node = knb_test)
#' change f
#' 
#' d1_update(
#' }
#' @export
d1_update <- function(pid,
                      object,
                      uid,
                      new_id = getid("extract", object),
                      cert = "/tmp/x509up_u1000",
                      node = "https://knb.ecoinformatics.org/knb/d1/mn/v1",
                      sysmeta = write_sysmeta(object, uid=uid, id=new_id)){

  url <- paste0(node, "/object", "/id")
  body <- list(pid = new_id, 
              object = upload_file(object),
              sysmeta = upload_file(sysmeta)) # need to add version line?
  PUT(url, 
       body = body,
       config=config(sslcert = cert))
}

