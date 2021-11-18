# 1. Vectors with no NA’s

numeric_vector <- c(98, 100, 78, 68, 90, 82)
group_vector <- c("Group1", "Group2", "Group3", "Group3", "Group1", "Group1")
test_that("Vectors with no NA’s", {

  #Test the result is a data frame.
  expect_equal('data.frame',
               class(summary_by_group(numeric_vector, group_vector))[3])

  #Test the data frame has the expected columns.
  expect_true(all(c("group_vector", "max", "min", "mean", "median") %in%
                    names(summary_by_group(numeric_vector, group_vector))))

  #Test all groups are included in the result.
  expect_true(all(c("Group1", "Group2", "Group3") %in%
                    summary_by_group(numeric_vector, group_vector)$group_vector))

  #Test the calculated mean value for three groups are correct.
  expect_equal(c(90, 100, 73),
               summary_by_group(numeric_vector, group_vector)$mean)
})



# 2. Vectors that has NA’s

numeric_vector <- c(98, NA, 78, 68, 90, 82)
group_vector <- c("Group1", "Group2", "Group3", NA, "Group1", "Group1")
test_that("Vectors that has NA’s", {

  #Test only Group1 and Group3 are included in the result.
  expect_true(all(c("Group1", "Group3") %in%
                    summary_by_group(numeric_vector, group_vector)$group_vector))

  #Test the calculated mean value for two groups without NA values are correct.
  expect_equal(c(90, 78),
               summary_by_group(numeric_vector, group_vector)$mean)
})



# 3. Vectors of a different type

wrong_numeric_vector <- c("98", "100", 78, 68, 90, 82)
group_vector <- c("Group1", "Group2", "Group3", "Group3", "Group1", "Group1")
test_that("Two input vectors have different length", {
  expect_error(summary_by_group(wrong_numeric_vector, group_vector), "Sorry, the first argument of this function must be numeric input!")
})



# 4. Vectors of wrong lengths

#' 4.1 Vectors of different length
numeric_vector <- c(98)
group_vector <- c("Group1", "Group2")
test_that("Two input vectors have different length", {
  expect_error(summary_by_group(numeric_vector, group_vector), "Sorry, the length of numeric_vector and group_vector are not equal. Data frame cannot be created!")
})


#' 4.2 Vectors of length 0
test_that("Two input vectors have length 0", {
  expect_error(summary_by_group(numeric(0), numeric(0)), "Sorry, the length of input vector cannot be zero.")
})

