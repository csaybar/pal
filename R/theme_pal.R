#' theme_pal
#'
#' A ggplot2 theme for plot multiple color palletes.
#'
#' @importFrom ggplot2 theme_minimal theme %+replace% element_blank element_text
#' @importFrom grid unit
#' @export
theme_pal <- function() {
  theme_minimal() %+replace% theme(legend.position = "none", axis.text.y = element_blank(),
                                   axis.text.x = element_blank(), axis.ticks.x = element_blank(),
                                   axis.ticks.y = element_blank(), axis.title.y = element_blank(),
                                   axis.title.x = element_blank(), plot.title = element_text(hjust = 0.5),
                                   axis.ticks.length = unit(0, "mm"), panel.grid.major = element_blank(),
                                   panel.grid.minor = element_blank())
}
