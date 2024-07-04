test_that("is_mgi_identifier works as expected", {

  actual <- is_mgi_identifier(c("MGI:1", "MGI:123456", "MGI:1234567", "123456", NA_character_))
  expected <- c(TRUE, TRUE, TRUE, FALSE, FALSE)
  expect_identical(actual, expected)

})
