#' pal_cptcity: The cpt-city dataset
#'
#' This data set (save as a tibble::data_frame)
#' gives a R-friendly access to characteristics of
#' the \href{cpt-city}{http://soliton.vm.bytemark.co.uk/pub/cpt-city/} catalogs.
#'
#' @format
#' In This data_frame each row represent a single color palette,
#' the columns contains the following: \cr
#' \itemize{
#'   \item tags: a character vector; label attached used for identification purpose.
#'   \item color: a list of character vectors; Contains color information in hexadecimal notation.
#'   \item n:  Numbers of colors used in the palette.
#'   \item matrix: a list of matrices; Contains color information at CIELAB color space.
#'   \item type: Type of the pallete. The type avaible are "discrete" or "continuous".
#'   \item alpha: logical; TRUE/FALSE whether the palette present at least color with transparent.
#'   \item names: character; "key" used for palette identification.
#'   }
#'
#' @note
#' pal_cptcity comprises 7140 palettes. The tags were created scraping the official
#' \href{http://soliton.vm.bytemark.co.uk/pub/cpt-city/}{cpt-city}
#' web site manteined by J.J. Green. Please respect the authors' copyright.
#' For get more documentation of each color palette visit the cpt-city webpage.
"pal_cptcity"



#' pal_colorhex: The color-hex dataset
#'
#' This data set (save as a tibble::data_frame)
#' gives a R-friendly access to characteristics of
#' the \href{https://www.color-hex.com/color-palettes/}{color-hex} catalogs.
#'
#' @format
#'
#' In This data_frame each row represent a single color palette,
#' the columns contains the following:
#'
#' \itemize{
#'   \item tags: a character vector; label attached used for identification purpose.
#'   \item color: a list of character vectors; Contains color information in hexadecimal notation.
#'   \item n:  Numbers of colors used in the palette.
#'   \item matrix: a list of matrices; Contains color information at CIELAB color space.
#'   \item type: Type of the pallete. The type avaible are "discrete" or "continuous".
#'   \item alpha: logical; TRUE/FALSE whether the palette present at least color with transparent.
#'   \item names: character; "key" used for palette identification.
#'   }
#'
#' @note
#' pal_colorhex comprises 68127 palettes. The tags were created scraping the official
#' \href{https://www.color-hex.com/color-palettes/}{color-hex}.
#' For get more documentation of each color palette visit the color-hex webpage.
"pal_colorhex"


#' pal_paletteer: Comprehensive Collection of Color Palettes
#'
#' (Modified of this \href{https://emilhvitfeldt.github.io/paletteer/}{website})
#' Paletteer is a great R package that collect all color palettes
#' across the R ecosystem  under the same package with a
#' streamlined API.
#'
#' @format
#' In This data_frame each row represent a single color palette,
#' the columns contains the following: \cr
#'
#' \itemize{
#'   \item tags: a character vector; label attached used for identification purpose.
#'   \item color: a list of character vectors; Contains color information in hexadecimal notation.
#'   \item n:  Numbers of colors used in the palette.
#'   \item matrix: a list of matrices; Contains color information at CIELAB color space.
#'   \item type: Type of the pallete. The type avaible are "discrete" or "continuous".
#'   \item alpha: logical; TRUE/FALSE whether the palette present at least color with transparent.
#'   \item names: character; "key" used for palette identification.
#'   }
#' @note
#' pal_paletteer comprises 1737 palettes. The author and mantainer
#' is \href{https://github.com/EmilHvitfeldt/}{Emil Hvitfeldt}.
#' For get more information about the authors' copyright,
#' check the following \href{https://github.com/EmilHvitfeldt/paletteer/blob/master/LICENSE.note}{license} file.
"pal_paletteer"
