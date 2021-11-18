
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
#' @import dplyr tidyr datateachr
#' @importFrom stats median
#' @return An object of class "data.frame" that contains the summary statistics of each group type.
#'
#' @examples
#' summary_by_group(c(1.5, 7.6, 3.0, 4.7, 8, 8.4), c("A", "C", "A", "B", "B", "A"))
#' summary_by_group(datateachr::vancouver_trees$diameter, datateachr::vancouver_trees$genus_name)
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
  dplyr::tibble(numeric_vector, group_vector) %>% tidyr::drop_na() %>%
    dplyr::group_by(group_vector) %>%
    dplyr::summarise(max = max(numeric_vector), min = min(numeric_vector),
                     mean = mean(numeric_vector), median = median(numeric_vector))
}
