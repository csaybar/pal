#' Create a pal search
#'
#' @description
#' pal_search() initializes a pal object. It is
#' used to set the global parameters of 'pal' search.
#' @param  catalogs character vector; Collections of color palette.
#' The color palette collections used in pal package come from: \cr
#' - cpt-city: http://soliton.vm.bytemark.co.uk/pub/cpt-city/index.html \cr
#' - color-hex: https://www.color-hex.com/color-palettes/
#' - paletteer: https://github.com/EmilHvitfeldt/paletteer
#' @param  type character vector; Type of palette. The type: \cr
#' - 'diverging' \cr
#' - 'qualitative' \cr
#' - 'sequential' \cr
#' only are supported by the 'paletteer'catalogs.
#' @param return numeric; Specify the number of palettes to be returned.
#'
#' @export
pal_search <- function(catalogs = c('cpt-city','color-hex','paletteer'),
                       type = c('continuous', 'discrete', 'diverging',
                                'qualitative','sequential'),
                       return = 25) {
  pal_valid_db <- c("cpt-city", "color-hex", "paletteer")
  dbcheck <- pmatch(catalogs, pal_valid_db)

  if (anyNA(dbcheck)) {
    stop(sprintf("\n Catalog: \"%s\" not was found.",
                 catalogs[which(is.na(dbcheck))]))
  }

  rda_names <- c("pal_cptcity", "pal_colorhex", "pal_paletteer")
  catalogs <- rda_names[dbcheck]

  pal_obj <- structure(list(catalogs = catalogs,
                            type = type, return = 25),
                       class = "pal")
  return(pal_obj)
}
