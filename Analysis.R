library(twitteR)
library(plyr)

searchResults
searchResults[[20]][[5]]
searchResults[[20]][[1]]$created

testResult <- searchTwitter(searchStrings[[2]], n = 500, since = Title2Date[[searchStrings[[2]]]])
testResult

testDataFrame <- twListToDF(testResult)
testDataFrame

testHours <- testDataFrame$created
typeof(testHours)

testHours <- lapply(testHours, l_get_hour_from_created)

testHoursStrings <- toString(testHours[c(1:500)])
testHoursStrings

hoursList <- strsplit(testHoursStrings, " ")
hoursList <- hoursList[[1]]

hoursList <- as.list(hoursList)
hoursList <- hoursList[c(FALSE,TRUE)] #Selectes the even indecies

hoursListFinal <- lapply(hoursList, l_get_hour_from_created)
hoursListFinal <- lapply(hoursListFinal, as.integer)
hoursListFinal #The final Integer List of hours 

tabulate(hoursListFinal)

hoursTable <- table(as.matrix(hoursListFinal))
hoursTable <- t(as.matrix(hoursTable))
hoursTable
sum(hoursListFinal == 4)

barplot(length(hoursListFinal))


l_get_hour_from_created <- function(created) {
  createdList <- as.list(strsplit(created, ':'))
  return(createdList[[1]][[1]])
  
}

