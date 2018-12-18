#' Search a colour palettes by attributes
#'
#' Search you ideal palette using the pal's color collection. It is generated
#' from the website \href(cpt-city){http://soliton.vm.bytemark.co.uk/pub/cpt-city/},
#' \href(hex-color){https://www.color-hex.com/} and also some R palletes libraries.
#'
#' You can search palettes using tags, a favorite color, a specific number of colors on
#' the palette, grade of transparency, and if it presents uniform
#' distribution.
#'
#' @param name tags;
#' @param name colors;
#' @param name n;
#' @param name alpha;
#' @param name catalogs;
#' @return Character. An unique 'key' value.
#' @export
pal_search <- function(tags = 'coffee',
                       pattern =  'aafasfasfas',
                       n = 2,
                       only_alpha = FALSE,
                       colors = 'blue',
                       catalogs = c('cpt-city')) {
  colordb <- dbcolor #upload the dbcolor

  # 1. search by tags using a pattern
  if (!missing(tags) & !missing(pattern)) {
    case <- 'pattern'
    regex_exp <- tolower(pattern)
    search_color <- grepl(regex_exp, dbcolor$tags, perl = T)
    db_position <- which(search_color)
    colordb <- colordb[db_position,]
    check(colordb,case)
  }
  # 2. Filter based on color complexity
  case <- 'n'
  colordb <- filter(colordb,'n' >= n)
  check(colordb,case)
  # 3. Filter based on alpha parameter.
  if (only_alpha) {
    case <- 'only_alpha'
    colordb <- filter(colordb,'alpha' == TRUE)
    check(colordb,case)
  }
  # 4. search by tags using a color a base
}
