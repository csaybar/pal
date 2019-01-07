#'@rdname pal_plot-m
#'@include aaa-generics.R
#'@usage NULL
pal_plt <- function(x, return, plotly) {
  palnames <- x@db$names

  if (nrow(x@db) > return) {
    npalettes <- return
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


#' Display color palettes in a plot
#'
#'@rdname pal_plot-m
#'@aliases pal_plot, character
setMethod("pal_plot", signature(x = "character"), function(x, return, plotly) {
  pal_c <- pal_cnstr(x)
  pal_plt(pal_c, return = return, plotly = plotly)
})

#' Display color palettes in a plot
#'
#'@rdname pal_plot-m
#'@aliases pal_plot, list
setMethod("pal_plot", signature(x = "list"), function(x, return, plotly) {
  pal_c <- pal_cnstr(x)
  pal_plt(pal_c, return = return, plotly = plotly)
})

#' Display color palettes in a plot
#'
#'@rdname pal_plot-m
#'@aliases pal_plot, pal
setMethod("pal_plot", signature(x = "pal"), function(x, return, plotly) {
  pal_c <- x
  pal_plt(pal_c, return, plotly)
})

#' Display color palettes in a plot
#'
#'@usage NULL
setMethod("pal_plot",signature(x = "mn"), function(x, return, plotly) 'NULL')
