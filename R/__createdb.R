# 1._ Packages and auxiliary functions -------------------------------------
source('R/createdb_function.R')

# 2._ Getting tags and the http color palette  ----------------------------
url <- 'http://soliton.vm.bytemark.co.uk/pub/cpt-city/'
web_page <- read_html(url)
webs_list <- web_page %>% index_search()
webs_list$web74$tags
# 3._ Deep search (recursive)  --------------------------------------------
i=5
web_p <- webs_list[[i]]
data <- recursive_search(web_p = web_p)
data[[1]]$tags
data[[4]]$tags
data$tags[1]

data[[4]]$tags
data[[4]]$url
data$tags

