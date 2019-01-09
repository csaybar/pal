#' Filter considering color complexity.
#'
#'@rdname pal_n-m
#'@aliases pal_n, pal
setMethod('pal_n',signature(x = 'pal'), function(x, min, max) {
  palette_n <- new('.pal_n',min = min, max = max)
  query <- sprintf('n >= %s & n <= %s',min,max)
  x@db <- x@db %>% filter_(query)
  x@n <- palette_n
  return(x)
})


#' Filter considering color complexity.
#'
#'@rdname pal_n-m
#'@usage NULL
#'@aliases pal_n, missing, NULL
setMethod("pal_n",signature(x = "mn"), function(x, min, max) 'NULL')

#' Filter considering color complexity.
#'
#'@rdname pal_n-m
#'@usage NULL
#'@aliases pal_n, missing, NULL
setMethod("pal_n",signature(x = "numeric"), function(x, min, max) 'NULL')
