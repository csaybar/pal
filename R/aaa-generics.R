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
setGeneric("pal_plot", function(x, plotly) standardGeneric("pal_plot"))

#' @rdname pal_plot-m
#' @usage NULL
pal_plt <- function(x, plotly = FALSE) {

  palnames <- x@db$names

  if (nrow(x@db) > x@global@return) {
    npalettes <- x@global@return
  } else {
    npalettes <- nrow(x@db)
  }

  col_list <- rep(list(NA), npalettes)
  for (z in 1:npalettes) {
    palcol <- x@db$colors[[z]]
    # image(matrix(1:100),col=df_color$col)
    df <- data_frame(len = 1:length(palcol), col = palnames[z])
    tex_pal <- sprintf("%s:%s", palnames[z], palcol)

    d <- data_frame(xmin = 0.5,
                    xmax = sum(length(df$len),0.5),
                    ymin = -0.5,
                    ymax = 0.5)
    colorbar <- suppressWarnings(
      ggplot() +
        geom_rect(data = d,
                  mapping = aes(xmin = xmin,
                                xmax = xmax,
                                ymin = ymin,
                                ymax = ymax),
                  color = "black", alpha = 0,
                  size = 1) +
        geom_raster(data = df,
                    aes(x = len,
                        y = 0,
                        fill = len,
                        text = tex_pal)) +
        scale_fill_gradientn(colours = palcol) +
        facet_wrap(~col) +
        theme_pal())
    if (plotly) {
      col_list[[z]] <- ggplotly(colorbar, tooltip = "text")
    } else {
      col_list[[z]] <- colorbar
    }
  }
  nrows <- ceiling(sqrt(npalettes))
  if (plotly) {
    plotly_cols <- col_list
    if (length(plotly_cols) > 1) {
      subplot(plotly_cols, nrows = nrows,
              shareX = F, shareY = F,
              titleX = T, titleY = T)
    } else {
      plotly_cols[[1]]
    }
  } else {
    grid.newpage()
    if (length(col_list) > 1) {
      g <- arrangeGrob(grobs = col_list, nrow = nrows)
      grid.draw(g)
      invisible(g)
    } else {
      col_list[[1]]
    }
  }
}
