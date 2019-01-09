setMethod('show' , 'pal',
           function(object) {
             pal_show(object)
           })

pal_show <- function(object) {
  cat('class              :' , class(object), '\n')
  ctl <- paste(object@global@catalogs,collapse = ', ')
  cat('catalogs           :' , ctl, '\n')
  cat('Range              :' , sprintf('%s to %s',object@n@min, object@n@max), '\n')
  cat('colors             :' , object@colors@colors, '\n')
  cat('Tags               :' , object@tags@tags, '\n')
  cat('Number of palettes :' , nrow(object@db), '\n')
}
