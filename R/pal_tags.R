#' Filter considering tags
#'
#'@rdname pal_tags-m
#'@aliases pal_tags, pal
setMethod('pal_tags',signature('pal'), function(x, ...) {
  args <- c(...)
  args_tlw <- tolower(args)
  if (length(args) > 1L) {
    regex_exp <- paste(sprintf('(?=.*%s)',args_tlw), collapse = '')
  } else {
    regex_exp <- args_tlw
  }
  palette_db <- x@db
  search_color <- grepl(regex_exp, palette_db$tags, perl = T)
  db_position <- which(search_color)
  x@db <- palette_db[db_position,]
  x@tags@tags <- args_tlw
  return(x)
})

#' Filter considering tags
#'
#'@rdname pal_tags-m
#'@aliases pal_tags, mn
setMethod("pal_tags",signature(x = "character"), function(x, min, max) 'NULL')
