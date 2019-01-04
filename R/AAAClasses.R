setClass('pal',
         representation(db = 'tbl_df',
                        global = '.pal_global',
                        n = '.pal_n',
                        colors = '.pal_color',
                        tags = '.pal_tags'),
         prototype())

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


setClass('.pal_n',
         representation(
           min = 'numeric',
           max = 'numeric'),
         prototype(
           min = 0,
           max = Inf))


setClass('.pal_color',
         representation(colors = 'character',
                        distance = 'numeric'),
         prototype(distance = 75))

setClass('.pal_tags',
         representation(tags = 'character'),
         prototype())

