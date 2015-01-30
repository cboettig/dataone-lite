#' d1_delete
#' 
#' Archive a data object so that it is removed from indexing
#' @param id the permanent identifier of the object
#' @param cert path to the x509 certificate from https://cilogon.org/?skin=DataONE
#' @param node the authoritativeNode where the data has been archived
#' @details To generate a valid certificate, visit https://cilogon.org/?skin=DataONE and download a certificate.  (If asked to execute or download `shibCILaunchGSCA.jnlp`, choose execute, which will launch the download.  Otherwise, download this file and run `javaws shibCILaunchGSCA.jnlp` on the command line to launch.  Requires a working Java webscript application.  
#' @import httr
#' @aliases d1_archive d1_delete
#' @export d1_archive d1_delete
d1_delete <- function(id, 
                   cert = "/tmp/x509up_u1000",
                   node = "https://knb.ecoinformatics.org/knb/d1/mn/v1"){
  PUT(paste0(node, "/archive/", id), 
      config=config(sslcert = cert))
}


d1_archive <- d1_delete
