library("httr")
test_that("We can search DataONE",
{
  resp <- d1_search("Wolkovich", "author")
  expect_is(resp, "response")
  expect_equal(status_code(resp), 200)
})