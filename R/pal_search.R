#' Create a pal object
#'
#' @description
#' pal_search() initializes a S4 object. It is also
#' used to set global parameters.
#' @param catalogs character vector; Collections of palettes that
#' are used in the search. The palette collections available in pal package are: \cr
#' - cpt-city: http://soliton.vm.bytemark.co.uk/pub/cpt-city/index.html \cr
#' - color-hex: https://www.color-hex.com/color-palettes/ \cr
#' - paletteer: https://github.com/EmilHvitfeldt/paletteer \cr
#' @param  type character vector; Type of palette. The type: \cr
#' - 'continuous' \cr
#' - 'discrete' \cr
#' - 'diverging' \cr
#' - 'qualitative' \cr
#' - 'sequential' \cr
#'
#' The types: diverging, qualitative and sequential
#' only are supported by the 'paletteer'catalog.
#' @return a pal object (see \linkS4class{pal}).
#' @importFrom dplyr bind_rows
#' @export
pal_search <- function(catalogs = 'cpt-city',
                       type = c('continuous', 'discrete')) {

  palette <- new('pal')
  global <- new('.pal_global', catalogs = catalogs, type = type)
  palette@global <- global

  pal_valid_db <- c("cpt-city", "color-hex", "paletteer")
  dbcheck <- pmatch(palette@global@catalogs, pal_valid_db)

  if (anyNA(dbcheck)) {
    stop(sprintf("\n Catalog: \"%s\" not was found.",
                 catalogs[which(is.na(dbcheck))]))
  }

  rda_names <- c("pal_cptcity", "pal_colorhex", "pal_paletteer")
  catalogs <- rda_names[dbcheck]

  color_db <- lapply(1:length(catalogs),
                     function(x) eval(parse(text = rda_names[x])))

  db <- bind_rows(color_db)
  palette@db <- db

  return(palette)
}
