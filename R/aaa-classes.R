#' An S4 class to represent the global parameters of pal.
#'
#'@slot catalogs character vector; Collections of color palettes.
#' The palette collections available in pal package are: \cr
#' - cpt-city: http://soliton.vm.bytemark.co.uk/pub/cpt-city/index.html \cr
#' - color-hex: https://www.color-hex.com/color-palettes/ \cr
#' - paletteer: https://github.com/EmilHvitfeldt/paletteer \cr
#'@slot type  character vector; Type of palette. The type: \cr
#' - 'diverging' \cr
#' - 'qualitative' \cr
#' - 'sequential' \cr
#' only are supported by the 'paletteer'catalogs. \cr
#'@slot return numeric; Specify the number of palettes to be returned.
setClass('.pal_global',
         representation(
           catalogs = 'character',
           type = 'character',
           return = 'numeric'),
         prototype(
           catalogs = c('cpt-city','color-hex','paletteer'),
           type = c('continuous', 'discrete', 'diverging',
                    'qualitative','sequential'),
           return = 25))


#' An S4 class to represent the color complexity of pal.
#'
#'@slot min numeric; min number of colors.
#'@slot max numeric; max number of colors.
setClass('.pal_n',
         representation(
           min = 'numeric',
           max = 'numeric'),
         prototype(
           min = 0,
           max = Inf))


#' An S4 class to save the color characteristics of pal.
#'
#'@slot color character.
#'@slot distance numeric.
setClass('.pal_color',
         representation(colors = 'character',
                        distance = 'numeric'),
         prototype(colors = NA_character_,
                   distance = 75))

#' An S4 class to save the tags of pal.
#'
#'@slot tags numeric.
setClass('.pal_tags',
         representation(tags = 'character'),
         prototype(tags = NA_character_))

#' An S4 class to save the tags of pal.
#'
#'@slot db tbl_df object.
#'@slot global .pal_global object.
#'@slot n .pal_n object.
#'@slot colors .pal_color object.
#'@slot tags .pal_tags object.
setClass('pal',
         representation(db = 'tbl_df',
                        global = '.pal_global',
                        n = '.pal_n',
                        colors = '.pal_color',
                        tags = '.pal_tags'),
         prototype())


#' Create a simple pal object
#'
#'@param col numeric.

pal_cnstr <- function(col = NA) {

  if (is.character(col)) {
    col <- list(col)
  } else if (is.list(col)) {
    col_names = names(col)
  } else {
    stop('col must be a list or a list')
  }

  if (is.null(names(col))) {
    numlength <- paste0("%0", nchar(length(col)), "d")
    longitude_name <- sprintf("pal_%s", numlength)
    col_names <- sprintf(longitude_name, 1:length(col))
  }


  pal_pal <- new('pal')

  pal_pal@db <- data_frame(tag = NA,
                           colors = col,
                           n = sapply(col, length),
                           matrix = NA,
                           type = NA,
                           alpha = NA,
                           names = col_names)
  return(pal_pal)
}
