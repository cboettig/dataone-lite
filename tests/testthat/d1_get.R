library("httr")

test_that("We can get a file from DataONE",
{
  resp <- d1_get("doi:10.5063/AA/wolkovich.24.1") 
  expect_is(resp, "response")
  expect_equal(status_code(resp), 200)
})