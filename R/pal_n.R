pal_n <- function(pal = NULL, min = 0, max = Inf){
  palette_n <- new('.pal_n',min = min, max = max)
  if (!inherits(pal,'pal'))
    stop("Attempted to search a palette with no pal object.", call. = FALSE)
  query <- sprintf('n >= %s & n <= %s',min,max)
  pal@db <- pal@db %>% filter_(query)
  pal@n <- palette_n
  return(pal)
}
pal <- pal_search()
