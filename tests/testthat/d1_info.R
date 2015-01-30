library("httr")
test_that("We can get info from DataONE",
{
  resp <- d1_info()
  expect_is(resp, "response")
  expect_equal(status_code(resp), 200)
})