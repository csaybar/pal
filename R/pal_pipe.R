#' Add components to a pal_search()
#'
#' Based on ggplot2 and magrittr sintaxis we use `+` or `%>%` for
#' constructing sophisticated searchings. It allows you
#' to start simple, then get more and more complex search,
#' checking your work at each step.
#'
#' @param left A pal object.
#' @param rigth A pal_search method.
#' @examples
#'
#' pal_search() +
#'  pal_plot(return = 5, plotly = FALSE)
#'
#' pal_search() %>%
#'  pal_plot(return = 5, plotly = FALSE)
#' @export
`+.pal` <- function(left , rigth) {
  left_name <- deparse(substitute(left))
  rigth_name <- deparse(substitute(rigth))
  left_name <- gsub('\\+','%>%',left_name)
  exp_name <- sprintf('%s %s %s', left_name, '%>%', rigth_name)
  eval(parse(text = exp_name))
}




