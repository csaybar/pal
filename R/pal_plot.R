#' Display multiple palettes in a plot
#'
#' pal_plot create an excellent visualization for
#' finding the color palette that best suit your
#' interests.
#'
#' @param colors list or vector; colors to plots,
#' colors param must be in hexadecimal notation.
#' @param newpage logical; TRUE/FALSE whether open a new page.
#' @param plotly logical; TRUE/FALSE whether a plotly
#' visualization must be returned.
#' @importFrom ggplot2 ggplot aes geom_rect geom_raster scale_fill_gradientn facet_wrap
#' @importFrom tibble data_frame
#' @importFrom grid grid.newpage grid.draw
#' @importFrom gridExtra arrangeGrob
#' @importFrom plotly subplot ggplotly
#' @examples
#' pal1 <- c("#2F3869","#A9ABC6","#ECFC96","#B8A75E")
#' pal2 <- c("#1E5CB4","#54C7CF","#FED71C","#A5262C")
#' palettes <- list(pal1 = pal1, pal2 = pal2)
#' pal_plot(palettes,plotly = TRUE)
#' @export
pal_plot <- function(colors, newpage = TRUE, plotly = FALSE) {
  if (is.character(colors)) {
    colors <- list(colors)
  }
  if (!class(colors) == "list") {
    stop("colors must be a list or a character hex vector")
  }
  if (is.null(names(colors))) {
    numlength <- paste0("%0", nchar(length(colors)), "d")
    longitude_name <- sprintf("pal_%s", numlength)
    names(colors) <- sprintf(longitude_name, 1:length(colors))
  }
  palnames <- names(colors)
  col_list <- rep(list(NA), length(colors))
  for (z in 1:length(col_list)) {
    palcol <- colors[[z]]
    # image(matrix(1:100),col=df_color$col)
    df <- data_frame(len = 1:length(palcol), col = palnames[z])
    tex_pal <- sprintf("%s:%s", palnames[z], palcol)
    d <- data_frame(xmin = 0.5,
                    xmax = length(df$len) + 0.5,
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
  nrows <- ceiling(sqrt(length(colors)))
  if (plotly) {
    plotly_cols <- col_list
    if (length(plotly_cols) > 1) {
      subplot(plotly_cols, nrows = nrows,
              shareX = F, shareY = F,
              titleX = T, titleY = T)
    } else {
      plotly_cols
    }
  } else {
    if (newpage)
      grid.newpage()
    if (length(col_list) > 1) {
      g <- arrangeGrob(grobs = col_list, nrow = nrows)
      grid.draw(g)
      invisible(g)
    } else {
      col_list
    }
  }
}
