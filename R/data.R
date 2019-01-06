#' pal_cptcity: The cpt-city dataset
#'
#' This dataset gives friendly access to the \href{http://soliton.vm.bytemark.co.uk/pub/cpt-city/}{cpt-city} catalog.
#'
#' @format
#' In pal_cptcity each row represent a single palette, the columns contain the following information: \cr
#' \itemize{
#'   \item tags: a character vector; label attach used for identification purpose.
#'   \item color: a list of character vectors; Contains color information in hexadecimal notation.
#'   \item n:  Numbers of colors used in the palette.
#'   \item matrix: a list of matrices; Contains color information at CIELAB color space.
#'   \item type: Type of the pallete. The types available are "discrete" and "continuous".
#'   \item alpha: logical; TRUE/FALSE whether the palette present at least one color with transparent.
#'   \item names: character; "key" used for palette identification.
#'   }
#'
#' @note
#' pal_cptcity comprises 7140 palettes. The tags were created scraping the official
#' \href{http://soliton.vm.bytemark.co.uk/pub/cpt-city/}{cpt-city}
#' website manteined by J.J. Green. Please respect the authors' copyright.
#' For get more documentation of each color palette visit the
#' \href{http://soliton.vm.bytemark.co.uk/pub/cpt-city/}{cpt-city} website.
"pal_cptcity"

#' pal_colorhex: The color-hex dataset
#'
#' This dataset gives friendly access to the \href{https://www.color-hex.com/color-palettes/}{color-hex} catalog.
#'
#' @format
#' In pal_colorhex each row represent a single palette, the columns contain the following information: \cr
#' \itemize{
#'   \item tags: a character vector; label attach used for identification purpose.
#'   \item color: a list of character vectors; Contains color information in hexadecimal notation.
#'   \item n:  Numbers of colors used in the palette.
#'   \item matrix: a list of matrices; Contains color information at CIELAB color space.
#'   \item type: Type of the pallete. The types available are "discrete" and "continuous".
#'   \item alpha: logical; TRUE/FALSE whether the palette present at least one color with transparent.
#'   \item names: character; "key" used for palette identification.
#'   }
#' @note
#' pal_colorhex comprises 68127 palettes. The tags were created scraping the official
#' \href{https://www.color-hex.com/color-palettes/}{color-hex} website.
#' For get more documentation of each color palette visit the
#' \href{https://www.color-hex.com/color-palettes/}{color-hex} website.
"pal_colorhex"


#' pal_paletteer: Comprehensive Collection of R Color Palettes
#'
#' (Modified of this \href{https://emilhvitfeldt.github.io/paletteer/}{website})
#' Paletteer is a great R package that collects color palettes
#' of the R ecosystem under the same package with
#' a streamlined API.
#'
#' @format
#' In pal_paletteer each row represent a single palette, the columns contain the following information: \cr
#' \itemize{
#'   \item tags: a character vector; label attach used for identification purpose.
#'   \item color: a list of character vectors; Contains color information in hexadecimal notation.
#'   \item n:  Numbers of colors used in the palette.
#'   \item matrix: a list of matrices; Contains color information at CIELAB color space.
#'   \item type: Type of the pallete. The types available are "discrete" and "continuous".
#'   \item alpha: logical; TRUE/FALSE whether the palette present at least one color with transparent.
#'   \item names: character; "key" used for palette identification.
#'   }
#' @note
#' pal_paletteer comprises 1737 palettes. The author and mantainer
#' of paletteer is \href{https://github.com/EmilHvitfeldt/}{Emil Hvitfeldt}.
#' For get more information about the author's copyright,
#' check the following \href{https://github.com/EmilHvitfeldt/paletteer/blob/master/LICENSE.note}{license} file.
"pal_paletteer"
