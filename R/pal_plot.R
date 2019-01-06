#' Display color palettes in a plot
#'
#'@rdname pal_plot-m
#'@aliases pal_plot, character
setMethod("pal_plot", signature(x = "character"),function(x, plotly = FALSE){
  pal_c <- pal_cnstr(x)
  pal_plt(pal_c, plotly = plotly)
})

#' Display color palettes in a plot
#'
#'@rdname pal_plot-m
#'@aliases pal_plot, list
setMethod("pal_plot", signature(x = "list"), function(x, plotly = FALSE){
  pal_c <- pal_cnstr(x)
  pal_plt(pal_c, plotly = plotly)
})

#' Display color palettes in a plot
#'
#'@rdname pal_plot-m
#'@aliases pal_plot, pal
setMethod("pal_plot", signature(x = "pal"), function(x, plotly = FALSE){
  pal_c <- x
  pal_plt(pal_c, plotly = plotly)
})
