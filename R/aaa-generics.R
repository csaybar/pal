#' Display color palettes in a plot
#'
#' pal_plot create an excellent visualization for
#' finding the color palette that best suit your
#' interests.
#'
#' @usage NULL
#' @param x character vector,list or pal object; if x is a
#' character vector or a list must be in hexadecimal notation
#' or a built-in color names which R knows about (see `colors()`).
#' @param return numeric;  Number of palettes to be returned in the plot.
#' @param plotly logical; TRUE/FALSE whether a plotly plot must be returned.
#' @importFrom ggplot2 ggplot aes geom_rect geom_raster scale_fill_gradientn facet_wrap
#' @importFrom tibble data_frame
#' @importFrom grid grid.newpage grid.draw
#' @importFrom gridExtra arrangeGrob
#' @importFrom plotly subplot ggplotly
#' @export
#' @docType methods
#' @rdname pal_plot-m
#'
#' @examples
#' #list
#' pal1 <- c("#2F3869","#A9ABC6","#ECFC96","#B8A75E")
#' pal2 <- c("#1E5CB4","#54C7CF","#FED71C","#A5262C")
#' palettes <- list(pal001 = pal1, pal002 = pal2)
#' pal_plot(palettes,plotly = TRUE)
#'
#' #character
#' pal <- c('blue','red','yellow')
#' pal_plot(pal,plotly = FALSE)
#'
setGeneric("pal_plot", function(x, return = 25, plotly = TRUE) standardGeneric("pal_plot"))

#' Filter considering color complexity.
#'
#' Palettes are constituted by a specific number of color.
#' pal_n allow filter considering the number of colors on the palette.
#'
#' @param x pal object;
#' @param min numeric; Minimum number of colors on the palette.
#' @param max numeric; Maximum number of colors on the palette.
#' @export
#' @docType methods
#' @rdname pal_n-m
#' @importFrom dplyr filter_
#' @examples
#'
#' pal_search() # Number of palettes : 77004
#' pal_search() + pal_n(min = 100, max = 120) # Number of palettes : 500
#'
setGeneric("pal_n", function(x, min = 0L, max = Inf) standardGeneric("pal_n"))


#' Filter considering tags.
#'
#' pal_tags allow filter palettes considering the tags.
#' For the catalogs:
#' \href{https://www.color-hex.com/color-palettes/}{color-hex},
#' \href{http://soliton.vm.bytemark.co.uk/pub/cpt-city/}{cpt-city}
#' the tags were created scraping the website. For the
#' \href{https://emilhvitfeldt.github.io/paletteer/}{paletteer}
#' catalog the package and palette names were used by created the tags.
#' @param x A pal object.
#' @param \dots character, name of tags.
#' @export
#' @docType methods
#' @rdname pal_tags-m
#'
setGeneric("pal_tags", function(x, ...) standardGeneric("pal_tags"))



#' Filter considering colors.
#'
#' pal_colors allow filter palettes considering colors.
#' @param x A pal object.
#' @param only_alpha logical
#' @param distance numeric, Distance to the colors.
#' @param \dots character, name of colors.
#' @importFrom grDevices col2rgb
#' @importFrom patchPlot RGB2Lab
#' @importFrom fields rdist
#' @export
#' @docType methods
#' @rdname pal_colors-m
#'
#'
setGeneric("pal_colors", function(x, ..., dist = 75, only_alpha = TRUE) standardGeneric("pal_colors"))
