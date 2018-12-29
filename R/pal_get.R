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
pal_get('coffee',colors = 'yellow')

pal_get <- function(tags,
                    n = 2,
                    type = c('continuos','discrete'),
                    colors = 'ALL',
                    min_col_dist = 75,
                    only_alpha = FALSE,
                    palreturn = 25,
                    catalogs = c('cpt-city')) {

  if (missing(tags)) {
    stop(sprintf('Attribute "tags" was not defined.'))
  }

  if (length(tags) != 1L) {
    tags <- sub("\\s","",tags)
    tags <- paste(sprintf("(?=.*%s)",tags),
                  collapse = '')
  }

  dbcheck <- catalogs %in% c('cpt-city','hex-color')

  if (!all(dbcheck)) {
    stop(sprintf('\n Catalog: %s not found it.',catalogs[!dbcheck]))
  }

  if (any(catalogs %in% 'cpt-city')) {
    load('/home/aybarpc01/Github/pal/data/cptcity.rda')
    cptcity <- pal_search(cptcity,tags,n,type,
                          colors,min_col_dist,
                          only_alpha,pal_return)
  }

  if (any(catalogs %in% 'hex-color')) {
    load('/home/aybarpc01/Github/pal/data/hex-color.rda')
  }
  return(cptcity)
}




pal_search <- function(db,
                       tags,
                       n,
                       type,
                       colors,
                       min_col_dist,
                       only_alpha,
                       pal_return) {

  # 1. search by tags
  case <- 'tags'
  regex_exp <- tolower(tags) # all tags are in lowercase.
  search_color <- grepl(regex_exp, db$tags, perl = T)
  db_position <- which(search_color)
  db <- db[db_position,]
  check(db,case)

  # 2. Filter based on color complexity
  # How many colors in your palette want?
  case <- 'n'
  db <- filter_(db,sprintf('n >= %d',n))
  check(db,case)

  # 3. Filter based on alpha parameter.
  # Do you want a palette with transparency?
  if (only_alpha) {
    case <- 'only_alpha'
    colordb <- filter(colordb,'alpha' == TRUE)
    check(db,case)
  }

  # 4. search using a color of reference
  # What color will you like existing in your palette?
  if (all(colors != 'ALL')) {

    # hex(RGB) to CIELAB space
    cielab_c <- try(RGB2Lab(col2rgb(colors)/255),
                    silent = T)
    if (class(cielab_c) == 'try-error') {
      stop(sprintf("%s is not a valid color",colors))
    }

    # get the minimum distance (color_mdist).
    ncolors <- nrow(db)
    color_mdist <- rep(NA,ncolors)

    for (x in 1:ncolors) {
      cielab_mtx <- db$matrix[[x]][,1:3]
      min_dist <- apply(rdist(cielab_mtx,cielab_c),2,min)
      color_mdist[x] <- mean(min_dist)
    }

    # order the dataset according to the distance
    db <- db[order(color_mdist),]

    # Filter by a minimum color distance (min_col_dist).
    case <- 'min_col_dist'
    db <- db[which(color_mdist < min_col_dist),]
    check(db,case)

    if (maxcol < nrow(db)) {
      palletes <- db[1:palreturn,]
    } else {
      palletes <- db
    }
  }
  return(db)
}

