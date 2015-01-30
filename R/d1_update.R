
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
                      new_id,
                      cert = "/tmp/x509up_u1000",
                      node = "https://knb.ecoinformatics.org/knb/d1/mn/v1",
                      sysmeta = write_sysmeta(object, uid=uid, id=id)){

  url <- paste0(node, "/object", "/id")
  body <- list(pid = new_id, 
              object = upload_file(object),
              sysmeta = upload_file(sysmeta)) # need to add version line?
  PUT(url, 
       body = body,
       config=config(sslcert = cert))
}

