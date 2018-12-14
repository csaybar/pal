# 1._Libraries ------------------------------------------------------------
library(rvest)
library(openNLP)
library(NLP)
library(stringr)
library(tidyverse)
options(java.parameters = "- Xmx1024m")
blacklist <- read_table('R/blacklist.txt',col_names = F)[[1]] %>% tolower()
blacklist <- blacklist[!duplicated(blacklist)]
# 2._ Functions -----------------------------------------------------------
# I'm not the best in scraping web and the code is not documented ... I apologize


# 2.1._ Tagging words https://stackoverflow.com/questions/2970829/ --------
tagPOS <-  function(x, ...) {
  s <- as.String(x)
  word_token_annotator <- Maxent_Word_Token_Annotator()
  a2 <- Annotation(1L, "sentence", 1L, nchar(s))
  a2 <- NLP::annotate(s, word_token_annotator, a2)
  a3 <- NLP::annotate(s, Maxent_POS_Tag_Annotator(), a2)
  a3w <- a3[a3$type == "word"]
  POStags <- unlist(lapply(a3w$features, `[[`, "POS"))
  POStagged <- paste(sprintf("%s/%s", s[a3w], POStags), collapse = " ")
  list(POStagged = POStagged, POStags = POStags)
}


# 2.2._ Extracting Nouns and Verbs via tagPOS -----------------------------

get_words <- function(phrase) {
  if (length(strsplit(phrase,' ')[[1]]) <= 1) {
    return(phrase)
  } else {
    tagging <- tagPOS(phrase)  
    verbs <- sapply(strsplit(tagging$POStagged,"[[:punct:]]*/VB.?"),function(x) {res = sub("(^.*\\s)(\\w+$)", "\\2", x); res[!grepl("\\s",res)]})
    nouns <- sapply(strsplit(tagging$POStagged,"[[:punct:]]*/NN.?"),function(x) {res = sub("(^.*\\s)(\\w+$)", "\\2", x); res[!grepl("\\s",res)]})
    others <- sapply(strsplit(tagging$POStagged,"[[:punct:]]*/J.?"),function(x) {res = sub("(^.*\\s)(\\w+$)", "\\2", x); res[!grepl("\\s",res)]})
    
    if (is.list(others)) {
      others <- as.character()
    } 
    if (is.list(nouns)){
      nouns <- as.character()
    } 
    if (is.list(verbs)) {
      verbs <- as.character()
    }
    words <- c(nouns,verbs,others)  
    return(words)
  }
  }


# 2.3._ Eliminate html character ------------------------------------------
remove_trash <- function(word) {
  clean_word <- word %>% 
    str_replace_all('\n',' ') %>%
    str_replace_all(':',' ') %>% 
    str_replace_all('&amp',' ') %>%
    str_replace_all('&',' ') %>%
    str_replace_all(',',' ') %>%
    str_replace_all(';',' ') %>% 
    str_replace_all('-',' ')
  return(clean_word)
}

# 2.4._ Are there thumbs here? --------------------------------------------
exist_thumbs <-function(xml_document){
  thumbs <- xml_document   %>% 
      html_nodes('.thumbs')
  return(as.logical(length(thumbs)))
}


# 2.5._ Get the svg files -------------------------------------------------
get_svgnames <- function(xml_document) {
  svg_names <- xml_document %>% 
    html_nodes('.thumbs') %>% 
    html_nodes('.thumb') %>% 
    html_nodes('a') %>% 
    html_attr('href') %>% 
    basename(.) %>% 
    str_remove('\\.png\\.index\\.html') %>% 
    sprintf('%s.svg',.)
  return(svg_names)
}

# 2.6._ Get only the links organised by author ----------------------------
index_search <- function(xml_document) {
  web_pages <- xml_document %>% 
    html_nodes('ul') %>% 
    '['(2) %>% 
    html_nodes('a') %>% 
    html_attr('href') %>% 
    paste0(url,.)
  
  web_pages_info <- xml_document %>% 
    html_nodes('ul') %>% 
    '['(2) %>% 
    html_nodes('a') %>% 
    html_text('href') %>% 
    tolower() 
  
  order_inf <- function(x) {
    words <- web_pages_info[x] %>% 
      remove_trash() %>%
      str_replace_all("\\[|\\]|\\{|\\}|\\(|\\)|\\/|\\/|\\/",' ') %>% 
      rm_word(.,blacklist) %>% 
      str_squish() %>% 
      get_words() %>% 
      tolower() %>% 
      str_remove_all('/.')
    words <- words[!words == '.']
    gc()
    return(list(url = web_pages[x],
                tags = words,
                xml = read_html(web_pages[x])))
  }
  web_serie <- 1:length(web_pages_info)
  webs_list <- lapply(web_serie,order_inf)
  
  names(webs_list) <- sprintf('web%02d',web_serie)
  return(webs_list)
}


# 2.7._ DeepSearch for each palette author --------------------------------
index_deepsearch <- function(xml_list) {
  url <- dirname(xml_list$url)
  web_pages <- xml_list$xml %>% 
    html_nodes('ul') %>% 
    '['(2) %>% 
    html_nodes('a') %>% 
    html_attr('href') %>% 
    paste0(url,'/',.)
  
  web_pages_info <- xml_list$xml %>% 
    html_nodes('ul') %>% 
    '['(2) %>% 
    html_nodes('a') %>% 
    html_text('href')
  
  # 
  more_tags <- xml_list$xml %>% 
    html_nodes('.content') %>% 
    html_nodes('p') %>% 
    html_text() %>% 
    paste(collapse = ' ') %>% 
    tolower() %>% 
    remove_trash() %>% 
    str_replace_all("\\[|\\]|\\{|\\}|\\(|\\)|\\/|\\/|\\/",' ') %>% 
    rm_word(blacklist) %>% 
    str_squish() %>% 
    get_words() %>% 
    str_remove_all('/.')
  more_tags <- more_tags[!more_tags == '.']
  
  words <- web_pages_info %>% 
    remove_trash() %>% 
    str_replace_all("\\[|\\]|\\{|\\}|\\(|\\)|\\/|\\/|\\/",' ') %>% 
    str_squish() %>% 
    get_words() %>% 
    tolower() %>% 
    str_remove_all('/.')
  
  order_inf <- function(x) {
      vector_nm <- c(xml_list$tags,words[x],more_tags)
      vector_nm <- vector_nm[!duplicated(vector_nm)]
      list(url = web_pages[x],
           tags = vector_nm,
           xml = read_html(web_pages[x]))
  }
  web_serie <- 1:length(web_pages_info)
  webs_list <- lapply(web_serie, order_inf)
  return(webs_list)
}

# 2.8._ Create a data_frame with tags and svg urls. -----------------------
# list_web <- list_deep[[3]]
create_svg_df <- function(list_web) {
  page_tags <- list_web$xml %>% 
    html_nodes('.content') %>% 
    html_nodes('p') %>% 
    html_text() %>% 
    paste(collapse = ' ') %>% 
    tolower() %>% 
    remove_trash() %>% 
    str_replace_all("\\[|\\]|\\{|\\}|\\(|\\)|\\/|\\/|\\/",' ') %>% 
    rm_word(blacklist) %>% 
    str_squish() %>% 
    get_words() %>% 
    str_remove_all('/.')
  page_tags <- page_tags[!page_tags == '.']
  
  pages_tags <- c(list_web$tags,page_tags)
  pages_tags <- pages_tags[!duplicated(pages_tags)]
  
  svgnames <- get_svgnames(list_web$xml)
  urls <- sprintf('%s/%s',dirname(list_web$url),svgnames)
  last_tags <- str_remove_all(svgnames,'\\.svg$')
  tags <- sapply(1:length(last_tags),
                 function(x) paste(c(pages_tags,last_tags[x]),
                                   collapse = '__'))
  df <- data_frame(url = urls,tags = tags)
  return(df)
}


# 2.9._ Recursive search using index_deepsearch and create_svg_df ---------
recursive_search <- function(web_p) {
  if (exist_thumbs(web_p$xml)) {
    return(create_svg_df(web_p))
  } else {
    list_deep = index_deepsearch(xml_list = web_p)
    lapply(1:length(list_deep),
           function (x) recursive_search(list_deep[[x]]))    
  }
}

# 2.10._ Remove words considering the blacklist.txt
rm_word <- function(str, blacklist) {
  x <- unlist(strsplit(str, " "))
  paste(x[!x %in% blacklist], collapse = " ")
}
