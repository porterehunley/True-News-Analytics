library(XML)
library("methods")
library("stringr")
library(rvest)

#Gathering the data
url <- 'https://www.ef.com/wwen/english-resources/english-vocabulary/top-100-words/'
webpage <- read_html(url)
xmlInternTree <- xmlInternalTreeParse("http://rss.cnn.com/rss/cnn_allpolitics.rss.xml")

xmlTop <- xmlRoot(xmlInternTree) #THE ROOT OF THE TREE
xmlNewTop <- xmlTop[[1]]

xmlItems<- xmlChildren(xmlNewTop)[15:xmlSize(xmlNewTop)] #Filter Items by description
filteredItems <- lapply(xmlItems, l_filter_items) #TODO: use the filtered out stories
filteredItems <- filteredItems[lapply(filteredItems, is.null) == FALSE]

descPubDateTitles <- lapply(filteredItems, l_get_desc_pubDate_title)

titlesDataFrame <- as.data.frame(matrix(unlist(descPubDateTitles), nrow=length(unlist(descPubDateTitles[1]))))
titlesDataFrame <- t(titlesDataFrame) #turn it into a dataFrame

htmlPath <- 'p'
wordsHtml <- html_nodes(webpage, htmlPath)
commonWords <- html_text(wordsHtml)
commonWords <- commonWords[[2]]

commonWords <- strsplit(commonWords, '\n\t')
commonWords <- commonWords[[1]]
commonWords[[101]] <- "is" #Cleaned up
commonWords[[102]] <- "an"
commonWords[[103]] <- "are"

pureTitles <- t(titlesDataFrame)
pureTitles <- pureTitles[1,] #select first row

titleSplit <- strsplit(pureTitles[[1]], " ")
titleSplit <- titleSplit[[1]]

charVectors <- lapply(pureTitles, l_create_char_vector)

keyWords <- lapply(charVectors, l_get_uncommon_words) 
keyWords #FINAL

#RELEVANT FUNCTIONS
l_get_desc_pubDate_title <- function(item){ #takes item
  nodeSetDesc <- getNodeSet(item,'.//description')
  nodeSetPub <- getNodeSet(item, './/pubDate') #period isolates it
  nodeSetTitle <- getNodeSet(item, './/title')
  
  description <- xmlValue(nodeSetDesc[[1]])
  pubDate <- xmlValue(nodeSetPub[[1]])
  title <- xmlValue(nodeSetTitle[[1]])
  
  description <- l_subStr_desc(description)
  
  return(list("title" = title, "description" = description, "date" = pubDate))
  
}

l_filter_items <- function(item){
  if(has_description(item) == TRUE){
    return(item)
  }
}

l_subStr_desc <- function(string){
  end <- gregexpr(".<div", string)
  end <- end[[1]][[1]]
  description <- substr(string, 0, end)
  return(description)
}

is_empty <- function(string){
  return(string == "")
}

has_description <- function(item){
  nodeSet <- getNodeSet(item, './/description')
  node <- nodeSet[[1]]
  description <- xmlValue(node)
  return(!is_empty(l_subStr_desc(description)))
}

l_create_char_vector <- function(list){
  listSplit <- strsplit(list, " ")
  return(listSplit[[1]])
}

l_get_uncommon_words <- function(charVector){
  return(setdiff(charVector,commonWords))
}
