#' Filter considering colors
#'
#'@rdname pal_tags-m
#'@aliases pal_colors, pal
setMethod('pal_colors',signature('pal'), function(x, ..., dist, only_alpha) {
  colors <- c(...)

  if (only_alpha)
    x@db <- filter_(x@db,'alpha == TRUE')

  if (all(colors != 'ALL')) {
    # hex(RGB) to CIELAB space
    cielab_c <- try(RGB2Lab(col2rgb(colors)/255),
                    silent = T)
    if (class(cielab_c) == 'try-error') {
      stop(sprintf("%s is not a valid color",colors))
    }
    # get the minimum distance (color_mdist).

    ncolors <- nrow(x@db)
    color_mdist <- rep(NA,ncolors)

    for (zz in 1:ncolors) {
      cielab_mtx <- x@db$matrix[[zz]][,1:3]
      min_dist <- apply(rdist(cielab_mtx,cielab_c),2,min)
      color_mdist[zz] <- mean(min_dist)
    }

    # order the dataset according to the distance
    x@db <- x@db[order(color_mdist),]

    # Filter by a minimum color distance (min_col_dist).
    x@db <- x@db[which(color_mdist < dist),]
  }
  return(x)
})
