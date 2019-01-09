#' Add components to a pal_search()
#'
#' Based on the semantics that proposes the R packages 'magrittr'
#' we use `%>%` for constructing sophisticated searchings. It allows
#' you to start simple, then get more and more complex search,
#' checking your work at each step. Visit the website of
#' \href{https://magrittr.tidyverse.org/}{magrittr} for get more
#' information about %>%.
#' @param left A pal object.
#' @param rigth A pal_search method.
#' @examples
#'
#' pal_search() %>%
#'  pal_plot(return = 5, plotly = FALSE)
#' @export
`%>%` <- magrittr::`%>%`
