#install.packages("twitteR")
#install.packages(hashmap)
#library(twitteR)
#library(hashmap)

MONTHS <- list("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
MonthMap <- new.env(hash = TRUE)
list2env(
  setNames(
    as.list(1:12),
    MONTHS
  ),
  envir = MonthMap
) 

Title2Date <- new.env(hash = TRUE)
list2env(
  setNames(
    searchStrings,
    formatedDates
  ),
  envir = Title2Date
)


l_create_strings <- function(wordList) {
  return(paste(wordList, collapse = " "))
}
l_gather_tweets <- function(titleString) { #Takes in string list of titles
  searchDate <- Title2Date[[titleString]]
  #Returns a list of status objects
  return(searchTwitter(titleString, n = 30, since = searchDate))
  
}
l_format_dates <- function(descDateTitle) {
  dateUF <- descDateTitle$date
  dateList <- strsplit(dateUF, " ")
  dateList <- dateList[[1]]
  day <- dateList[[2]]
  month <- MonthMap[[dateList[[3]]]]
  year <- dateList[[4]]
  
  return(paste(year, month, day, sep = "-"))
}

setup_twitter_oauth(API_KEY, API_KEY_SECRET, 
                    ACCESS_TOKEN, ACCESS_TOKEN_SECRET)

searchStrings <- lapply(keyWords, l_create_strings)
formatedDates <- lapply(descPubDateTitles, l_format_dates)

searchResults <- lapply(searchStrings, l_gather_tweets) #Run Sparingly 



