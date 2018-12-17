#' Search a colour palettes by attributes
#'
#' Search you ideal palette using the pal's color collection. It is generated 
#' from the website \href(cpt-city){http://soliton.vm.bytemark.co.uk/pub/cpt-city/},
#' \href(hex-color){https://www.color-hex.com/} and also some R palletes libraries. 
#' 
#' You can search palettes using tags, a favorite color, a specific number of colors on 
#' the palette, transparency, and if it presents uniform
#' distribution.
#' 
#' @param name tags;
#' @param name colors; 
#' @param name n; 
#' @param name catalogs; 
#' @return Character. An unique 'key' value.
#' @export
pal_search <- function(tags = 'viridis',
                       colors = 'ALL',
                       n = Inf,
                       catalogs = c('R','hex-color','cpt-city')) {
  cptcity_db <- sysdata[["cptcity"]]
  regex_exp <- '(?=.*%s)'
  regex_expresion <- sprintf(regex_exp,tags) %>% 
    paste(collapse = '')
  search_color <- grepl(regex_expresion,cptcity_db$tags,perl = T) %>% 
    which()
  cptcity_db$tags[search_color]
}