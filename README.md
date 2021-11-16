
<!-- README.md is generated from README.Rmd. Please edit that file -->

# yueshen

<!-- badges: start -->
<!-- badges: end -->

The goal of yueshen is to get the summary statistics (max, min, mean and
median) of a numerical variable across the groups of a categorical
variable.

## Installation

You can install the released version of **yueshen** from
[CRAN](https://CRAN.R-project.org) with:

``` r
devtools::install_github("stat545ubc-2021/functions-sylvieshen.git", ref = "0.1.0")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(yueshen)
summary_by_group(c(1.5, 7.6, 3.0, 4.7, 8, 8.4), c("A", "C", "A", "B", "B", "A"))
#> # A tibble: 3 x 5
#>   group_vector   max   min  mean median
#>   <chr>        <dbl> <dbl> <dbl>  <dbl>
#> 1 A              8.4   1.5  4.3    3   
#> 2 B              8     4.7  6.35   6.35
#> 3 C              7.6   7.6  7.6    7.6
```

The following example outputs the summary statistics of the numerical
variable `diameter` across the groups of `genus_name` in the dataset
`vancouver_trees`

``` r
summary_by_group(datateachr::vancouver_trees$diameter, datateachr::vancouver_trees$genus_name)
#> # A tibble: 97 x 5
#>    group_vector   max   min  mean median
#>    <chr>        <dbl> <dbl> <dbl>  <dbl>
#>  1 ABIES         42.5     1 12.9   12   
#>  2 ACER         317       0 10.6    8   
#>  3 AESCULUS      64       0 23.7   25   
#>  4 AILANTHUS     21.5     3 15.9   19.5 
#>  5 ALBIZIA        6       6  6      6   
#>  6 ALNUS         40       0 17.5   17.5 
#>  7 AMELANCHIER   20       0  3.21   3   
#>  8 ARALIA        12       3  6.81   6.12
#>  9 ARAUCARIA     32       3 11.4    8.5 
#> 10 ARBUTUS       33       6 18.4   17.5 
#> # ... with 87 more rows
```

For more information, please refer to the development documentation of
function by running `?summary_by_group` in the **Console** of
**RStudio**.
