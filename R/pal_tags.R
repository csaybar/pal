pal_tags <- function(pal = NULL, ...) {
  args <- match.call()
  remove_words <- c('pal_tags', 'pal','.')
  args <- as.character(args)
  args <- args[!args %in% remove_words]

  args_tlw <- tolower(args)
  if (length(args) > 1L) {
    regex_exp <- paste(sprintf('(?=.*%s)',args_tlw), collapse = '')
  } else {
    regex_exp <- args_tlw
  }
  palette_db <- pal@db
  search_color <- grepl(regex_exp, palette_db$tags, perl = T)
  db_position <- which(search_color)
  pal@db <- palette_db[db_position,]
  pal@colors@colors <- args_tlw
  return(pal)
}
