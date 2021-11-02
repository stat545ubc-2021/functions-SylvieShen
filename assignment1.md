STAT545B - AssignmentB-1
================
Yue Shen
2021/11/02

# Welcome to Yue Shen’s assignmentB-1!

Loading data, tidyverse, and testthat package below:

``` r
suppressPackageStartupMessages(library(datateachr))
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(testthat))
```

## Exercise 1: Make a Function (25 points)

## Exercise 2: Document your Function (20 points)

When looking back to the previous mini-data-analysis-project, I found
out that I usually needed to compute some summary statistics(such as
max, min and mean) of one numerical variable after grouping them by one
categorical variable.

Hence, I make a function to get the whole summary across one group
easily, by just inputting the vector of the numerical variable and
another corresponding vector of the categorical variable.

``` r
#' Summary Statistics of Numerical Variable by Group
#'
#' Get the summary statistics (max, min, mean and median) of a numerical variable 
#' across the groups of a categorical variable.
#'
#' @param numeric_vector An vector of class "numeric", each numerical value is a part of one observation row.
#'                       To make the name of parameter be more specific, I named it as "numeric_vector".
#' @param group_vector An vector which represents the group type of each numeric value in the "numeric_vector" one by one.
#'                       To emphasize the group type, I named it as "group_vector".
#'
#' @return An object of class "data.frame" that contains the summary statistics of each group type.
#' @export
summary_by_group <- function (numeric_vector, group_vector) {
  
  # Throw an error if the first input is not numeric.
   if(!is.numeric(numeric_vector)) {
    stop('Sorry, the first argument of this function must be numeric input!\n',
         'You have provided an object of class: ', class(numeric_vector)[1])
   }
  
  # Throw an error if two inputs have different length.
   if(length(numeric_vector) != length(group_vector)){
    stop('Sorry, the length of numeric_vector and group_vector are not equal. Data frame cannot be created!\n',
         'The length of numeric_vector you provided is : ', length(numeric_vector),
         '\nThe length of group_vector you provided is : ', length(group_vector))
  }
  
  # Throw an error if the length of input is zero.
   if(length(numeric_vector) == 0){
    stop('Sorry, the length of input vector cannot be zero.')
  }
  
  # Firstly make a tibble with two inputs, drop NA values, then group them by "group_vector", compute the summary statistics.
  dplyr::tibble(numeric_vector, group_vector) %>% drop_na() %>% 
       dplyr::group_by(group_vector) %>%
       dplyr::summarise(max = max(numeric_vector), min = min(numeric_vector), 
                mean = mean(numeric_vector), median = median(numeric_vector))
}
```

## Exercise 3: Include examples (15 points)

### Examples 1

In STAT545A, I proposed a research question “Are trees with a specific
genus have longer diameter?”. To investigate this question, I need to
get the summary statistics trees’ diameters across trees’ genus.

Here below shows the dataset `vancouver_trees` by selecting the
`tree_id`, `genus_name` and `diameter` firstly.

``` r
select(vancouver_trees, tree_id, genus_name, diameter, everything())
```

    ## # A tibble: 146,611 x 20
    ##    tree_id genus_name diameter civic_number std_street    species_name
    ##      <dbl> <chr>         <dbl>        <dbl> <chr>         <chr>       
    ##  1  149556 ULMUS          10            494 W 58TH AV     AMERICANA   
    ##  2  149563 ZELKOVA        10            450 W 58TH AV     SERRATA     
    ##  3  149579 STYRAX          4           4994 WINDSOR ST    JAPONICA    
    ##  4  149590 FRAXINUS       18            858 E 39TH AV     AMERICANA   
    ##  5  149604 ACER            9           5032 WINDSOR ST    CAMPESTRE   
    ##  6  149616 PYRUS           5            585 W 61ST AV     CALLERYANA  
    ##  7  149617 ACER           15           4909 SHERBROOKE ST PLATANOIDES 
    ##  8  149618 ACER           14           4925 SHERBROOKE ST PLATANOIDES 
    ##  9  149619 ACER           16           4969 SHERBROOKE ST PLATANOIDES 
    ## 10  149625 FRAXINUS        7.5          720 E 39TH AV     AMERICANA   
    ## # ... with 146,601 more rows, and 14 more variables: cultivar_name <chr>,
    ## #   common_name <chr>, assigned <chr>, root_barrier <chr>, plant_area <chr>,
    ## #   on_street_block <dbl>, on_street <chr>, neighbourhood_name <chr>,
    ## #   street_side_name <chr>, height_range_id <dbl>, curb <chr>,
    ## #   date_planted <date>, longitude <dbl>, latitude <dbl>

Now, I call the function I made in **Exercise1** above to get the the
summary statistics of `diameter` across group `genus_name`.

``` r
summary_by_group(vancouver_trees$diameter, vancouver_trees$genus_name)
```

    ## # A tibble: 97 x 5
    ##    group_vector   max   min  mean median
    ##    <chr>        <dbl> <dbl> <dbl>  <dbl>
    ##  1 ABIES         42.5     1 12.9   12   
    ##  2 ACER         317       0 10.6    8   
    ##  3 AESCULUS      64       0 23.7   25   
    ##  4 AILANTHUS     21.5     3 15.9   19.5 
    ##  5 ALBIZIA        6       6  6      6   
    ##  6 ALNUS         40       0 17.5   17.5 
    ##  7 AMELANCHIER   20       0  3.21   3   
    ##  8 ARALIA        12       3  6.81   6.12
    ##  9 ARAUCARIA     32       3 11.4    8.5 
    ## 10 ARBUTUS       33       6 18.4   17.5 
    ## # ... with 87 more rows

### Examples 2

I can also create `numeric_vector` and `group_vector` by myself, as long
as the values in two vectors are correspondent to each other.

``` r
numeric_vector <- c(1.5, 7.6, 3.0, 4.7, 8, 8.4)
group_vector <- c("A", "C", "A", "B", "B", "A")
summary_by_group(numeric_vector, group_vector)
```

    ## # A tibble: 3 x 5
    ##   group_vector   max   min  mean median
    ##   <chr>        <dbl> <dbl> <dbl>  <dbl>
    ## 1 A              8.4   1.5  4.3    3   
    ## 2 B              8     4.7  6.35   6.35
    ## 3 C              7.6   7.6  7.6    7.6

As we can see in the dataframe above, we get the summary statistics of
three groups A, B and C.

### Examples 3

If `numeric_vector` and `group_vector` have the same length but with NA
values, the function `summary_by_group` will drop NA values and then
compute the summary statistics.

``` r
numeric_vector <- c(1.5, NA, 3.0, 4.7, 8, 8.4)
group_vector <- c("A", "C", "A", "B", NA, "A")
summary_by_group(numeric_vector, group_vector)
```

    ## # A tibble: 2 x 5
    ##   group_vector   max   min  mean median
    ##   <chr>        <dbl> <dbl> <dbl>  <dbl>
    ## 1 A              8.4   1.5   4.3    3  
    ## 2 B              4.7   4.7   4.7    4.7

### Examples 4

If `numeric_vector` and `group_vector` have different length, the
function `summary_by_group` will throw an error and stop, showing the
exact lengths of those two inputs.

``` r
numeric_vector <- c(1.5, 7.6, 3.0, 4.7, 8)
group_vector <- c("A", "C", "A", "B", "B", "A")
summary_by_group(numeric_vector, group_vector)
```

    ## Error in summary_by_group(numeric_vector, group_vector): Sorry, the length of numeric_vector and group_vector are not equal. Data frame cannot be created!
    ## The length of numeric_vector you provided is : 5
    ## The length of group_vector you provided is : 6

### Examples 5

If `numeric_vector` is not a numeric vector, the function
`summary_by_group` will throw an error and stop, showing the provided
input type.

``` r
wrong_numeric_vector <- c("1.5", "7.6", "3.0", "4.7", "8")
group_vector <- c("A", "C", "A", "B", "B", "A")
summary_by_group(wrong_numeric_vector, group_vector)
```

    ## Error in summary_by_group(wrong_numeric_vector, group_vector): Sorry, the first argument of this function must be numeric input!
    ## You have provided an object of class: character

## Exercise 4: Test the Function (25 points)

### 4.1 Vectors with no NA’s

``` r
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
```

    ## Test passed

### 4.2 Vectors that has NA’s

``` r
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
```

    ## Test passed

### 4.3 Vectors of a different type

``` r
wrong_numeric_vector <- c("98", "100", 78, 68, 90, 82)
group_vector <- c("Group1", "Group2", "Group3", "Group3", "Group1", "Group1")

test_that("Two input vectors have different length", {
  expect_error(summary_by_group(wrong_numeric_vector, group_vector), "Sorry, the first argument of this function must be numeric input!")
  
})
```

    ## Test passed

### 4.4 Vectors of wrong lengths

#### 4.4.1 Vectors of different length

``` r
numeric_vector <- c(98)
group_vector <- c("Group1", "Group2")

test_that("Two input vectors have different length", {
  expect_error(summary_by_group(numeric_vector, group_vector), "Sorry, the length of numeric_vector and group_vector are not equal. Data frame cannot be created!")
  
})
```

    ## Test passed

#### 4.4.2 Vectors of length 0

``` r
test_that("Two input vectors have length 0", {
  expect_error(summary_by_group(numeric(0), numeric(0)), "Sorry, the length of input vector cannot be zero.")
  
})
```

    ## Test passed
