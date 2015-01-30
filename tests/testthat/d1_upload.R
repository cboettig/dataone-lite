library("httr")
test_that("We can upload data to DataONE",
{
  data(nodes)
  f <- system.file("examples", "example-eml.xml", package="dataonelite")
  resp <- d1_upload(f, "boettiger", id=uuid::UUIDgenerate(), node = knb_test)
  expect_is(resp, "response")
  expect_equal(status_code(resp), 200)
})