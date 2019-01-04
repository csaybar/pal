setMethod('show' , 'pal',
           function(object) {
             pal_show(object)
           }
)

pal_show <- function(x, ...) {
  cat('class              :' , class(x), '\n')
  ctl <- paste(x@global@catalogs,collapse = ', ')
  cat('catalogs           :' , ctl, '\n')
  cat('Range              :' , sprintf('%s to %s',x@n@min, x@n@max), '\n')
  if (length(x@colors@colors) != 0)
    cat('colors             :' , x@colors@colors, '\n')
  if (length(x@tags@tags) != 0)
    cat('Tags               :' , x@tags@tags, '\n')
  cat('Number of palettes :' , nrow(x@db), '\n')
}



bb <- pal_search() + pal_n(min = 150,max = 200)
pal_search()  %>%  pal_n(min = 150,max = 200)
bb@colors@colors <- 'cesar'
bb@tags@tags <- 'cesar'
raster()
