library("dataonelite")
library("httr")

test_that("We can upload data to DataONE",
{
  data(nodes)
  f <- system.file("examples", "example-eml.xml", package="dataonelite")
  cert <- system.file("tmp", "x509up_u1000", package="dataonelite")
  
  ## We can only test this function if we have a certificate
  if(length(cert) > 0){
    resp <- d1_upload(f, "boettiger", id=uuid::UUIDgenerate(), node = knb_test, cert=cert)
    expect_is(resp, "response")
    expect_equal(status_code(resp), 200)
  }
})
